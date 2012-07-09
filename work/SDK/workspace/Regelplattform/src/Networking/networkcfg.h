/*
 * networkcfg.h
 *
 *  Created on: Jul 2, 2012
 *      Author: eriks
 */

#ifndef NETWORKCFG_H_
#define NETWORKCFG_H_

#include "networktypes.h"

static MACAddr_t LocalMacAddr = {0x00, 0x0A, 0x35, 0x01, 0x02, 0x03};
static MACAddr_t RemoteMacAddr = {0xD4, 0x9A, 0x20, 0xBB, 0x65, 0x5E};
static MACAddr_t BroadcastMacAddr = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};

static ip_addr_t LocalAddr = {192, 168, 1, 10};


#endif /* NETWORKCFG_H_ */
