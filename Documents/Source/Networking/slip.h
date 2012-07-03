/* SLIP special character codes */
#define END		0xC0
#define ESC		0xDB
#define ESC_END		0xDC
#define ESC_ESC		0xDD

/* State of serial RX line */
#define RXIDLE		0
#define RXACTIVE	1
#define RXDONE		2
/* State of serial TX line */
#define TXIDLE		0
#define TXACTIVE	1
/* receive buffer length (128 bytes) */
#define RXMAXLEN	128
#define TXMAXLEN	1006

void slip_send(char *sp, WORD len);
void slip_recv();
void copy_rx_byte(BYTE *byte);
void copy_rx_word(WORD *word);
void discard_word();
void SkipLong();
void tx_byte(BYTE sbyte);
void tx_word(WORD sword);
BYTE rx_byte();
