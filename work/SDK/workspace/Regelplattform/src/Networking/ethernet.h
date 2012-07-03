/*
 * ethernet.h
 *
 *  Created on: Jun 27, 2012
 *      Author: eriks
 */

#ifndef ETHERNET_H_
#define ETHERNET_H_

#include <stdio.h>
#include "xemaclite.h"
#include "networktypes.h"

#define ETH_TYPE_IP4 0x0800
#define ETH_TYPE_ARP 0x0806

XEmacLite eth_handle;

struct EthernetHeader
{
	MACAddr_t DstAddr;
	MACAddr_t SrcAddr;
	short	  TypeField;
};

typedef struct EthernetHeader eth_header_t;

/*
 * Set up valid local and remote MAC addresses. This loop back test uses the
 * LocalAddress both as a source and destination MAC address.
 */
//static u8 RemoteAddress[XEL_MAC_ADDR_SIZE] =
//{
//	0xD4, 0x9A, 0x20, 0xBB, 0x65, 0x5E
//};
//
static u8 LocalAddress[XEL_MAC_ADDR_SIZE] =
{
	0x00, 0x0A, 0x35, 0x01, 0x02, 0x03
};

static MACAddr_t LocalMacAddr = {0x00, 0x0A, 0x35, 0x01, 0x02, 0x03};
static MACAddr_t RemoteMacAddr = {0xD4, 0x9A, 0x20, 0xBB, 0x65, 0x5E};
static MACAddr_t BroadcastMacAddr = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};

typedef u8 EthernetFrame[XEL_MAX_FRAME_SIZE];

EthernetFrame TxFrame[XEL_MAX_FRAME_SIZE];
EthernetFrame RxFrame[XEL_MAX_FRAME_SIZE];



int EmacLiteSendFrame(u8 *Payload,  u32 PayloadSize, MACAddr_t *DstMACAddr, short Type);
int cmp_mac_addresses(MACAddr_t *MacAddr1, MACAddr_t *MACAddr2);

void ParseEthernetFrame(u8* Buffer);

#endif /* ETHERNET_H_ */
