/*
 * C_Grayscale.c
 *
 *  Created on: 2 juin 2019
 *      Author: Guilhem Azzano and Pierre Fourcade
 */

#include <stdio.h>
#include <stdint.h>

#include "sys/alt_stdio.h"

#include "system.h"
#include "io.h"

#include "Define_Header.h"
#include "Function_Header.h"

//------------------------------------------------------------------------------------------------

void C_Grayscale_Table(uint16_t *Address, uint32_t Length_Address)
{
	/* Parameters:
	 * uint16_t *Address       : The address of the first pixel data in the memory.
	 * uint32_t Length_Address : The length of the addresses (or (n_pixels-1)*2) in byte.
	 */

	uint16_t Data_Read  = 0x0000;
	uint16_t Data_Write = 0x0000;

	uint16_t R_Mask = 0b1111100000000000;
	float R_Color = 0;

	uint16_t G_Mask = 0b0000011111100000;
	float G_Color = 0;

	uint16_t B_Mask = 0b0000000000011111;
	float B_Color = 0;

	for (int i = 0; i <= (Length_Address/2); i ++) {
		Data_Read  = IORD_16DIRECT(Address, i*2);

		// To avoid that the value gets rounded to 0, the order of calculus must be correctly set.
		R_Color = (float) (((255 * (Data_Read & R_Mask)) / 31) * 0.2126);
		G_Color = (float) (((255 * (Data_Read & G_Mask)) / 63) * 0.7152);
		B_Color = (float) (((255 * (Data_Read & B_Mask)) / 31) * 0.0722);

		Data_Write = (int) R_Color + G_Color + B_Color;

		IOWR_16DIRECT(Address, i*2, Data_Write);
	}
}

//------------------------------------------------------------------------------------------------

void C_Grayscale_Image(int Address, int Length_Address)
{
	/* Parameters:
	 * uint16_t *Address       : The address of the first pixel data in the memory.
	 * uint32_t Length_Address : The length of the addresses (or (n_pixels-1)*2) in byte.
	 */

	uint16_t Data_Read  = 0x0000;
	uint16_t Data_Write = 0x0000;

	uint16_t R_Mask = 0b1111100000000000;
	float R_Color = 0;

	uint16_t G_Mask = 0b0000011111100000;
	float G_Color = 0;

	uint16_t B_Mask = 0b0000000000011111;
	float B_Color = 0;

	for (int i = 0; i <= (Length_Address/2); i ++) {
		Data_Read  = IORD_16DIRECT(Address, i*2);

		// To avoid that the value gets rounded to 0, the order of calculus must be correctly set.
		R_Color = (float) (((255 * (Data_Read & R_Mask)) / 31) * 0.2126);
		G_Color = (float) (((255 * (Data_Read & G_Mask)) / 63) * 0.7152);
		B_Color = (float) (((255 * (Data_Read & B_Mask)) / 31) * 0.0722);

		Data_Write = (int) R_Color + G_Color + B_Color;

		IOWR_16DIRECT(Address, i*2, Data_Write);
	}
}

//------------------------------------------------------------------------------------------------
