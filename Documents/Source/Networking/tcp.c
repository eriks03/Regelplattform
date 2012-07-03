#include <common.h>
#include <slip.h>
#include <udp.h>
#include <ip.h>
#include <icmp.h>
#include <tcp.h>
#include <strings.h>
#include <delays.h>

extern WORD rxpos=0;
extern WORD txpos=0;
extern BYTE rxbuffer[];
extern BYTE txbuffer[];
tcphead tcph;
ipheader ip;
ipstats ipstat;
extern test;
extern ulong tcpcounter;
void tcp_header();
void tcp_checksum();
bit tcpoptions=0;
WORD tcpdatalen;
tcpt tcptx;
void www();
void show_stats();

/************************************************************************
 * void tcp_receive()
 * This function is called by the IP layer when a TCP packet is
 * received. It performs every essential task of the TCP layer.
 * Incoming flag bits are read and responses generated accordingly
 ***********************************************************************/
void tcp_receive()
{
	WORD tcpseq[2];
	BYTE applayer=0;
	BYTE n;
	tcpoptions=0;
	/* increment TCP statistics counter */
	ipstat.tcprx++;
	/* copy various fields of the TCP header */
	copy_rx_word(&tcph.src);
	copy_rx_word(&tcph.dest);
	copy_rx_word(&tcph.seq[0]);
	copy_rx_word(&tcph.seq[1]);
	copy_rx_word(&tcph.ack[0]);
	copy_rx_word(&tcph.ack[1]);
	copy_rx_byte(&tcph.headerlen);
	tcph.headerlen = tcph.headerlen>>4;
	copy_rx_byte(&tcph.flags);
	copy_rx_word(&tcph.windowsize);
	copy_rx_word(&tcph.chksum);
	copy_rx_word(&tcph.urgent);
	
	/* discard any TCP options */
	for (n=5;n<tcph.headerlen;n++)
	{
		SkipLong();
	}
	
	tcpdatalen = ip.totallen - IPSIZE - (WORD)(tcph.headerlen<<2);
	
	/* if a reset or a segment with only an ACK is received, do nothing */
	if (tcph.flags & RST || tcph.flags == ACK) {
		return;
	}
	
	/* segment contains a SYN flag so treat is as a connection request */
	if (tcph.flags & SYN) {
		/* take value of 32 bit counter as Initial Sequence Number */
		tcptx.seq[0] = (WORD)(tcpcounter>>16);
		tcptx.seq[1] = (WORD)tcpcounter;
		/* and ACK the client's ISN plus one, for the SYN */
		tcptx.ack[0] = tcph.seq[0];
		tcptx.ack[1] = tcph.seq[1]+1;
		
		/* a connection request for the web server port */
		if (tcph.dest == HTTP_PORT) {
			/* acknowledge it */
			tcptx.action = SYN|ACK;
			/* and set flag to send TCP options */
			tcpoptions=1;
		/* connection request for an unused port */
		} else {
			/* so reset it */
			tcptx.action = RST|ACK;
			/* and increment statistics counters */
			ipstat.dropped++;
			ipstat.tcpdrop++;
		}
	}
	/* client is closing the connection */
	else if (tcph.flags & FIN) {
		tcptx.seq[0] = tcph.ack[0];
		tcptx.seq[1] = tcph.ack[1];
		tcptx.ack[0] = tcph.seq[0];
		tcptx.ack[1] = tcph.seq[1]+tcpdatalen+1;
		tcptx.action = ACK;
	}
	else if (tcph.flags & ACK) {
		tcptx.seq[0] = tcph.ack[0];
		tcptx.seq[1] = tcph.ack[1];
		tcptx.ack[0] = tcph.seq[0];
		tcptx.ack[1] = tcph.seq[1]+tcpdatalen;
		
		if (!tcpdatalen) return;	/* if the segment contains no data
						 * no action is required */
	
		/* we shouldn't get to this stage  unless the destination port
		 * is the HTTP port, but check just in case */
		if (tcph.dest == HTTP_PORT) {
			www();		/* call the www function to read the request
					 * and add HTTP data to the transmit buffer */
		}
		return;
	}
	
	/* place tcp header starting at 20 */
	tcp_header();
	/* reset transmit buffer position */
	txpos=0;
	/* and place IP header at start */
	ip_header(PROTTCP);
	/* calculate the TCP checksum and insert into header */
	tcp_checksum();
	/* finally, call the SLIP layer to send out the packet */
	slip_send(txbuffer,ip.totallen);
}

