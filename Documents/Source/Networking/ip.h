#include <common.h>

/* size of the IP header, in bytes */
#define 	IPSIZE 		20
#define		IPCHKPOS	10

/* possible values for the protocol field in the IP header
 * there are many others, but we're not concerned with those */
#define		PROTICMP	1
#define		PROTTCP		6
#define		PROTUDP		17

/* functions */
void ip_receive();
void ip_header(BYTE proto);
WORD local_port();


/* ----------------------------------------------------------------
 * |  VER    |      HL  |      TOS      |         TL         |
 * ----------------------------------------------------------------
 * |              ID               | FLG |           FRAG         |
 * ----------------------------------------------------------------
 * |      TTL      |      PROT     |            CHECKSUM          |
 * ----------------------------------------------------------------
 * |                           SRCADDR                            |
 * ----------------------------------------------------------------
 * |                           DSTADDR                            |
 * ----------------------------------------------------------------
 * |                           OPTIONS                            |
 * ----------------------------------------------------------------
 * |                            DATA..                            |
 * 
 * BYTE  -> unsigned char
 * WORD  -> unsigned int
 * ulong -> unsigned long
 */
struct ipheader {
	WORD	totallen;	/* 16 bit Total Length */
	BYTE	destaddr[4];	/* 32 bit Destination Address */
};

/* ipheader ip; */

struct ipstats {
	WORD	rxpackets;
	WORD	txpackets;
	BYTE	dropped;
	WORD	icmprx;
	WORD	icmptx;
	WORD	icmpdrop;
	WORD	tcprx;
	WORD	tcptx;
	BYTE	tcpdrop;
	WORD	udprx;
	WORD	udptx;
	BYTE	udpdrop;
};

