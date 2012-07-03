#include <common.h>
#include <ip.h>
#include <strings.h>
#include <slip.h>
#include <icmp.h>

extern BYTE rxbuffer[];
extern BYTE txbuffer[];
extern WORD rxpos;
extern WORD txpos;
extern WORD datalen;

ipstats ipstat;

/*************************************************************************
 * void icmp_receive()
 * this function is called by the IP layer on reception of an ICMP
 * packet, only an echo request is responded to
 ************************************************************************/
void icmp_receive()
{
	WORD checks;
	/* increment ICMP stats counter */
	ipstat.icmprx++;
	/* if it's an ICMP type 8, echo request */
	if (rx_byte() == 8)
	{
		/* we need to begin copying ICMP data straight after the checksum
		 * word - ID and sequence are sent back unchanged, along with the 
		 * payload itself */
		discard_byte();		/* code */
		discard_byte();		/* checksum */
		discard_byte();		/* checksum */
		/* add the IP header to the transmit buffer */
		ip_header(PROTICMP);		
				
		tx_byte(0x00);	/* type 0 - Echo Reply */
		tx_byte(0x00);	/* code */
		/* the checksum field must be set to zero before calculating the
		 * checksum value */
		tx_byte(0x00);	/* checksum */
		tx_byte(0x00);	/* checksum */
		/* copy the ICMP data over to the transmit buffer */
		while (rxpos <= (IPSIZE+datalen))
		{
			copy_rx_byte(&txbuffer[txpos++]);
		}
		
		/* ICMP checksum - checksum of header and data
		 * start directly after IP header for, until end of IP packet
		 * stick the result starting 2 bytes into ICMP */
		checks = chksm(&txbuffer[IPSIZE],datalen);
		put_checksum(checks,&txbuffer[IPSIZE+2]);
		/* call SLIP to send the reply out */
		slip_send(&txbuffer,(IPSIZE+datalen));
		ipstat.icmptx++;
	} else {
		ipstat.icmpdrop++;
	}
}

void discard_byte()
{
	rxpos++;
}

/************************************************************************
 * WORD chksum(WORD *startpos, WORD checklen)
 * returns a standard internet checksum calculation of "checklen"
 * bytes from the transmit buffer, starting at "startpos"
 ***********************************************************************/
WORD chksm(WORD *startpos, WORD checklen)
{
	ulong sum = 0;
	WORD answer = 0;

	while (checklen > 1)
	{
		sum += *startpos++;
		checklen -= 2;
	}

	if (checklen == 1)
	{
		*(BYTE *)(&answer) = *(BYTE *)startpos;
		sum += answer;
	}

	sum = (sum >> 16) + (sum & 0xffff);
	sum += (sum >> 16);
	answer = ~sum;
	
	return answer;
}

void put_checksum(WORD check, WORD *put)
{
	*put = check;
}
