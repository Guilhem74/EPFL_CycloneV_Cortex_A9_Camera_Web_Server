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
#include "i2c.h"
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
#include "Register_Map_Camera.h"
#include "Camera_function.h"
#include "alt_types.h"
#include "altera_avalon_performance_counter.h"
#include "Define_Header.h"
#include "Function_Header.h"

//------------------------------------------------------------------------------------------------

void Table_Grayscale()
{
	// If the code is to be used on a manually set table:
	const int size           = 1;
	uint16_t  Table[size];
	uint32_t  Length_Address = (size-1) * 2;

	// Performance counter initialization:
	PERF_RESET(PERFORMANCE_COUNTER_BASE);
	PERF_START_MEASURING(PERFORMANCE_COUNTER_BASE);

	// Section 1: C_Grayscale
	for (int j = 0; j < size; j ++) { Table[j] = j; }
	PERF_BEGIN(PERFORMANCE_COUNTER_BASE, 1);
	C_Grayscale_Table(Table, Length_Address);
	PERF_END(PERFORMANCE_COUNTER_BASE, 1);

	// Section 2: Accelerator_Grayscale
	for (int j = 0; j < size; j ++) { Table[j] = j; }
	PERF_BEGIN(PERFORMANCE_COUNTER_BASE, 2);
	Accelerator_Grayscale_Table(Table, Length_Address);
	PERF_END(PERFORMANCE_COUNTER_BASE, 2);

	// Report of the two section:
	perf_print_formatted_report((void *)PERFORMANCE_COUNTER_BASE,
								alt_get_cpu_freq(),
								2,
								"C   - Size 1",
								"DMA - Size 1");
}

//------------------------------------------------------------------------------------------------

void Image_Grayscale()
{
	// If the code is to be used on an image:
	uint32_t Address        = SDRAM_CONTROLLER_BASE;
	uint32_t Length_Address = 153600;

	// Section 1: C_Grayscale
	Partial_Image(Address, Length_Address, RED);
	C_Grayscale_Image(Address, Length_Address);

	// Section 2: Accelerator_Grayscale
	Partial_Image(Address, Length_Address, RED);
	Accelerator_Grayscale_Image(Address, Length_Address);
}

//------------------------------------------------------------------------------------------------

#define STARTADD		0
#define LENGTHBUFFER	(160*240*4)

// Colors (Careful they represent two pixels)
#define RED_Color 		0xF800F800
#define BLUE_Color 		0x001F001F
#define GREEN_Color 		0x07E007E0
#define RED_BLUE_Color 	0xF800001F
#define BLUE_GREEN_Color	0x001F07E0
#define WHITE_Color       0xFFFFFFFF
#define BLACK_Color		0x00000000
void Fill_Memory(int Start, int End, int Color) // Function to display in the desired area the desired color.
{
	volatile int i;

	for (i = Start; i < End; i += 4)
	{
		volatile int Verif;

		IOWR_32DIRECT(SDRAM_CONTROLLER_BASE,i,Color);
		Verif = IORD_32DIRECT(SDRAM_CONTROLLER_BASE,i);
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
				IOWR_32DIRECT(SDRAM_CONTROLLER_BASE,i,RED_Color);
				Verif = IORD_32DIRECT(SDRAM_CONTROLLER_BASE,i);
				if (Verif != RED)
				{
				}
			}
			else if ( i> LENGTHBUFFER/4 & i<LENGTHBUFFER/2)
			{
				IOWR_32DIRECT(SDRAM_CONTROLLER_BASE,i,GREEN_Color);
				Verif = IORD_32DIRECT(SDRAM_CONTROLLER_BASE,i);
				if (Verif != GREEN)
				{
				}
			}
			else if ( i> LENGTHBUFFER/2 & i<3*LENGTHBUFFER/4)
			{
				IOWR_32DIRECT(SDRAM_CONTROLLER_BASE,i,BLUE_Color);
				Verif = IORD_32DIRECT(SDRAM_CONTROLLER_BASE,i);
				if (Verif != BLUE)
				{
				}
			}
			else
			{
				IOWR_32DIRECT(SDRAM_CONTROLLER_BASE,i,GREEN_Color);
				Verif = IORD_32DIRECT(SDRAM_CONTROLLER_BASE,i);
				if (Verif != GREEN)
				{
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
				IOWR_32DIRECT(SDRAM_CONTROLLER_BASE,i,0);
				Verif = IORD_32DIRECT(SDRAM_CONTROLLER_BASE,i);
				if (Verif != 0)
				{
					printf("Error !\n");
				}
				j = 1;
			}
			else
			{
				IOWR_32DIRECT(SDRAM_CONTROLLER_BASE,i,0xFFFFFFFF);
				Verif = IORD_32DIRECT(SDRAM_CONTROLLER_BASE,i);
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
				IOWR_32DIRECT(SDRAM_CONTROLLER_BASE,i,BLACK_Color);
				j = 1;
			}
			else
			{
				IOWR_32DIRECT(SDRAM_CONTROLLER_BASE,i,WHITE_Color);
				j = 0;
			}
		}
		else if (i >= LENGTHBUFFER-160*4*8)
		{
			if(j == 0)
			{
				IOWR_32DIRECT(SDRAM_CONTROLLER_BASE,i,BLACK_Color);
				j = 1;
			}
			else
			{
				IOWR_32DIRECT(SDRAM_CONTROLLER_BASE,i,WHITE_Color);
				j = 0;
			}
		}
		else
		{
			IOWR_32DIRECT(SDRAM_CONTROLLER_BASE,i,RED_Color);
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
				IOWR_32DIRECT(SDRAM_CONTROLLER_BASE,i*160*4 + j*4, WHITE_Color);
			}
			else
			{
				IOWR_32DIRECT(SDRAM_CONTROLLER_BASE,i*160*4 + j*4, BLACK_Color);
			}
		}
	}
}





