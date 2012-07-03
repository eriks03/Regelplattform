#include <stdio.h>
#include "platform.h"
#include "main.h"
#include "time.h"
#include "xil_exception.h"
#include "Networking/arp.h"
#include "Networking/ip4.h"

/******************************************************************************/
/**
*
* This function detects the PHY address by looking for successful MII status
* register contents (PHY register 1). It looks for a PHY that supports
* auto-negotiation and 10Mbps full-duplex and half-duplex. So, this code
* won't work for PHYs that don't support those features, but it's a bit more
* general purpose than matching a specific PHY manufacturer ID.
*
* Note also that on some (older) Xilinx ML4xx boards, PHY address 0 does not
* properly respond to this query. But, since the default is 0 and assuming
* no other address responds, then it seems to work OK.
*
* @param	InstancePtr is the pointer to the instance of EmacLite driver.
*
* @return	The address of the PHY device detected (returns 0 if not
*		detected).
*
* @note
*		The bit mask (0x1808) of the MII status register
*		(PHY Register 1) used in this function are:
* 		0x1000: 10Mbps full duplex support.
* 		0x0800: 10Mbps half duplex support.
*  		0x0008: Auto-negotiation support.
*
******************************************************************************/
u32 EmacLitePhyDetect(XEmacLite *InstancePtr)
{
	u16 PhyData;
	int PhyAddr;

	/*
	 * Verify all 32 MDIO ports.
	 */
	for (PhyAddr = 31; PhyAddr >= 0; PhyAddr--) {
		XEmacLite_PhyRead(InstancePtr, PhyAddr, PHY_REG1_OFFSET,
				 &PhyData);

		if (PhyData != 0xFFFF) {
			if ((PhyData & PHY_REG1_DETECT_MASK) ==
			PHY_REG1_DETECT_MASK) {
				return PhyAddr;	/* Found a valid PHY device */
			}
		}
	}
	/*
	 * Unable to detect PHY device returning the default address of 0.
	 */
	return 0;
}

/*
 * Initialize the Peripherals used in this Program
 */
