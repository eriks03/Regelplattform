/*
 * ethernet.c
 *
 *  Created on: Jun 27, 2012
 *      Author: eriks
 */

#include "ethernet.h"
#include "arp.h"
#include "ip4.h"

int i;

/******************************************************************************/
/**
*
* This function sends a frame of given size. This function assumes interrupt
* mode and sends the frame.
*
* @param	EmacLiteInstPtr is a pointer to the EmacLite instance.
* @param	PayloadSize is the size of the frame to create. The size only
*		reflects the payload size, it does not include the Ethernet
*		header size (14 bytes) nor the Ethernet CRC size (4 bytes).
*
* @return	XST_SUCCESS if successful, else XST_FAILURE.
*
* @note		None.
*
******************************************************************************/
int EmacLiteSendFrame(u8 *Payload, u32 PayloadSize, MACAddr_t *DstMACAddr, short Type)
{
	int Status;
	u8 *FramePtr;
	//u32 Index;

	/*
	 * Set the Complete flag to false.
	 */
	//TransmitComplete = FALSE;

	/*
	 * Assemble the frame with a destination address and the source address.
	 */
	FramePtr = (u8 *)TxFrame;

	/*
	 * Fill in the valid Destination MAC address if
	 * the Loopback is not enabled.
	 */

	*FramePtr++ = DstMACAddr->byte1;
	*FramePtr++ = DstMACAddr->byte2;
	*FramePtr++ = DstMACAddr->byte3;
	*FramePtr++ = DstMACAddr->byte4;
	*FramePtr++ = DstMACAddr->byte5;
	*FramePtr++ = DstMACAddr->byte6;

	/*
	 * Fill in the source MAC address.
	 */
	*FramePtr++ = LocalAddress[0];
	*FramePtr++ = LocalAddress[1];
	*FramePtr++ = LocalAddress[2];
	*FramePtr++ = LocalAddress[3];
	*FramePtr++ = LocalAddress[4];
	*FramePtr++ = LocalAddress[5];

	/*
	 * Set up the type/length field - be sure its in network order.
	 */
    *((u16 *)FramePtr) = Xil_Htons(Type);
    FramePtr++;
	FramePtr++;

	for (i = 0; i < PayloadSize; i++)
	{
		*FramePtr++ = Payload[i];
	}

	/*
	 * Now send the frame.
	 */
	Status = XEmacLite_Send(&eth_handle, (u8 *)TxFrame,
				PayloadSize + XEL_HEADER_SIZE);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}


void ParseEthernetFrame(u8 *Buffer)
{
	eth_header_t *ethHeader;

	ethHeader = (eth_header_t *)Buffer;

	MACAddr_t DstMac = ethHeader->DstAddr;

	// xil_printf("Packagetype: %x\n", ethHeader->TypeField);

	if ((cmp_mac_addresses(&DstMac, &LocalMacAddr) == 1) || (cmp_mac_addresses(&DstMac, &BroadcastMacAddr)))
	{
		if (ethHeader->TypeField == ETH_TYPE_ARP)
		{
			ParseArpPackage(Buffer);
		}
		else if(ethHeader->TypeField == ETH_TYPE_IP4)
		{
			ParseIP4Header(Buffer);
		}
	}
}

/*
 * Look if two mac-addresses are equal
 */
int cmp_mac_addresses(MACAddr_t *MacAddr1, MACAddr_t *MacAddr2)
{
	if ((MacAddr1->byte1 == MacAddr2->byte1) &&
		(MacAddr1->byte2 == MacAddr2->byte2) &&
		(MacAddr1->byte3 == MacAddr2->byte3) &&
		(MacAddr1->byte4 == MacAddr2->byte4) &&
		(MacAddr1->byte5 == MacAddr2->byte5) &&
		(MacAddr1->byte6 == MacAddr2->byte6))
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

