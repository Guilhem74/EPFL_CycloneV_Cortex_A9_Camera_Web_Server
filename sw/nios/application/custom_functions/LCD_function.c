#include "LCD_function.h"
#define LCD_0_BASE LCD_0_0_BASE
void Fill_Memory(int Start, int End, int Color) // Function to display in the desired area the desired color.
{
	volatile int i;

	for (i = Start; i < End; i += 4)
	{
		volatile int Verif;

		IOWR_32DIRECT(HPS_0_BRIDGES_BASE,i,Color);
		Verif = IORD_32DIRECT(HPS_0_BRIDGES_BASE,i);
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
				IOWR_32DIRECT(HPS_0_BRIDGES_BASE,i,RED);
				Verif = IORD_32DIRECT(HPS_0_BRIDGES_BASE,i);
				if (Verif != RED)
				{
					printf("Error !\n");
				}
			}
			else if ( i> LENGTHBUFFER/4 & i<LENGTHBUFFER/2)
			{
				IOWR_32DIRECT(HPS_0_BRIDGES_BASE,i,GREEN);
				Verif = IORD_32DIRECT(HPS_0_BRIDGES_BASE,i);
				if (Verif != GREEN)
				{
					printf("Error !\n");
				}
			}
			else if ( i> LENGTHBUFFER/2 & i<3*LENGTHBUFFER/4)
			{
				IOWR_32DIRECT(HPS_0_BRIDGES_BASE,i,BLUE);
				Verif = IORD_32DIRECT(HPS_0_BRIDGES_BASE,i);
				if (Verif != BLUE)
				{
					printf("Error !\n");
				}
			}
			else
			{
				IOWR_32DIRECT(HPS_0_BRIDGES_BASE,i,GREEN);
				Verif = IORD_32DIRECT(HPS_0_BRIDGES_BASE,i);
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
				IOWR_32DIRECT(HPS_0_BRIDGES_BASE,i,0);
				Verif = IORD_32DIRECT(HPS_0_BRIDGES_BASE,i);
				if (Verif != 0)
				{
					printf("Error !\n");
				}
				j = 1;
			}
			else
			{
				IOWR_32DIRECT(HPS_0_BRIDGES_BASE,i,0xFFFFFFFF);
				Verif = IORD_32DIRECT(HPS_0_BRIDGES_BASE,i);
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
				IOWR_32DIRECT(HPS_0_BRIDGES_BASE,i,BLACK);
				j = 1;
			}
			else
			{
				IOWR_32DIRECT(HPS_0_BRIDGES_BASE,i,WHITE);
				j = 0;
			}
		}
		else if (i >= LENGTHBUFFER-160*4*8)
		{
			if(j == 0)
			{
				IOWR_32DIRECT(HPS_0_BRIDGES_BASE,i,BLACK);
				j = 1;
			}
			else
			{
				IOWR_32DIRECT(HPS_0_BRIDGES_BASE,i,WHITE);
				j = 0;
			}
		}
		else
		{
			IOWR_32DIRECT(HPS_0_BRIDGES_BASE,i,RED);
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
				IOWR_32DIRECT(HPS_0_BRIDGES_BASE,i*160*4 + j*4, WHITE);
			}
			else
			{
				IOWR_32DIRECT(HPS_0_BRIDGES_BASE,i*160*4 + j*4, BLACK);
			}
		}
	}
}

void LCD_Write_Command(int Command_Data) // Write a command.
{
	volatile int Check;

	Check = IORD_32DIRECT(LCD_0_BASE,REGSTATECOMMANDDATA);

	while (Check != 0)
	{
		Check = IORD_32DIRECT(LCD_0_BASE,REGSTATECOMMANDDATA);
	}

	IOWR_32DIRECT(LCD_0_BASE,REGCOMMANDDATA,Command_Data);
	IOWR_32DIRECT(LCD_0_BASE,REGSTATECOMMANDDATA,0x00000001);
}

