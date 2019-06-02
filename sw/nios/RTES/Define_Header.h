/*
 * Define_Header.h
 *
 *  Created on: 10 mars 2019
 *     Authors: Guilhem Azzano and Pierre Fourcade
 *
 * Description:
 * This file corresponds to the linker of the different useful constants.
 */

#include <stdio.h>
#include <stdint.h>

#ifndef DEFINE_HEADER_H_
#define DEFINE_HEADER_H_

// Accelerator_Grayscale.c
#define REGCOMMAND			0
#define REGADDRESS			4
#define REGLENGTHADDRESS	8
#define REGDATAREAD         12
#define REGDATAWRITE        16
#define RESET				0
#define ENABLE				0b00000001
#define RED					0b1111100000000000 // Should return 54.
#define GREEN				0b0000011111100000 // Should return 182.
#define BLUE				0b0000000000011111 // Should return 18.
#define TEST_COLOR_1        0b1110000011110100 // Should return 81.
#define TEST_COLOR_2        0b0000001111110101 // Should return 21.

// Create_Image.c
# define NB_PIXEL	76800
	//#define RED		-> Already defined.
	//#define BLUE 		-> Already defined.
	//#define GREEN 	-> Already defined.
#define WHITE       0xFFFF
#define BLACK		0x0000

#endif /* DEFINE_HEADER_H_ */
