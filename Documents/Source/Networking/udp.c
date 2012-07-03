#include <common.h>
#include <slip.h>
#include <udp.h>
#include <ip.h>
#include <icmp.h>
#include <strings.h>

#define TFTP_PORT 69

extern WORD rxpos=0;
extern WORD txpos=0;
extern BYTE rxbuffer[];
extern BYTE txbuffer[];
WORD localport=1100;
struct udphead udph;
struct ipheader ip;
ipstats ipstat;
BYTE test;

/************************************************************************
 * void udp_receive()
 * This function is called by the IP layer when a UDP packet is
 * received. It saves the source and destination port numbers
 * before demultiplexing and passing to the application if required
 ***********************************************************************/
void udp_receive()
{
	/* read the UDP header */
	/* save source and destination ports */
	copy_rx_word(&udph.src);
	copy_rx_word(&udph.dest);
	/* discard the UDP length, the IP totallength will do */
	discard_word();
	/* and discard the checksum */
	discard_word();

	/* increment stats counter */
	ipstat.udprx++;
	/* put transmit buffer pointer and start of application data */
	txpos=IPSIZE+UDPHSIZE;
	
	/* demultiplex destination ports with applications */
	if (udph.dest == TFTP_PORT || udph.dest == localport) {
		tftp();
	/* any UDP packets for unused ports are dropped */
	} else {
		ipstat.dropped++;
		ipstat.udpdrop++;
	}
}

/************************************************************************
 * void udp_send(WORD datalength)
 * This function is called by the application to send a UDP
 * packet. Values from global variables, common memory
 * space and the passed data length are used.
 * Optionally, a pseudo header is constructed and the UDP
 * checksum calculated.
 ***********************************************************************/
void udp_send(WORD datalength, BYTE ephemeral)
{
	WORD cssum;
	
	ipstat.udptx++;
	/* total size of IP datagram is the size of IP header */
	/* plus UDP header, plus UDP data */
	ip.totallen=IPSIZE+UDPHSIZE+datalength;
	/* place IP header and start of trasnmit buffer */
	txpos=0;
	ip_header(PROTUDP);
	/* use an ephemeral source port, this depends on the
	 * application, and must be specified when calling
	 * the function */
	if (ephemeral) tx_word(local_port());
	else tx_word(udph.dest);
	/* destination port, as source port from incoming packet */
	tx_word(udph.src);
	/* UDP length, header length plus data length */
	tx_word(UDPHSIZE+datalength);
	/* UDP checksum */
	tx_word(0x00);
	
	/* UDP checksumming is specified at compile time
	 * if checksumming is disabled, a zero value is sent
	 * otherwise the pseudo header is added and checksummed
	 * but NOT sent */
	#ifdef UPDCHECKSUM
		txpos+=datalength;
		tx_byte(IP1);
		tx_byte(IP2);
		tx_byte(IP3);
		tx_byte(IP4);
		tx_byte(ip.destaddr[0]);
		tx_byte(ip.destaddr[1]);
		tx_byte(ip.destaddr[2]);
		tx_byte(ip.destaddr[3]);
		tx_byte(0x00);
		tx_byte(PROTUDP);
		tx_word(10+udpdatal);
		
		cssum = chksm(&txbuffer[20],8+datalength+12);
		put_checksum(cssum,&txbuffer[IPSIZE+6]);
	#endif
	
	/* call SLIP to send out the packet */
	slip_send(txbuffer,IPSIZE+UDPHSIZE+datalength);
}

/************************************************************************
 * void q_string(char *string, BYTE len)
 * add a string of length len to the transmit buffer starting
 * from memory location *string
 ***********************************************************************/
void q_string(char *string, BYTE len)
{
	while (len--)
		txbuffer[txpos++] = *string++;
}

/************************************************************************
 * void q_num(WORD var)
 * convert an integer to a character string and add to output buffer
 * (bit of a work-around to get around a compiler problem)
 ***********************************************************************/
void q_num(WORD var)
{
	BYTE temp[10];
	BYTE show=1;
	BYTE count=temp;
	
	/* find the width of the number */
	while ((count /= 10) >= 1) show++;
	/* do the conversion to a string */
	lPrtString(temp,var);
	/* add string to output buffer */
	q_string(temp,show);
}

/************************************************************************
 * void tftp()
 * Simple application layer server to return data
 * The only functionality provided is reading, and only one 'file'.
 * this function doesn't need to know anything about buffer
 * positions, it simply uses functions provided by the IP layer.
 ***********************************************************************/
void tftp()
{
	WORD opcode;
	/* read the operation code */
	copy_rx_word(&opcode);
	/* read request */
	if (opcode == TFTP_READ) {
		/* check the requested filename is 'stats' */
		if (rx_byte() == 's' && rx_byte() == 't' && rx_byte() == 'a' &&
			rx_byte() == 't' && rx_byte() == 's' && rx_byte() == 0x00)
		{
			tx_word(TFTP_DATA);	/* op code */
			tx_word(0x0001);	/* block number */
			q_string("   IP Statistics   \n\n",21);
			q_string("Received:\t",10);
			q_num(ipstat.rxpackets);		
			q_string("\nTransmitted:\t",14);
			q_num(ipstat.txpackets);
			q_string("\nDropped:\t",10);
			q_num(ipstat.dropped);
			q_string("\n\n",2);
		}
		/* requested a different file, not found */
		else {
			tx_word(TFTP_ERR);
			tx_word(0x0001);
			q_string("File Not Found.",15);
			tx_byte(0x00);
		}
		udp_send(txpos-IPSIZE-UDPHSIZE,1);
	}
	/* write request, send error code and message */
	else if (opcode == TFTP_WRITE) {
		tx_word(TFTP_ERR);
		tx_word(0x0002);
		q_string("Access Violation.",17);
		tx_byte(0x00);
		udp_send(txpos-IPSIZE-UDPHSIZE,1);
	}
}

/************************************************************************
 * WORD local_port()
 * return a number to be used as the local port
 ***********************************************************************/
WORD local_port()
{
	if (localport == 5000) localport = 1100;
	return localport++;
}
