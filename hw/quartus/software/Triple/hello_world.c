/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include "sys/alt_stdio.h"
#include "system.h"
#include "HAL/inc/io.h"
#include <stdio.h>
#include <stdlib.h>
#include <priv/alt_legacy_irq.h>
#include "sys/alt_sys_init.h"
#define STARTADD		0
#define LENGTHBUFFER	(160*240*4)

// Colors (Careful they represent two pixels)
#define RED 		0xF800F800
#define BLUE 		0x001F001F
#define GREEN 		0x07E007E0
#define RED_BLUE 	0xF800001F
#define BLUE_GREEN	0x001F07E0
#define WHITE       0xFFFFFFFF
#define BLACK		0x00000000
void Fill_Memory(int Start, int End, int Color) // Function to display in the desired area the desired color.
{
	volatile int i;

	for (i = Start; i < End; i += 4)
	{
		volatile int Verif;

		IOWR_32DIRECT(SDRAM_CONTROLLER_0_BASE,i,Color);
		Verif = IORD_32DIRECT(SDRAM_CONTROLLER_0_BASE,i);
		if (Verif != Color)
		{
			printf("Error !\n");
		}
	}

	printf("Memory filled !\n");
}

void Fill_Memory_RGBG(void) // Function to display stripes of different colors.
{
	volatile int i;

	volatile int Verif;

		for (i = 0; i < LENGTHBUFFER; i += 4)
		{
			if ( i< LENGTHBUFFER/4)
			{
				IOWR_32DIRECT(SDRAM_CONTROLLER_0_BASE,i,RED);
				Verif = IORD_32DIRECT(SDRAM_CONTROLLER_0_BASE,i);
				if (Verif != RED)
				{
					printf("Error !\n");
				}
			}
			else if ( i> LENGTHBUFFER/4 & i<LENGTHBUFFER/2)
			{
				IOWR_32DIRECT(SDRAM_CONTROLLER_0_BASE,i,GREEN);
				Verif = IORD_32DIRECT(SDRAM_CONTROLLER_0_BASE,i);
				if (Verif != GREEN)
				{
					printf("Error !\n");
				}
			}
			else if ( i> LENGTHBUFFER/2 & i<3*LENGTHBUFFER/4)
			{
				IOWR_32DIRECT(SDRAM_CONTROLLER_0_BASE,i,BLUE);
				Verif = IORD_32DIRECT(SDRAM_CONTROLLER_0_BASE,i);
				if (Verif != BLUE)
				{
					printf("Error !\n");
				}
			}
			else
			{
				IOWR_32DIRECT(SDRAM_CONTROLLER_0_BASE,i,GREEN);
				Verif = IORD_32DIRECT(SDRAM_CONTROLLER_0_BASE,i);
				if (Verif != GREEN)
				{
					printf("Error !\n");
				}
			}

		}

		printf("Memory filled !\n");
}

void Fill_Memory_0_1(void) // Function to display 2 white pixels and then 2 black pixels.
{
	volatile int i;
	volatile int j;

	volatile int Verif;

	j = 0;

	for (i = 0; i < LENGTHBUFFER; i += 4)
		{
			if (j == 0)
			{
				IOWR_32DIRECT(SDRAM_CONTROLLER_0_BASE,i,0);
				Verif = IORD_32DIRECT(SDRAM_CONTROLLER_0_BASE,i);
				if (Verif != 0)
				{
					printf("Error !\n");
				}
				j = 1;
			}
			else
			{
				IOWR_32DIRECT(SDRAM_CONTROLLER_0_BASE,i,0xFFFFFFFF);
				Verif = IORD_32DIRECT(SDRAM_CONTROLLER_0_BASE,i);
				if (Verif != 0xFFFFFFFF)
				{
					printf("Error !\n");
				}
				j = 0;
			}
		}

		printf("Memory filled !\n");
}


void Fill_Test_0(void)
{
	volatile int i;
	volatile int j;

	j = 0;

	for (i = STARTADD; i < LENGTHBUFFER; i+=4)
	{
		if (i < 160*4*8)
		{
			if(j == 0)
			{
				IOWR_32DIRECT(SDRAM_CONTROLLER_0_BASE,i,BLACK);
				j = 1;
			}
			else
			{
				IOWR_32DIRECT(SDRAM_CONTROLLER_0_BASE,i,WHITE);
				j = 0;
			}
		}
		else if (i >= LENGTHBUFFER-160*4*8)
		{
			if(j == 0)
			{
				IOWR_32DIRECT(SDRAM_CONTROLLER_0_BASE,i,BLACK);
				j = 1;
			}
			else
			{
				IOWR_32DIRECT(SDRAM_CONTROLLER_0_BASE,i,WHITE);
				j = 0;
			}
		}
		else
		{
			IOWR_32DIRECT(SDRAM_CONTROLLER_0_BASE,i,RED);
		}
	}
}

void Fill_Test_1(void)
{
	volatile int i;
	volatile int j;

	for (i = 0; i < 240; i += 1)
	{
		for (j = 0; j < 160; j+=1)
		{
			if ( i == j)
			{
				IOWR_32DIRECT(SDRAM_CONTROLLER_0_BASE,i*160*4 + j*4, WHITE);
			}
			else
			{
				IOWR_32DIRECT(SDRAM_CONTROLLER_0_BASE,i*160*4 + j*4, BLACK);
			}
		}
	}
}
int main()
{
  printf("Hello from Nios II!\n");
  int i=0;
  Fill_Memory_RGBG();
  while(1);
  return 0;
}
