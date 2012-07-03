/*
 * time.h
 *
 *  Created on: 25.06.2012
 *      Author: eriks
 */

#ifndef TIME_H_
#define TIME_H_

#include "xtmrctr.h"

#define CLK_PERIOD 0.000000015 // 1/CLK_FREQUENCY
#define TMR_RESET_VALUE 0x00000000 // Reset value for the timer

static unsigned int TimerFinished; // 0: not finished 1: finished

void init_timer(XTmrCtr *timer_handle);
int wait_us(int time_us, XTmrCtr *timer_handle);
int wait_ms(int time_ms, XTmrCtr *timer_handle);

void TmrHandler(void *CallBackRef, u8 TmrCtrNumber);

#endif /* TIME_H_ */