/************************************************************************
 * void tcp_header()
 * adds a TCP header to the transmit buffer, this function is
 * called either by an application of the tcp_receive function
 * If requested, TCP options will be sent (only MSS)
 ***********************************************************************/
void tcp_header()
{
	txpos=IPSIZE;
	tx_word(tcph.dest);		// source port
	tx_word(tcph.src);		// destination port
	tx_word(tcptx.seq[0]);	// sequence number
	tx_word(tcptx.seq[1]);	//
	tx_word(tcptx.ack[0]);	// ack number
	tx_word(tcptx.ack[1]);	//
	if (tcpoptions) {
		tx_byte(0x60);		// data offset 0101 << 4
	} else {
		tx_byte(0x50);
	}
	tx_byte(tcptx.action);
	tx_word(WINDOWSIZE);	// window size
	tx_word(0);				// checksum
	tx_word(0);				// urgent pointer

	if (tcpoptions) {
		tx_byte(0x02);		// kind
		tx_byte(0x04);		// length
		tx_word(MSS);		// MSS
		ip.totallen=IPSIZE+TCPHSIZE+4;
	} else {
		ip.totallen=IPSIZE+TCPHSIZE;
	}
}

/************************************************************************
 * void www()
 * called by the TCP layer when a data segment is received
 * for the HTTP_PORT.
 * The HTTP request string is validated before the requested
 * filename is checked and responded to accordingly.
 * Requests for an unknown filename result in a 404
 ***********************************************************************/
void www()
{
	BYTE request[4];
	
	/* check the incoming packet is a GET request, this is the only type which will be dealt with
	 * so issue a Bad Request HTTP error on anything else */
	if (rx_byte() != 'G' || rx_byte() != 'E' || rx_byte() != 'T' || 
		rx_byte() != ' ' || rx_byte() != '/') {
		tcptx.action = FIN|PSH|ACK;
		tcp_header();
		/* add the response to the transmit buffer */
		q_string("HTTP/1.0 400 Bad Request\r\nContent-type: text/html\r\n\r\n",53);
		q_string("<html><head><title>Bad Request</title></head><body>",51);	
		q_string("<h2>Bad Request</h2>",20);
		q_string("The request could not be understood.",36);
		q_string("</body></html>",14);				
	} else {
		/* read the requested filename */
		copy_rx_byte(&request[0]);
		copy_rx_byte(&request[1]);
		copy_rx_byte(&request[2]);
		copy_rx_byte(&request[3]);
		
		tcptx.action = FIN|PSH|ACK;
		tcp_header();
		
		/* client requested /   */
		if (request[0] == ' ') {
			q_string("HTTP/1.0 200 OK\r\nContent-type: text/html\r\n\r\n",44);
			q_string("<html><head><title>TCP/IP Stack</title></head><body>",52);	
			q_string("<h2>Welcome!</h2>",17);
			q_string("<p>This is an httpd running on a minimal TCP/IP stack",53);
			q_string(" written by Stuart Haslam.</p>",30);
			q_string("<p>The implementation provides at least partial support ",56);
			q_string("for the following protocols: ",29);
			q_string("SLIP, IP, ICMP, UDP, TCP, TFTP, HTTP.",37);
			q_string("<p><a href=\"/1\">TCP/IP packet statistics</a></p>",48);
			q_string("</body></html>",14);
		}
		/* client requested /1   */
		else if (request[0] == '1' && request[1] == ' ') {
			show_stats();
		}
		/* client requested /1?c
		 * there are some repeated lines here to overcome a bug in the compiler */
		else if (request[0] == '1' && request[1] == '?' && request[2] == 'c') {
			ipstat.rxpackets=0;
			ipstat.rxpackets=0;
			ipstat.txpackets=0;
			ipstat.tcptx=0;
			ipstat.tcprx=0;
			ipstat.udprx=0;
			ipstat.udptx=0;
			ipstat.icmprx=0;
			ipstat.icmptx=0;
			ipstat.icmpdrop=0;
			ipstat.tcpdrop=0;
			ipstat.udpdrop=0;
			ipstat.dropped=0;
			show_stats();
		}
		/* client requested unknown filename, send a 404 error */
		else {
			q_string("HTTP/1.0 404 Not Found\r\n\r\n",26);
			q_string("<html><head><title>TCP/IP Stack</title></head><body>",52);	
			q_string("<h2>404 - File Not Found!</h2>",30);
			q_string("The requested file could not be found.",38);
			q_string("<p><a href=\"/\">index</a></p>",28);
			q_string("</body></html>",14);	
		}
	}
	
	ip.totallen=txpos;	/* set length of outgoing packet */

	txpos=0;		/* reset transmit buffer position */
	ip_header(PROTTCP);	/* and place IP header at start */
	txpos+=20;
	
	tcp_checksum();	
	slip_send(txbuffer,ip.totallen);
}

