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
