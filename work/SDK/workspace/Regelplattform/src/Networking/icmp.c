/*
 * icmp.c
 *
 *  Created on: Jul 2, 2012
 *      Author: eriks
 */

#include "icmp.h"
#include "ip4.h"

void SendICMPReply(u8 *ICMPRequest, int RequestLength, ip_addr_t DstIPAddr)
{
	u8 DataBuffer[XEL_MAX_FRAME_SIZE - XEL_HEADER_SIZE - 20];

	ICMPHeader_t icmp_header;
	ICMPHeader_t *icmp_request;

	u8 *BufferPtr;
	u8 *HeaderPtr;
	BufferPtr = (u8 *)DataBuffer;

	icmp_request = (ICMPHeader_t *)ICMPRequest;

	int i = 0;

	icmp_header.Type = 0x00;
	icmp_header.Code = 0x00;
	icmp_header.Chksm = 0x0000;
	icmp_header.Identifier = icmp_request->Identifier;
	icmp_header.SequenceNumber = icmp_request->SequenceNumber;

	HeaderPtr = (u8 *)&icmp_header;

	for (i = 0; i < 8; i++)
	{
		*BufferPtr++ = HeaderPtr[i];
	}

//	 HeaderPtr = ICMPRequest;
//	*BufferPtr++ = 0x00;
//	*BufferPtr++ = 0x00;
//	*((u16 *)BufferPtr) = 0x0000; // ToDo calc correct Checksum
//	BufferPtr++;
//	BufferPtr++;

	HeaderPtr = (u8 *)icmp_request;
	HeaderPtr += 8;

	for (i = 0; i < RequestLength - 4; i++)
	{
		*BufferPtr++ = HeaderPtr[i];
	}

	SendIP4Package(DstIPAddr, (u8 *)DataBuffer, RequestLength, 0x01);
}

void ParseICMPMessage(u8 *Buffer, int BufLength, ip_addr_t SrcAddr)
{
	ICMPHeader_t *icmp_header;

	icmp_header = (ICMPHeader_t *)Buffer;

	if (icmp_header->Type == 0x08)
	{
		SendICMPReply(Buffer, BufLength, SrcAddr);
	}
}