bool Camera_Configuration()
{
	init_I2C();
    bool success = true;
    uint16_t data=0;
    trdb_d5m_read(&i2c, 0, &data);
    printf("Camera version :  %d\r\n",data);
    success &= Write_and_Read_I2C(&i2c,TRDB_D5M_COLUMN_SIZE_REG,2559);//Resolution for lt24 with binning
    success &= Write_and_Read_I2C(&i2c,TRDB_D5M_ROW_SIZE_REG,1919);// Resolution for lt24 with binning
    success &= Write_and_Read_I2C(&i2c,TRDB_D5M_SHUTTER_WIDTH_UPPER_REG,0000);//Control light
    success &= Write_and_Read_I2C(&i2c,TRDB_D5M_SHUTTER_WIDTH_LOWER_REG,3500);//Control light
    success &= Write_and_Read_I2C(&i2c,TRDB_D5M_ROW_ADDRESS_MODE_REG,0x0033);//Binning x4
    success &= Write_and_Read_I2C(&i2c,TRDB_D5M_COLUMN_ADDRESS_MODE_REG,0x0033);//Binning x4
	success &= Write_and_Read_I2C(&i2c,TRDB_D5M_RED_GAIN_REG,8);//Color
	success &= Write_and_Read_I2C(&i2c,TRDB_D5M_GREEN_1_GAIN_REG,12);//
	success &= Write_and_Read_I2C(&i2c,TRDB_D5M_GREEN_2_GAIN_REG,12);//
	success &= Write_and_Read_I2C(&i2c,TRDB_D5M_BLUE_GAIN_REG,10);//
    /*If Using the pll , clock input 25 Mhz, output 95Mhz
     *success &= Write_and_Read_I2C(&i2c,TRDB_D5M_PLL_CONTROL_REG,0x0003);//Power up and use pll
     *success &= Write_and_Read_I2C(&i2c,TRDB_D5M_PLL_CONFIG_1_REG,0x4C14);//N=10, 0x14, M=76, 0x4C
     *success &= Write_and_Read_I2C(&i2c,TRDB_D5M_PLL_CONFIG_2_REG,0x0002);//P1=2 , 0x02
     */
    if (success  ) {
    	printf("I2C Configuration PASS\r\n");
        return true;
    } else {
    	printf("I2C Configuration FAIL\r\n");
        return false;
    }
}
int main()
{
	delay(5000);
  printf("Hello from Nios II!\n");
 printf("Beginning of the main !\n");
  Camera_Acquisition_Module_Stop();
	delay(5000);
  Fill_Memory_RGBG();

  C_Grayscale_Table(SDRAM_CONTROLLER_BASE, 8);
  //Image_Grayscale();
  Camera_Configuration();
  /*Test_Camera_Memory();*/


//   	delay(5000);
//   	int t=Camera_Acquisition_Module_SETUP_Address_Memory(SDRAM_CONTROLLER_0_BASE);//Address of the HPC, 256 MB Available from it
//   	printf("Address : %d\r\n",t);
//   	t=Camera_Acquisition_Module_SETUP_Length_Frame(76800);//320*240
//   	printf("Length : %d\r\n",t);
//   	Camera_Acquisition_Module_Display_Registers();
//   	t=Camera_Acquisition_Module_Start();//Set a one in the start register
//   	printf("Start : %d\r\n",t);
//   	Camera_Acquisition_Module_Display_Registers();
//   	Capture_Image_Computer(SDRAM_CONTROLLER_0_BASE,0);
  printf("End of the main !\n");
  while(1)
	  {

	  }
  return 0;
}
