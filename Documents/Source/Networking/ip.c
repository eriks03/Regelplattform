#include <common.h>
#include <slip.h>
#include <ip.h>
#include <icmp.h>
#include <udp.h>
#include <tcp.h>

ipheader ip;
ipstats ipstat;
WORD rxpos=0;
WORD txpos=0;
WORD datalen;
extern BYTE rxbuff[];
extern BYTE txbuffer[];
WORD ipid=1;

/* ************************************************************************
 * void ip_receive()
 * process the IP header, storing any required values in global
 * memory before passing control over to the next layer
 ************************************************************************/
void ip_receive()
{
	WORD ch;
	BYTE tempb;
	BYTE flags;
	BYTE proto;
	WORD offset;
	BYTE version;
	BYTE headerlen;
	BYTE n;
	/* increment receive statistics counter */
	ipstat.rxpackets++;
	/* place circular buffer pointer at start of buffer */
	rxpos=0;
	
	/* copy byte from receive buffer */
	copy_rx_byte(&tempb);
	/* retrieve version number */
	version = tempb >> 4;
	/* and discard the datagram if it's not v4 */
	if (version != 4)
	{
		ipstat.dropped++;
		return;
	}

	/* mask off upper four bits and store
	 * the ip header length for later use */
	headerlen = tempb & 15;
	/* discard the TOS */
	discard_byte();
	/* store the total length of the IP datagram
	 * to be read later by other protocols */
	copy_rx_word(&ip.totallen);
	/* discard the IPID */
	discard_word();
	
	/* read the 3 bit flags and 15 bit offset */
	copy_rx_byte(&tempb);
	flags = (tempb>>5);
	tempb &= 0x1F;
	copy_rx_byte(&offset);
	offset = ((WORD)tempb<<8)|offset;
	
	/* discard the datagram if it is fragmented
	 * (sometimes have unexpected problems with this) */
	if (offset || (flags & 0x01)) {
		ipstat.dropped++;
		return;
	}
	
	/* discard TTL field */
	discard_byte();
	/* store protocol field for demultiplexing later */
	copy_rx_byte(&proto);
	/* and just skip past the checksum */
	discard_word();
	/* copy the source address, to be used
	 * as the destination address of the next outgoing packet */
	copy_rx_byte(&ip.destaddr[0]);
	copy_rx_byte(&ip.destaddr[1]);
	copy_rx_byte(&ip.destaddr[2]);
	copy_rx_byte(&ip.destaddr[3]);
	
	/* ensure the destination address of incoming datagram
	 * matches the preconfigured address of the device
	 * otherwise, drop the datagram */
	if (rx_byte() != IP1 || rx_byte() != IP2 ||
		rx_byte() != IP3 || rx_byte() != IP4)
	{
		ipstat.dropped++;
		return;
	}
	
	/* options will come next, but we just want to discard them */
	for (n=5;n<headerlen;n++)
	{
		SkipLong();
	}
		
	/* length of data (everything after the header)
	 * totallen in 8 bits - headerlen in 32 bits, so multiply by 4 */
	datalen = ip.totallen - (headerlen<<2);

	/* calculate the checksum of the IP header */
	ch = chksm(&rxbuff[0],20);
	/* and silently drop tha packet if the checksum found to be incorrect */
	/* (sometimes problems here too..) */
	if (~ch != 0xFFFF)
	{
		ipstat.dropped++;
		return;
	}
	
	/* check the protocol field and pass to
	 * the appropriate higher layer, or discard */
	switch (proto)
	{
		case PROTICMP:
			icmp_receive();
			break;
		case PROTUDP;
			udp_receive();
			break;
		case PROTTCP:
			tcp_receive();
			break;
		default:
			break;
	}
}

/************************************************************************
 * void ip_header()
 * place an IP header in the transmit buffer, this is called by
 * the transport layer protocols (or ICMP)
 ***********************************************************************/
void ip_header(BYTE proto)
{
	WORD chk;
	
	/* type = 4, headerlen = 5 */
	tx_byte(0x45);
	/* Type of Service */
	tx_byte(0x00);	
	tx_word(ip.totallen);
	
	tx_word(ipid++);
	
	tx_byte(0x00);		/* flags and */
	tx_byte(0x00);		/* offset */
	tx_byte(0x40);		/* TTL - 64 */
	tx_byte(proto);		/* protocol */
	tx_byte(0x00);		/* checksum, 0 for now */
	tx_byte(0x00);		/* checksum too */
	tx_byte(IP1); 		/* source IP address */
	tx_byte(IP2);		/* the value of which is set */
	tx_byte(IP3);		/* in common.h */
	tx_byte(IP4); 		
	tx_byte(ip.destaddr[0]); /* destination IP address */
	tx_byte(ip.destaddr[1]); /* copied from the source */
	tx_byte(ip.destaddr[2]); /* address of the last packet */
	tx_byte(ip.destaddr[3]);  
	
	/* insert the IP checksum into the correct position in the header
	 * (an IP checksum is only calculated on the header itself)
	 * IPSIZE is the length of the header, in bytes
	 * IPCHKPOS is the number of bytes into the header the checksum appears */
	chk = chksm(&txbuffer[0],IPSIZE);
	put_checksum(chk,&txbuffer[IPCHKPOS]);
}