/************************************************************************
 * void show_stats()
 * simple function to add HTTP headers and HTML content to the transmit
 * buffer, to display some basic packet statistics.
 ***********************************************************************/
void show_stats()
{
	q_string("HTTP/1.0 200 OK\r\nContent-type: text/html\r\n\r\n",44);
	q_string("<html><head><title>TCP/IP Stack</title>",39);
	q_string("<style>td{text-align:center;background-color:white}",51);
	q_string("th{background-color:#cccccc}</style>",36);
	q_string("</head><body>",13);	
	q_string("<h2>Packet Statistics</h2>",26);
	q_string("<table bgcolor=\"#000000\" cellspacing=1 cellpadding=7><tr>",57);
	q_string("<th>&nbsp;</th><th>Received</th><th>Transmitted</th><th>Dropped</th></tr>",73);
	q_string("<tr><th>Total</th><td>",22);
	q_num(ipstat.rxpackets);
	q_string("</td><td>",9);
	q_num(ipstat.txpackets);
	q_string("</td><td>",9);
	q_num(ipstat.dropped);
	q_string("</td></tr>",10);
	
	q_string("<tr><th>ICMP</th><td>",21);
	q_num(ipstat.icmprx);
	q_string("</td><td>",9);
	q_num(ipstat.icmptx);
	q_string("</td><td>",9);
	q_num(ipstat.icmpdrop);
	q_string("</td></tr>",10);
	
	q_string("<tr><th>UDP</th><td>",20);
	q_num(ipstat.udprx);
	q_string("</td><td>",9);
	q_num(ipstat.udptx);
	q_string("</td><td>",9);
	q_num(ipstat.udpdrop);
	q_string("</td></tr>",10);
			
	q_string("<tr><th>TCP</th><td>",20);
	q_num(ipstat.tcprx);
	q_string("</td><td>",9);
	q_num(ipstat.tcptx);
	q_string("</td><td>",9);
	q_num(ipstat.tcpdrop);
	q_string("</td></tr>",10);
			
	q_string("</table>",8);
	q_string("<p><a href=\"/\">index</a> - ",27);
	q_string("<a href=\"/1?c\">clear stats</a></p>",34);
	q_string("</body></html>",14);	
}

/************************************************************************
 * void tcp_checksum()
 * calculates the internet checksum of the packet waiting in the
 * transmit buffer, and inserts it into the header field
 ***********************************************************************/
void tcp_checksum()
{
	WORD csum;
	bool odd=0;
	/* increment transmit counter */
	ipstat.tcptx++;
	txpos=ip.totallen;
	
	/* odd length, so add pad byte */
	if (ip.totallen % 2) {
		tx_byte(0x00);
		odd=1;
	}
	/* add parts of pseudo header */
	tx_byte(IP1);
	tx_byte(IP2);
	tx_byte(IP3);
	tx_byte(IP4);
	tx_byte(ip.destaddr[0]);
	tx_byte(ip.destaddr[1]);
	tx_byte(ip.destaddr[2]);
	tx_byte(ip.destaddr[3]);
	tx_word(PROTTCP);
	tx_word(ip.totallen-IPSIZE);
	
	/* length is total length minus length of IP header (20)
	 * plus length of TCP pseudo header (12) */
	csum = chksm(&txbuffer[20],ip.totallen-8+odd);
	put_checksum(csum,&txbuffer[IPSIZE+16]);
}


