/*
 * time.c
 *
 *  Created on: 25.06.2012
 *      Author: eriks
 */

#include "time.h"
#include "xtmrctr.h"
#include "stdio.h"


/*
 * Interrupthandler for the timer/counter
 */
void TmrHandler(void *CallBackRef, u8 TmrCtrNumber)
{
	TimerFinished = 1;
}

/*
 * Wait for time in Mikroseconds
 */
int wait_us(int time_us, XTmrCtr *timer_handle)
{
	int timerValue = 0;

	TimerFinished = 0;

	XTmrCtr_Reset (timer_handle, 0);

	XTmrCtr_SetOptions(timer_handle, 0, XTC_INT_MODE_OPTION | XTC_DOWN_COUNT_OPTION);

	// Calculate value for timer
	timerValue = (time_us * 0.000001) / CLK_PERIOD;

	XTmrCtr_SetResetValue(timer_handle, 0, timerValue);

	XTmrCtr_Start(timer_handle, 0);

	while (TimerFinished != 1)
	{
	}

	return 1;
}

int wait_ms(int time_ms, XTmrCtr *timer_handle)
{
	int timerValue = 0;

	TimerFinished = 0;

	XTmrCtr_Reset (timer_handle, 0);

	XTmrCtr_SetOptions(timer_handle, 0, XTC_INT_MODE_OPTION | XTC_DOWN_COUNT_OPTION);

	// Calculate value for timer
	timerValue = (time_ms * 0.001) / CLK_PERIOD;

	XTmrCtr_SetResetValue(timer_handle, 0, timerValue);

	XTmrCtr_Start(timer_handle, 0);

	while (TimerFinished != 1)
	{
	}

	return 1;
}
