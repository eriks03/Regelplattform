/* 
 * U | A | P | R | S | F
 * R | C | S | S | Y | I
 * G | K | H | T | N | N
 */
#define URG	32
#define	ACK	16
#define	PSH	8
#define RST	4
#define SYN	2
#define FIN	1

#define HTTP_PORT 	80
#define	MSS			966
#define WINDOWSIZE	512
#define TCPHSIZE	20

void tcp_receive();

struct tcphead {
	WORD	src;
	WORD	dest;
	WORD	seq[2];
	WORD	ack[2];
	BYTE	flags;
	BYTE	headerlen;
	WORD	windowsize;
	WORD	chksum;
	WORD	urgent;
};

struct tcpt {
	WORD	seq[2];
	WORD	ack[2];
	BYTE	action;
};
