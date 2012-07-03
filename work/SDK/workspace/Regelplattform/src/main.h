/*
 * main.h
 *
 *  Created on: 24.06.2012
 *      Author: eriks
 */

#ifndef MAIN_H_
#define MAIN_H_

#include <stdio.h>
#include "xgpio.h"
#include "xuartlite.h"
#include "xemaclite.h"
#include "xintc.h"
#include "xtmrctr.h"
#include "Networking/ethernet.h"

#define PHY_REG0_OFFSET		0 		// Register 0 of PHY device
#define PHY_REG1_OFFSET 	1 		// Register 1 of PHY device
#define PHY_REG17_OFFSET 	17 		// Register 1 of PHY device
#define PHY_REG0_RESET_MASK	0x8000 	// Reset PHY Device
#define PHY_REG0_LOOPBACK_MASK	0x4000  // Loopback Enable in Phy
#define PHY_REG0_FULL_DUPLEX_MASK 0x0100 // Set Full duplex mode
#define PHY_REG0_SPD_10_MASK 0x0000 // Set Speed to 10 Mbps
#define PHY_REG0_SPD_100_MASK 0x2000 // Set Speed to 100 Mbps
#define PHY_REG0_ISOLATE_MASK 0x0400 // isolate datapath
#define PHY_REG1_DETECT_MASK	0x1808	// Mask to detect PHY device
#define PHY_REG17_FARLOOPBACK_MASK 0x0200 // Enable farlooopback
#define PACKAGE_BUF_SIZE 10 // Size of Packagebuffer

// Variable definitions
static XUartLite uart_handle;
static XIntc intc_handle;
static XTmrCtr tmr_handle;
static XGpio gpio_handle;

static int RxFrameLength;
static int TransmitComplete;
static int ProcessingPackage;

XEmacLite_Config *eth_cfg_handle;

static unsigned int ReceiveCnt;
static unsigned int SendCnt;
static int FrameBufPos;
static int FrameInProcess;
static unsigned int DataInBuffer;

EthernetFrame RxFrameBuffer[PACKAGE_BUF_SIZE];

// function prototypes
void init_peripherals();

void UartSendHandler(void *CallBackRef, unsigned int EventData);
void UartRecvHandler(void *CallBackRef, unsigned int EventData);
void EthSendHandler(void *CallBackRef);
void EthRecvHandler(void *CallBackRef);

#endif /* MAIN_H_ */
