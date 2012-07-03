#include <common.h>
#include <slip.h>
#include <ip.h>
#include <icmp.h>

unsigned char rxstate=RXIDLE;
unsigned int received=0;

BYTE rxbuff[RXMAXLEN];
/* #pragma locate rxbuffer 0x300;  Locates the array in 3rd RAM page */
BYTE txbuffer[TXMAXLEN];
/* #pragma locate txbuffer 0x400; */

extern WORD rxpos;
extern WORD txpos;

ipstats ipstat;

/******************************************************************************
 * Sends a packet of length "len", starting at location "p"
 * assumes the entire packet is stored in data memory
 * This function is an addaptation of the send_packet() function given
 * as an example in the SLIP RFC - 1055
 *****************************************************************************/
void slip_send(char *p, WORD len)
{
	/* toggle activity LED */
	LEDPORT^=(1<<LEDBIT);
	/* increment transmit stats counter */
	ipstat.txpackets++;
	
	/* add END (0300) to transmit buffer
	 * to clear possible noise between packets */
	AddTx(END);
        
	/* send each byte in turn, escaping where necessary */
	while (len--)
	{
		switch (*p)
		{
			/* swap END for ESC followed by ESC_END */
			case END:
				AddTx(ESC); AddTx(ESC_END);
				break;
			/* swap ESC for ESC followed by ESC_ESC */
			case ESC:
				AddTx(ESC); AddTx(ESC_ESC);
				break;
			/* just send out any other character */
			default:
				AddTx(*p);
				break;
		}
		p++;
	}
	/* send END to indicate end of packet */
	AddTx(END);
	
}

/*********************************************************************************
 * Reads a byte from the USART buffer, demultiplexing it according
 * to the SLIP RFC. This function will not return until the USART buffer
 * is empty.
 *******************************************************************************/
void slip_recv()
{
	BYTE c;
	/* toggle activity LED */
	LEDPORT^=(1<<LEDBIT);

	/* line is idle, this is the first byte
	 * if it's not an END, then it must be noise */
	if (rxstate == RXIDLE)
	{
		/* read the first byte */
		c = WaitRx();
		/* noise - ignore */
		if (c != END) return;
		/* set state flag to indicate 
		 * reception is in the middle of a packet */
		rxstate = RXACTIVE;
	}
	
	while (1)
	{
		/* zero bytes in buffer, don't really want to 'Wait' for a byte to
		 * appear if we could be doing something else instead */
		if (!GetRxSize()) return;
		/* get next byte from RX buffer */
		c = WaitRx();
	
		switch(c)
		{
			case END:
				/* got an END byte while in the middle of a packet - must 
				 * be the end */
				if (received) {
					rxstate = RXDONE;
					received=0;
					return;
				} else {
					break;
				}
			case ESC:
				/* need to know the next byte to decide what
				 * the original byte was */
				c = WaitRx();
				
				switch(c) {
					case ESC_END:
						c = END;
						break;
					case ESC_ESC:
						c = ESC;
						break;
				}
			default:
				/* the packet is too long */
				if (received == RXMAXLEN) {
					/* wait for END byte
					 * don't do anything with the data we receive now */
					while (WaitRx() != END) { }
					/* line goes idle again - ready for next packet */
					received = 0;
					rxstate = RXDONE;
					return;
				} else {
					/* place received byte in memory buffer */
					rxbuff[received++] = c;
				}
				break;
		}
	}
}

/************************************************************************
 * void copy_rx_byte(BYTE *byte)
 * copy a single byte from the receive buffer to the memory
 * location indicated by *byte
 * This function is used when a value from the receive buffer
 * must be saved for future use.
 ***********************************************************************/
void copy_rx_byte(BYTE *byte)
{
	*byte = rxbuff[rxpos++];
}

/************************************************************************
 * void copy_rx_word(WORD *word)
 * copy a 16-bit word from the receive buffer to the memory location
 * indicated by *word
 ***********************************************************************/
void copy_rx_word(WORD *word)
{
	BYTE high,low;
	/* 8 high bits into 8 bit long variable */
	high = rxbuff[rxpos++];
	/* 8 lower bits */
	low = rxbuff[rxpos++];
	
	/* cast to 16 bit length, move high up to higher bits and
	 * OR with low bits */
	*word = ((WORD)high<<8)|(WORD)low;
}

/************************************************************************
 * BYTE rx_byte()
 * reads a byte from the receive buffer and returns it
 * used mainly for comparisons, where the value need not
 * be retained.
 ***********************************************************************/
BYTE rx_byte()
{
	return rxbuff[rxpos++];
}


/************************************************************************
 * void discard_word()
 * move receive buffer pointer along to ignore unwanted stuff
 ***********************************************************************/
void discard_word()
{
	rxpos += 2;
}

/************************************************************************
 * Skip a 32 bit value from the receive buffer
 * this is used to ignore IP header options and such
 * should maybe recalculate the checksum here.. incrementally
 ***********************************************************************/
void SkipLong()
{
	rxpos += 4;
}

/************************************************************************
 * void tx_byte(BYTE sbyte)
 * add a single byte to the transmit buffer, if there's room
 ***********************************************************************/
void tx_byte(BYTE sbyte)
{
	if (txpos <= TXMAXLEN)
		txbuffer[txpos++] = sbyte;
}

/************************************************************************
 * void tx_word(WORD sword)
 * add a 16 bit word to the transmit buffer
 ***********************************************************************/
void tx_word(WORD sword)
{
	txbuffer[txpos++] = (BYTE)(sword>>8);
	txbuffer[txpos++] = (BYTE)sword;
}
