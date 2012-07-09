/*
 * ip4.h
 *
 *  Created on: Jul 2, 2012
 *      Author: eriks
 */

#ifndef IP4_H_
#define IP4_H_

//#include "networkcfg.h"
//#include "ethernet.h"
#include "icmp.h"
#include "arp.h"

#define IP4_IGMP 0x01

struct ip4_header
{
	char  VerIHL;
	char  TypeOfService;
	short TotalLength;
	short Identification;
	short FlagsFragOffset;
	char  TTL;
	char  Protocol;
	short HeaderChksm;
	ip_addr_t   SrcAddr;
	ip_addr_t   DstAddr;
};

typedef struct ip4_header IP4Header_t;

void ParseIP4Header(u8 *Buffer);
void SendIP4Package(ip_addr_t DstIPAddress, u8 *Payload, int PayloadLength, u8 Protocol);

#endif /* IP4_H_ */
