/*
 * arp.c
 *
 *  Created on: Jun 27, 2012
 *      Author: eriks
 */

#include "arp.h"
#include "networkcfg.h"

int SendArpPacket(ip_addr_t *DstIPAddress, MACAddr_t *DstMACAddress, unsigned short PackageType)
{
	arp_pkg_t arp_pkg;

	MACAddr_t broadcast = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};


	arp_pkg.src_mac_addr = LocalMacAddr;

	if (PackageType == ARP_OPERATION_REQUEST)
	{
		arp_pkg.dst_mac_addr = broadcast;
		arp_pkg.operation = ARP_OPERATION_REQUEST;
	}
	else if (PackageType == ARP_OPERATION_REPLY)
	{
		arp_pkg.dst_mac_addr = *DstMACAddress;

		arp_pkg.operation = ARP_OPERATION_REPLY;
	}

	arp_pkg.hw_addr_size = ARP_HARDWARE_ADR_SIZE_ETH;
	arp_pkg.pr_addr_size = ARP_PROTOCOL_ADR_SIZE_IP4;
	arp_pkg.hw_addr_type = ARP_HARDWARE_ADR_TYPE_ETH;
	arp_pkg.pr_addr_type = ARP_PROTOCOL_ADR_TYPE_IP4;


	arp_pkg.src_ip_addr.byte1 = 192;
	arp_pkg.src_ip_addr.byte2 = 168;
	arp_pkg.src_ip_addr.byte3 = 1;
	arp_pkg.src_ip_addr.byte4 = 10;

	arp_pkg.dst_ip_addr = *DstIPAddress;

	//xil_printf("sending package\n");
	EmacLiteSendFrame((u8 *)&arp_pkg, XEL_HEADER_SIZE + ARP_SIZE, &arp_pkg.dst_mac_addr, 0x806);

	//xil_printf("package sent\n");
	return 0;
}


int IsMacInCache(MACAddr_t *MacAddress)
{
	int i = 0;
    MACAddr_t CacheMacAddr;

	for (i = 0; i < ARP_CACHE_SIZE; i++)
	{
		CacheMacAddr = arp_cache[i].dst_mac_addr;

		if (cmp_mac_addresses(&CacheMacAddr, MacAddress) == 1)
		{
			return 1;
		}
	}

	return 0;
}

/*
 * Init ARP Cache with empty entries
 */
void initArpCache()
{
	int i = 0;
	arp_cache_entry_t cache_entry;

	cache_entry.dst_ip_addr.byte1 = 0;
	cache_entry.dst_ip_addr.byte2 = 0;
	cache_entry.dst_ip_addr.byte3 = 0;
	cache_entry.dst_ip_addr.byte4 = 0;

	cache_entry.dst_mac_addr.byte1 = 0x00;
	cache_entry.dst_mac_addr.byte2 = 0x00;
	cache_entry.dst_mac_addr.byte3 = 0x00;
	cache_entry.dst_mac_addr.byte4 = 0x00;
	cache_entry.dst_mac_addr.byte5 = 0x00;
	cache_entry.dst_mac_addr.byte6 = 0x00;

	for(i = 0; i < ARP_CACHE_SIZE; i++)
	{
		arp_cache[i] = cache_entry;
	}
}

/*
 * Look if two IP Adresses are equal
 */
int cmp_ip_addresses(ip_addr_t *IPAddr1, ip_addr_t *IPAddr2)
{
	int Ptr1;
	int Ptr2;

	Ptr1 = *(int *)IPAddr1;
	Ptr2 = *(int *)IPAddr2;

	if (Ptr1 == Ptr2)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

void ParseArpPackage(u8 *Buffer)
{
	arp_pkg_t *arp_pkg;

	// for testing

	// end testing

	ip_addr_t RemoteIPAddr;

	Buffer += XEL_HEADER_SIZE;
	arp_pkg = (arp_pkg_t *)Buffer;

	RemoteIPAddr = arp_pkg->dst_ip_addr;

	if (arp_pkg->operation == ARP_OPERATION_REQUEST)
	{
		if (cmp_ip_addresses(&RemoteIPAddr, &LocalIPAddr) == 1)
		{
			SendArpPacket(&arp_pkg->src_ip_addr, &arp_pkg->src_mac_addr, ARP_OPERATION_REPLY);
		}
	}
}