void LCD_Write_Data(int Command_Data) // Write data.
{
	volatile int Check;

	Check = IORD_32DIRECT(LCD_0_BASE,REGSTATECOMMANDDATA);

	while (Check != 0)
	{
		Check = IORD_32DIRECT(LCD_0_BASE,REGSTATECOMMANDDATA);
	}

	IOWR_32DIRECT(LCD_0_BASE,REGCOMMANDDATA,Command_Data);
	IOWR_32DIRECT(LCD_0_BASE,REGSTATECOMMANDDATA,0x00000002);
}

void LCD_Display() // Continuous display.
{
	volatile int Check;

	Check = IORD_32DIRECT(LCD_0_BASE,REGSTATECOMMANDDATA);

	while (Check != 0)
	{
		Check = IORD_32DIRECT(LCD_0_BASE,REGSTATECOMMANDDATA);
	}

	IOWR_32DIRECT(LCD_0_BASE,REGCOMMANDDATA,0x0000002C);
	IOWR_32DIRECT(LCD_0_BASE,REGSTATECOMMANDDATA,0x00000003);
}

void LCD_Configuration()
{
	volatile int j;


		printf("Configuration LCD Start \n");
		for (j = 0; j < 10000; j += 1);
		// Before anything we provide the hardware the start address and the length of a buffer. They are define in "Define_Header.h".
		IOWR_32DIRECT(LCD_0_BASE,REGSTARTADD,HPS_0_BRIDGES_BASE);
		alt_printf("RegStartAdd=%x\n", IORD_32DIRECT(LCD_0_BASE,REGSTARTADD));
		IOWR_32DIRECT(LCD_0_BASE,REGLENGTHBUFFER,LENGTHBUFFER);
		alt_printf("RegLengthBuffer=%x\n", IORD_32DIRECT(LCD_0_BASE,REGLENGTHBUFFER));

		// To avoid any trouble we manually reset the values in RegCommandData and in RegStateCommandData.
		IOWR_32DIRECT(LCD_0_BASE,REGSTATECOMMANDDATA,0);
		alt_printf("RegStateCommandData=%x\n", IORD_32DIRECT(LCD_0_BASE,REGSTATECOMMANDDATA));
		IOWR_32DIRECT(LCD_0_BASE,REGCOMMANDDATA,0);
		alt_printf("RegCommandData=%x\n", IORD_32DIRECT(LCD_0_BASE,REGCOMMANDDATA));


		// Function to fill the memory.
		//Fill_Memory(STARTADD,LENGTHBUFFER/2,RED);
		//Fill_Memory(LENGTHBUFFER/2,LENGTHBUFFER,BLUE);
		//Fill_Memory_0_1();
		Fill_Memory_RGBG();
		//Fill_Test_0();
		//Fill_Test_1();

		// Software reset of the LCD.
		LCD_Write_Command(0x00000001);
		for (j = 0; j < 10000; j += 1); // Mandatory delay.
		LCD_Write_Command(0x00000000);
		for (j = 0; j < 100000; j += 1); // Mandatory delay.
		LCD_Write_Command(0x00000001);
		for (j = 0; j < 500000; j += 1); // Mandatory delay.

		// We define all the parameters for the LCD.
		LCD_Write_Command(0x00000011);

		LCD_Write_Command(0x000000CF);
		LCD_Write_Data(0x00000000);
		LCD_Write_Data(0x00000081);
		LCD_Write_Data(0x000000C0);

		LCD_Write_Command(0x000000ED);
		LCD_Write_Data(0x00000064);
		LCD_Write_Data(0x00000003);
		LCD_Write_Data(0x00000012);
		LCD_Write_Data(0x00000081);

		LCD_Write_Command(0x000000E8);
		LCD_Write_Data(0x00000085);
		LCD_Write_Data(0x00000001);
		LCD_Write_Data(0x00000798);

		LCD_Write_Command(0x000000CB);
		LCD_Write_Data(0x00000039);
		LCD_Write_Data(0x0000002C);
		LCD_Write_Data(0x00000000);
		LCD_Write_Data(0x00000034);
		LCD_Write_Data(0x00000002);

		LCD_Write_Command(0x000000F7);
		LCD_Write_Data(0x00000020);

		LCD_Write_Command(0x000000EA);
		LCD_Write_Data(0x00000000);
		LCD_Write_Data(0x00000000);

		LCD_Write_Command(0x000000B1);
		LCD_Write_Data(0x00000000);
		LCD_Write_Data(0x0000001B);

		LCD_Write_Command(0x000000B6);
		LCD_Write_Data(0x0000000A);
		LCD_Write_Data(0x000000A2);

		LCD_Write_Command(0x000000C0);
		LCD_Write_Data(0x00000005);

		LCD_Write_Command(0x000000C1);
		LCD_Write_Data(0x00000011);

		LCD_Write_Command(0x000000C5);
		LCD_Write_Data(0x00000045);
		LCD_Write_Data(0x00000045);

		LCD_Write_Command(0x000000C7);
		LCD_Write_Data(0x000000A2);

		LCD_Write_Command(0x00000036); // Modified to match our image.
		LCD_Write_Data(0x000000E8);

		LCD_Write_Command(0x000000F2);
		LCD_Write_Data(0x00000000);

		LCD_Write_Command(0x00000026);
		LCD_Write_Data(0x00000001);

		LCD_Write_Command(0x000000E0);
		LCD_Write_Data(0x0000000F);
		LCD_Write_Data(0x00000026);
		LCD_Write_Data(0x00000024);
		LCD_Write_Data(0x0000000B);
		LCD_Write_Data(0x0000000E);
		LCD_Write_Data(0x00000008);
		LCD_Write_Data(0x0000004B);
		LCD_Write_Data(0x000000A8);
		LCD_Write_Data(0x0000003B);
		LCD_Write_Data(0x0000000A);
		LCD_Write_Data(0x00000014);
		LCD_Write_Data(0x00000006);
		LCD_Write_Data(0x00000010);
		LCD_Write_Data(0x00000009);
		LCD_Write_Data(0x00000000);

		LCD_Write_Command(0x000000E1);
		LCD_Write_Data(0x00000000);
		LCD_Write_Data(0x0000001C);
		LCD_Write_Data(0x00000020);
		LCD_Write_Data(0x00000004);
		LCD_Write_Data(0x00000010);
		LCD_Write_Data(0x00000008);
		LCD_Write_Data(0x00000034);
		LCD_Write_Data(0x00000047);
		LCD_Write_Data(0x00000044);
		LCD_Write_Data(0x00000005);
		LCD_Write_Data(0x0000000B);
		LCD_Write_Data(0x00000009);
		LCD_Write_Data(0x0000002F);
		LCD_Write_Data(0x00000036);
		LCD_Write_Data(0x0000000F);

		LCD_Write_Command(0x0000002A);	// Modified to match our image.
		LCD_Write_Data(0x00000000);
		LCD_Write_Data(0x00000000);
		LCD_Write_Data(0x00000001);
		LCD_Write_Data(0x0000003F);

		LCD_Write_Command(0x0000002B);	// Modified to match our image.
		LCD_Write_Data(0x00000000);
		LCD_Write_Data(0x00000000);
		LCD_Write_Data(0x00000000);
		LCD_Write_Data(0x000000EF);

		LCD_Write_Command(0x0000003A);
		LCD_Write_Data(0x00000055);

		LCD_Write_Command(0x000000F6);
		LCD_Write_Data(0x00000001);
		LCD_Write_Data(0x00000030);
		LCD_Write_Data(0x00000000);

		LCD_Write_Command(0x00000029);

		// To perform a single display.
		//LCD_Write_Command(0x0000002C);

		// To perform a continuous display.
		LCD_Display();
		printf("Configuration LCD Over \n");


}
