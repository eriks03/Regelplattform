/*
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A 
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR 
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION 
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE 
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO 
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO 
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE 
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY 
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 */

/*
 * 
 *
 * This file is a generated sample test application.
 *
 * This application is intended to test and/or illustrate some 
 * functionality of your system.  The contents of this file may
 * vary depending on the IP in your system and may use existing
 * IP driver functions.  These drivers will be generated in your
 * SDK application project when you run the "Generate Libraries" menu item.
 *
 */


#include <stdio.h>
#include "xparameters.h"
#include "xenv_standalone.h"
#include "xintc.h"
#include "intc_header.h"
#include "xbasic_types.h"
#include "xgpio.h"
#include "gpio_header.h"
#include "uartlite_header.h"
#include "xemaclite.h"
#include "xemaclite_example.h"
#include "emaclite_header.h"
#include "emaclite_intr_header.h"
#include "xtmrctr.h"
#include "tmrctr_header.h"
#include "tmrctr_intr_header.h"


int main() 
{

   static XIntc intc;
   static XEmacLite Ethernet_Lite_EmacLite;
   static XTmrCtr xps_timer_0_Timer;

   XCACHE_ENABLE_ICACHE();
   XCACHE_ENABLE_DCACHE();

   print("---Entering main---\n\r");

   

   {
      int status;
      
      print("\r\n Running IntcSelfTestExample() for xps_intc_0...\r\n");
      
      status = IntcSelfTestExample(XPAR_XPS_INTC_0_DEVICE_ID);
      
      if (status == 0) {
         print("IntcSelfTestExample PASSED\r\n");
      }
      else {
         print("IntcSelfTestExample FAILED\r\n");
      }
   } 
	
   {
       int Status;

       Status = IntcInterruptSetup(&intc, XPAR_XPS_INTC_0_DEVICE_ID);
       if (Status == 0) {
          print("Intc Interrupt Setup PASSED\r\n");
       } 
       else {
         print("Intc Interrupt Setup FAILED\r\n");
      } 
   }
   

   {
      u32 status;
      
      print("\r\nRunning GpioOutputExample() for LEDs_8Bits...\r\n");

      status = GpioOutputExample(XPAR_LEDS_8BITS_DEVICE_ID,8);
      
      if (status == 0) {
         print("GpioOutputExample PASSED.\r\n");
      }
      else {
         print("GpioOutputExample FAILED.\r\n");
      }
   }
   

   {
      u32 status;
      
      print("\r\nRunning GpioInputExample() for Push_Buttons_4Bits...\r\n");

      u32 DataRead;
      
      status = GpioInputExample(XPAR_PUSH_BUTTONS_4BITS_DEVICE_ID, &DataRead);
      
      if (status == 0) {
         xil_printf("GpioInputExample PASSED. Read data:0x%X\r\n", DataRead);
      }
      else {
         print("GpioInputExample FAILED.\r\n");
      }
   }
   
   /*
    * Peripheral SelfTest will not be run for RS232_Uart_1
    * because it has been selected as the STDOUT device
    */

   

   {
      int status;
      
      print("\r\nRunning UartLiteSelfTestExample() for mdm_0...\r\n");
      status = UartLiteSelfTestExample(XPAR_MDM_0_DEVICE_ID);
      if (status == 0) {
         print("UartLiteSelfTestExample PASSED\r\n");
      }
      else {
         print("UartLiteSelfTestExample FAILED\r\n");
      }
   }
   

   {
      int status;
      
      print("\r\nRunning EmacLitePolledExample() for Ethernet_Lite...\r\n");
      status = EmacLitePolledExample(XPAR_ETHERNET_LITE_DEVICE_ID);
      if (status == 0) {
         print("EmacLite Polled Example PASSED\r\n");
      }
      else {
         print("EmacLite Polled Example FAILED\r\n");
      }
   }
   {
      int Status;

      print("\r\n Running Interrupt Test  for Ethernet_Lite...\r\n");
      
      Status = EmacLiteIntrExample(&intc, &Ethernet_Lite_EmacLite, \
                               XPAR_ETHERNET_LITE_DEVICE_ID, \
                               XPAR_XPS_INTC_0_ETHERNET_LITE_IP2INTC_IRPT_INTR);
	
      if (Status == 0) {
         print("EmacLite Interrupt Test PASSED\r\n");
      } 
      else {
         print("EmacLite Interrupt Test FAILED\r\n");
      }

   }
   

   {
      int status;
      
      print("\r\n Running TmrCtrSelfTestExample() for xps_timer_0...\r\n");
      
      status = TmrCtrSelfTestExample(XPAR_XPS_TIMER_0_DEVICE_ID, 0x0);
      
      if (status == 0) {
         print("TmrCtrSelfTestExample PASSED\r\n");
      }
      else {
         print("TmrCtrSelfTestExample FAILED\r\n");
      }
   }
   {
      int Status;

      print("\r\n Running Interrupt Test  for xps_timer_0...\r\n");
      
      Status = TmrCtrIntrExample(&intc, &xps_timer_0_Timer, \
                                 XPAR_XPS_TIMER_0_DEVICE_ID, \
                                 XPAR_XPS_INTC_0_XPS_TIMER_0_INTERRUPT_INTR, 0);
	
      if (Status == 0) {
         print("Timer Interrupt Test PASSED\r\n");
      } 
      else {
         print("Timer Interrupt Test FAILED\r\n");
      }

   }

   print("---Exiting main---\n\r");

   XCACHE_DISABLE_ICACHE();
   XCACHE_DISABLE_DCACHE();

   return 0;
}

