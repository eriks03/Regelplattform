/*
 * arp.h
 *
 *  Created on: Jun 27, 2012
 *      Author: eriks
 */

#ifndef ARP_H_
#define ARP_H_

#include "ethernet.h"
#include "networktypes.h"

#define ARP_HARDWARE_ADR_TYPE_ETH 	0x0001
#define ARP_PROTOCOL_ADR_TYPE_IP4 	0x0800
#define ARP_HARDWARE_ADR_SIZE_ETH 	0x06
#define ARP_PROTOCOL_ADR_SIZE_IP4 	0x04
#define ARP_OPERATION_REQUEST 		0x0001
#define ARP_OPERATION_REPLY  		0x0002

#define ARP_SIZE 28
#define ARP_CACHE_SIZE 2

struct arp_package
{
	short hw_addr_type;
	short pr_addr_type;
	char  hw_addr_size;
	char  pr_addr_size;
	short operation;
	MACAddr_t   src_mac_addr;
	ip_addr_t   src_ip_addr;
	MACAddr_t   dst_mac_addr;
	ip_addr_t   dst_ip_addr;
};

struct arp_cache_entry
{
	MACAddr_t	dst_mac_addr;
	ip_addr_t	dst_ip_addr;
};

typedef struct arp_cache_entry arp_cache_entry_t;
typedef struct arp_package arp_pkg_t;

arp_cache_entry_t arp_cache[ARP_CACHE_SIZE];

int SendArpPacket(ip_addr_t *DstIPAddress, MACAddr_t *DstMACAddress, unsigned short PackageType);
int IsMacInCache(MACAddr_t *MacAddress);
int IsIpInCache(ip_addr_t *IpAddress);

int cmp_ip_addresses(ip_addr_t *IPAddr1, ip_addr_t *IPAddr2);

void initArpCache();
void ParseArpPackage(u8 *Buffer);

#endif /* ARP_H_ */
