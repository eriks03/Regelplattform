/*
 * ip4.c
 *
 *  Created on: Jul 2, 2012
 *      Author: eriks
 */

#include "ip4.h"
#include "icmp.h"

void SendIP4Package(ip_addr_t DstIPAddress, u8 *Payload, int PayloadLength, u8 Protocol)
{
	u8 PackageBuffer[XEL_MAX_FRAME_SIZE - XEL_HEADER_SIZE];
	int i = 0;

	IP4Header_t ip4_header;

	ip4_header.VerIHL = 0x45; // ToDo make dynamic
	ip4_header.TypeOfService = 0x00; // ToDo make configurable through user
	ip4_header.TotalLength = 20 + PayloadLength;
	ip4_header.Identification = 0x0000;
	ip4_header.FlagsFragOffset = 0x0000;
	ip4_header.Protocol = Protocol;
	ip4_header.TTL = 0x80;
	ip4_header.HeaderChksm = 0x0000; // ToDo Calc Checksum
	ip4_header.DstAddr = DstIPAddress;
	ip4_header.SrcAddr = LocalAddr;

	u8 *HeaderPtr = (u8 *)&ip4_header;

	u8 *PackagePtr;
	PackagePtr = (u8 *)PackageBuffer;

	for (i = 0; i < 20; i++)
	{
		*PackagePtr++ = HeaderPtr[i];
	}

	for (i = 0; i < PayloadLength; i++)
	{
		*PackagePtr++ = Payload[i];
	}

	EmacLiteSendFrame((u8 *)PackageBuffer, 20 + PayloadLength, &RemoteMacAddr, 0x0800);
}

void ParseIP4Header(u8 *Buffer)
{
	IP4Header_t *ip4_header;

	Buffer += XEL_HEADER_SIZE;

	ip4_header = (IP4Header_t *)Buffer;

	//ip_addr_t LocalIPAddr = {192, 168, 1, 10};

	ip_addr_t RemoteIPAddr = ip4_header->DstAddr;

	if (cmp_ip_addresses(&RemoteIPAddr, &LocalAddr ) == 1)
	{
		if (ip4_header->Protocol == IP4_IGMP)
		{
			// xil_printf("IGMP_Protocol \n");
			Buffer += 20;
			ParseICMPMessage(Buffer, ip4_header->TotalLength - 20, ip4_header->SrcAddr);
		}

		// xil_printf("IP4 Type: %u\n", ip4_header->Protocol);
	}
}
