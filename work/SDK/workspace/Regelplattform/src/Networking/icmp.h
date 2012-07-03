/*
 * icmp.h
 *
 *  Created on: Jul 2, 2012
 *      Author: eriks
 */

#ifndef ICMP_H_
#define ICMP_H_

#include "ip4.h"

struct icmp_header
{
	char  Type;
	char  Code;
	short Chksm;
	short Identifier;
	short SequenceNumber;
};

typedef struct icmp_header ICMPHeader_t;

void SendICMPReply(u8 *ICMPRequest, int RequestLength, ip_addr_t DstAddr);
void ParseICMPMessage(u8 *Buffer, int BufLength, ip_addr_t SrcAddr);

#endif /* ICMP_H_ */
