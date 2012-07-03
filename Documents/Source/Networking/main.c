#include <common.h>
#include <delays.h>
#include <slip.h>
#include <ip.h>
#include <strings.h>

const int TXBUFSZ=4;		/* transmit buffer size */
const int RXBUFSZ=32;		/* receive buffer size */
const int SERINTRATE=57600;	/* baud rate */
const int USEXON=0;		/* disable flow control */
unsigned char TxTab[TXBUFSZ];	/* transmit buffer */
unsigned char RxTab[RXBUFSZ];	/* receive buffer */
unsigned char RxSz,TxSz;	/* state of receive (RXIDLE, RXACTIVE, RXDONE) */
extern WORD txpos;		/* size of current TX/RX buffers */
extern unsigned char rxstate;
unsigned long tcpcounter=0;
void LED_flash(BYTE times);

ipstats ipstat;

void main()
{
	/* configures the function of the A/D port pins
	 * (ports A and E to digital I/Os) */
	ADCON1=7;		

	TRISD=0x0f;	/* 00001111 -> RD4:RD7 as outputs */
	TRISE=3;	/* 111 -> RE0:RE2 outputs */
	PORTE=4;
	PORTD=0;
	
	/* set the activity LED bit as an output */
	TRISC&=0xf7;
	/* make sure LED is off	*/
	LEDPORT|=0x08;
	/* then flash it 3 times */
	LED_flash(3);
	/* initialise USART interrupts */
	SerIntInit();

	/* enter main program loop */
	while(1)
	{
		/* There's a packet waiting in the buffer.. IP layer
		 * flag is set so we can return up the stack, rather than processing
		 * the packet within the interrupt routine */
		if (rxstate == RXDONE)
		{
			/* call on the IP layer to process awaiting packet */
			ip_receive();
			/* serial line IDLE again */
			rxstate=RXIDLE;
			/* packet has been sent */
			txpos=0;
		}

		/* Interrrupt routine has been trggered since last here, 
		 * there is at least one byte waiting in the USART receive
		 * buffer - call on the SLIP layer to process and add to
		 * stack buffer */
		if (GetRxSize()) slip_recv();
		
		/* ensure activity LED is off */
		LEDPORT|=0x08;
		
		/* TCP counter, used for Initial Sequence Numbers */
		if (tcpcounter == 2147483646) {
			tcpcounter=0;
		}
		tcpcounter++;
	}
}

void LED_flash(BYTE times)
{
	while(times--)
	{
		LEDPORT^=(1<<LEDBIT);
		Wait(200);
		LEDPORT^=(1<<LEDBIT);
		Wait(200);
	}
}

const int QuickInt=1;	/* Quick interrupts */

void Interrupt()	/* Interrupt handler */
{
	SerIntHandler();
}
