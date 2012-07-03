void icmp_receive();
void discard_byte();
WORD chksm(unsigned int *startpos, WORD checklen);
void put_checksum(WORD check, WORD *putstart);

/* ----------------------------------------------------------------
 * |    TYPE      |      CODE      |         CHECKSUM             |
 * ----------------------------------------------------------------
 * |          IDENTIFIER           |        SEQUENCE NUMBER       |
 * ----------------------------------------------------------------
 * |    DATA ....
 * ---------------- */

struct icmpheader {
	BYTE	type;
	BYTE	code;
	WORD	chksum;
	WORD	id;
	WORD	seq;
};