void init_peripherals()
{
	int Status;
	u32 PhyAddress;

	/***********************************************************************
	 *  Initialize Peripheral Components
	 ***********************************************************************/

	// initialize the interrupt System
	Status = XIntc_Initialize(&intc_handle, XPAR_XPS_INTC_0_DEVICE_ID);
	if (Status != XST_SUCCESS)
	{
		// ToDo Error handling
	}

	// Initialize Timer/Counter
	Status = XTmrCtr_Initialize(&tmr_handle, XPAR_XPS_TIMER_0_DEVICE_ID);
	if (Status != XST_SUCCESS)
	{
		// ToDo Error handling
	}

	// Initialize GPIO
	Status = XGpio_Initialize(&gpio_handle, XPAR_LEDS_8BITS_DEVICE_ID);
	if (Status != XST_SUCCESS)
	{
		// ToDo Error handling
	}

	// Initialize the UART
	Status = XUartLite_Initialize(&uart_handle, XPAR_RS232_UART_1_DEVICE_ID);
	if (Status != XST_SUCCESS)
	{
		// ToDo Error handling
	}

	// Initialize the Ethernet MAC
	Status = XEmacLite_Initialize(&eth_handle, XPAR_ETHERNET_LITE_DEVICE_ID);
	if (Status != XST_SUCCESS)
	{
		// ToDo Error handling
	}

	eth_cfg_handle = XEmacLite_LookupConfig(XPAR_ETHERNET_LITE_DEVICE_ID);
	if (eth_cfg_handle == NULL)
	{
		// ToDo Error handling
	}

	// Initialize Ethernet configuration
	Status = XEmacLite_CfgInitialize(&eth_handle, eth_cfg_handle, eth_cfg_handle->BaseAddress);
	if (Status != XST_SUCCESS)
	{
		// ToDo Error handling
	}

	/**********************************************************************************
	 *  Setup Interruptsystem and Peripheral Interrupts
	 **********************************************************************************/
	// UART
	Status = XIntc_Connect(&intc_handle, XPAR_INTC_0_UARTLITE_1_VEC_ID, (XInterruptHandler)XUartLite_InterruptHandler, (void *)&uart_handle);
	if (Status != XST_SUCCESS)
	{
		// ToDo Error handling
	}

	// Ethernet
	Status = XIntc_Connect(&intc_handle, XPAR_INTC_0_EMACLITE_0_VEC_ID, (XInterruptHandler)XEmacLite_InterruptHandler, (void *)&eth_handle);
	if (Status != XST_SUCCESS)
	{
		// ToDo Error handling
	}

	// Timer
	Status = XIntc_Connect(&intc_handle, XPAR_INTC_0_TMRCTR_0_VEC_ID, (XInterruptHandler)XTmrCtr_InterruptHandler, (void *)&tmr_handle);
	if (Status != XST_SUCCESS)
	{
		// ToDo Error handling
	}

	// Start Interruptcontroller
	Status = XIntc_Start(&intc_handle, XIN_REAL_MODE);
	if (Status != XST_SUCCESS)
	{
		// ToDo Error handling
	}

	// Enable Interrupts
	XIntc_Enable(&intc_handle, XPAR_INTC_0_TMRCTR_0_VEC_ID);
	XIntc_Enable(&intc_handle, XPAR_INTC_0_UARTLITE_1_VEC_ID);
	XIntc_Enable(&intc_handle, XPAR_INTC_0_EMACLITE_0_VEC_ID);

	/*
	 * Initialize the exception table.
	 */
	Xil_ExceptionInit();

	/*
	 * Register the interrupt controller handler with the exception table.
	 */
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT, (Xil_ExceptionHandler)XIntc_InterruptHandler, &intc_handle);

	/*
	 * Enable non-critical exceptions.
	 */
	Xil_ExceptionEnable();

	XTmrCtr_SetHandler(&tmr_handle, TmrHandler, &tmr_handle);

	// set Interrupt handler for the devices
	// UART
	XUartLite_SetSendHandler(&uart_handle, UartSendHandler, &uart_handle);
	XUartLite_SetRecvHandler(&uart_handle, UartRecvHandler, &uart_handle);

	// Ethernet
	XEmacLite_SetSendHandler(&eth_handle, &eth_handle, EthSendHandler);
	XEmacLite_SetRecvHandler(&eth_handle, &eth_handle, EthRecvHandler);

	/******************************************************************************
	 * Configure Peripherals
	 ******************************************************************************/

	// Set GPIO Direction
	XGpio_SetDataDirection(&gpio_handle, 1, 0x00000000);

	// Ethernet

	// Set local MAC Address
	XEmacLite_SetMacAddress(&eth_handle, LocalAddress);

	// Flush Receive Buffers
	XEmacLite_FlushReceive(&eth_handle);

	// Set Ethernet Speed to 10 Mbps
    PhyAddress = EmacLitePhyDetect(&eth_handle);

    Status = XEmacLite_PhyWrite(&eth_handle, PhyAddress, PHY_REG0_OFFSET, PHY_REG0_SPD_10_MASK | PHY_REG0_FULL_DUPLEX_MASK); // | PHY_REG0_LOOPBACK_MASK  PHY_REG0_SPD_10_MASK | PHY_REG0_FULL_DUPLEX_MASK | | PHY_REG0_ISOLATE_MASK
    if (Status != XST_SUCCESS)
    {
    	// ToDo Error handling
    }

    // wait for setting correct speed
    wait_ms(1000, &tmr_handle);

//	Status = XEmacLite_PhyWrite(&eth_handle, PhyAddress, PHY_REG0_OFFSET, PHY_REG0_RESET_MASK);
//	if (Status != XST_SUCCESS)
//	{
//		// ToDo Error handling
//	}
//
//	// Wait until device is reseting
//	wait_ms(5000, &tmr_handle);

