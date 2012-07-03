/* #define UDPCHKSUM	1 */
#define UDPHSIZE	8

#define TFTP_READ	0x01
#define TFTP_WRITE	0x02
#define TFTP_DATA	0x03
#define TFTP_ACK	0x04
#define TFTP_ERR	0x05

void udp_receive();
void udp_send(WORD datalength, BYTE ephemeral);
void tftp(void);
void q_string(char *string, BYTE len);
void q_num(WORD var);

struct udphead {
	WORD	src;
	WORD	dest;
	WORD	len;
	WORD	chksum;
};

struct udpseudo {
	ulong	src;
	ulong	dest;
	BYTE	proto;
	WORD	len;
};
