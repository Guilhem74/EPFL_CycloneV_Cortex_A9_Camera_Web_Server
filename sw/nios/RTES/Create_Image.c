/*
 * Create_Image.c
 *
 *  Created on: 2 juin 2019
 *      Author: Pierre Fourcade
 */

#include <stdio.h>
#include <stdint.h>

#include "sys/alt_stdio.h"

#include "system.h"
#include "io.h"

#include "Define_Header.h"
#include "Function_Header.h"

//------------------------------------------------------------------------------------------------

void Partial_Image(int Start_Address, int Length, int Color) // Function to display in the desired area the desired color.
{
	volatile int i;
	volatile int Verif;

	for (i = 0; i <= Length; i += 2) {
		IOWR_16DIRECT(Start_Address, i, Color);
		Verif = IORD_16DIRECT(Start_Address, i);
		if (Verif != Color) {
			printf("Error: Data read does not corresponds to data written !\n");
		}
	}

	printf("Memory filled !\n");
}

//------------------------------------------------------------------------------------------------
void Gray_Scale(int Start_Address) // Function to create a scale of gray.
{
	volatile int i;
	volatile int j;

	for (i = 0; i < 240; i ++) {
		if ((i >= 0) & (i < 15)) {
			for (j = 0; j < 320; j ++) {
				IOWR_16DIRECT(Start_Address, 640*i + 2*j, 0b0000000000100000);
			}
		}
		else if ((i >= 15) & (i < 30)) {
			for (j = 0; j < 320; j ++) {
				IOWR_16DIRECT(Start_Address, 640*i + 2*j, 0b0000000001100000);
			}
		}
		else if ((i >= 30) & (i < 45)) {
			for (j = 0; j < 320; j ++) {
				IOWR_16DIRECT(Start_Address, 640*i + 2*j, 0b0000000011100000);
			}
		}
		else if ((i >= 45) & (i < 60)) {
			for (j = 0; j < 320; j ++) {
				IOWR_16DIRECT(Start_Address, 640*i + 2*j, 0b0000000111100000);
			}
		}
		else if ((i >= 60) & (i < 75)) {
			for (j = 0; j < 320; j ++) {
				IOWR_16DIRECT(Start_Address, 640*i + 2*j, 0b0000001111100000);
			}
		}
		else if ((i >= 75) & (i < 90)) {
			for (j = 0; j < 320; j ++) {
				IOWR_16DIRECT(Start_Address, 640*i + 2*j, 0b0000011111100000);
			}
		}
		else if ((i >= 90) & (i < 105)) {
			for (j = 0; j < 320; j ++) {
				IOWR_16DIRECT(Start_Address, 640*i + 2*j, 0b0000111111100000);
			}
		}
		else if ((i >= 105) & (i < 120)) {
			for (j = 0; j < 320; j ++) {
				IOWR_16DIRECT(Start_Address, 640*i + 2*j, 0b0001111111100000);
			}
		}
		else if ((i >= 120) & (i < 135)) {
			for (j = 0; j < 320; j ++) {
				IOWR_16DIRECT(Start_Address, 640*i + 2*j, 0b0011111111100000);
			}
		}
		else if ((i >= 135) & (i < 150)) {
			for (j = 0; j < 320; j ++) {
				IOWR_16DIRECT(Start_Address, 640*i + 2*j, 0b0111111111100000);
			}
		}
		else if ((i >= 150) & (i < 165)) {
			for (j = 0; j < 320; j ++) {
				IOWR_16DIRECT(Start_Address, 640*i + 2*j, 0b1111111111100000);
			}
		}
		else if ((i >= 165) & (i < 180)) {
			for (j = 0; j < 320; j ++) {
				IOWR_16DIRECT(Start_Address, 640*i + 2*j, 0b1111111111100001);
			}
		}
		else if ((i >= 180) & (i < 195)) {
			for (j = 0; j < 320; j ++) {
				IOWR_16DIRECT(Start_Address, 640*i + 2*j, 0b1111111111100011);
			}
		}
		else if ((i >= 195) & (i < 210)) {
			for (j = 0; j < 320; j ++) {
				IOWR_16DIRECT(Start_Address, 640*i + 2*j, 0b1111111111100111);
			}
		}
		else if ((i >= 210) & (i < 225)) {
			for (j = 0; j < 320; j ++) {
				IOWR_16DIRECT(Start_Address, 640*i + 2*j, 0b1111111111101111);
			}
		}
		else {
			for (j = 0; j < 320; j ++) {
				IOWR_16DIRECT(Start_Address, 640*i + 2*j, 0b1111111111111111);
			}
		}
	}
}
void RGB_Flag(int Start_Address, int Length) // Function to display RGB colors.
{
	volatile int i;

	volatile int Verif;

	for (i = 0; i <= Length; i += 2) {
		if ( i <= Length/3) {
			IOWR_16DIRECT(Start_Address, i, RED);
			Verif = IORD_16DIRECT(Start_Address, i);
			if (Verif != RED) {
				printf("Error: Data read does not corresponds to data written !\n");
			}
		}
		else if ( (i > Length/3) & (i < (2*Length)/3)) {
			IOWR_16DIRECT(Start_Address,i,GREEN);
			Verif = IORD_16DIRECT(Start_Address,i);
			if (Verif != GREEN) {
				printf("Error !\n");
			}
		}
		else {
			IOWR_16DIRECT(Start_Address,i,BLUE);
			Verif = IORD_16DIRECT(Start_Address,i);
			if (Verif != BLUE) {
				printf("Error !\n");
			}
		}
	}

	printf("Memory filled !\n");
}

//------------------------------------------------------------------------------------------------