//	Status = XEmacLite_PhyWrite(&eth_handle, PhyAddress, PHY_REG0_OFFSET, PHY_REG0_SPD_10_MASK | PHY_REG0_FULL_DUPLEX_MASK); // | PHY_REG0_LOOPBACK_MASK  PHY_REG0_SPD_10_MASK | PHY_REG0_FULL_DUPLEX_MASK | | PHY_REG0_ISOLATE_MASK
//	if (Status != XST_SUCCESS)
//	{
//		// ToDo Error handling
//	}

	XEmacLite_EnableInterrupts(&eth_handle);
}

/*
 * Interrupthandler for sending data over UART
 */
void UartSendHandler(void *CallBackRef, unsigned int EventData)
{
	SendCnt = EventData;
}

/*
 * Interrupthandler for receiving data over UART
 */
void UartRecvHandler(void *CallBackRef, unsigned int EventData)
{
	ReceiveCnt = EventData;
}

/*
 * Interrupthandler for sending data over Ethernet
 */
void EthSendHandler(void *CallBackRef)
{
	XEmacLite *XEmacInstancePtr;

	/*
	 * Convert the argument to something useful.
	 */
	XEmacInstancePtr = (XEmacLite *)CallBackRef;

	/*
	 * Handle the Transmit callback.
	 */
	TransmitComplete = TRUE;
}

/*
 * Interrupthandler for receiving data over Ethernet
 */
void EthRecvHandler(void *CallBackRef)
{
	XEmacLite *XEmacInstancePtr;

	/*
	 * Convert the argument to something useful.
	 */
	XEmacInstancePtr = (XEmacLite *)CallBackRef;

	if (FrameBufPos < PACKAGE_BUF_SIZE - 1)
	{
		/*
		 * Handle the Receive callback.
		 */
		FrameBufPos++;

		RxFrameLength = XEmacLite_Recv(XEmacInstancePtr, (u8 *)RxFrameBuffer[FrameBufPos]);

		DataInBuffer = 1;
	}
	else
	{
		XEmacLite_FlushReceive(XEmacInstancePtr);
	}
}

/*
 * Main Function is called after program starts
 */
int main()
{
	// initialize Platform
    init_platform();

    init_peripherals();

    initArpCache();

    RxFrameLength = 0;
    FrameBufPos = -1;
    FrameInProcess = -1;
    DataInBuffer = 0;

    u8 *RxFramePtr;
    u8 Payload[50];
    int result;
    int i = 0;

    ip_addr_t DstIPAddr = {192, 168, 1, 1};
    //ip_addr_t SrcIPAddr = {192, 168, 1, 10};
    MACAddr_t DstMACAddr = {0xd4, 0x9a, 0x20, 0xbb, 0x65, 0x5e};
    //MACAddr_t SrcMACAddr = {0xd4, 0x9a, 0x20, 0xbb, 0x65, 0x6e};

    xil_printf("Regelplattform Version 0.1a\r\n");
    xil_printf("---------------------------\r\n\n");

    while(1)
    {
    	if(FrameBufPos > -1)
    	{
    		for (FrameInProcess = 0; FrameInProcess <= FrameBufPos; FrameInProcess++)
    		{
    			//int i = 0;
    			RxFramePtr = (u8 *)RxFrameBuffer[FrameInProcess];

    			ParseEthernetFrame(RxFramePtr);

    			// RxFrameLength = 0;
    		}

    		DataInBuffer = 0;
    		FrameBufPos = -1;
    	}

    	for (i = 0; i < 50; i++)
    	{
    		Payload[i] = i;
    	}
    	//SendArpPacket(&eth_handle, &DstIPAddr, &DstMACAddr, ARP_OPERATION_REQUEST);
    	//SendIP4Package(DstIPAddr, (u8 *)Payload, 50, 1);

    	//wait_ms(1000, &tmr_handle);
    }

    cleanup_platform();

    return 0;
}
