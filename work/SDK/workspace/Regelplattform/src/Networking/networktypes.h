/*
 * Networktypes.h
 *
 *  Created on: Jul 2, 2012
 *      Author: eriks
 */

#ifndef NETWORKTYPES_H_
#define NETWORKTYPES_H_

struct MAC_Address
{
	char byte1;
	char byte2;
	char byte3;
	char byte4;
	char byte5;
	char byte6;
};

typedef struct MAC_Address MACAddr_t;

struct ip_addr
{
	char byte1;
	char byte2;
	char byte3;
	char byte4;
};

typedef struct ip_addr ip_addr_t;

#endif /* NETWORKTYPES_H_ */
