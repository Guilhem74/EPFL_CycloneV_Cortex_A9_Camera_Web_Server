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

i2c_dev i2c;
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


#define I2C_FREQ              (50000000) /* Clock frequency driving the i2c core: 50 MHz in this example (ADAPT TO YOUR DESIGN) */
#define TRDB_D5M_I2C_ADDRESS  (0xba)

bool trdb_d5m_write(i2c_dev *i2c, uint8_t register_offset, uint16_t data) {
    uint8_t byte_data[2] = {(data >> 8) & 0xff, data & 0xff};

    int success = i2c_write_array(i2c, TRDB_D5M_I2C_ADDRESS, register_offset, byte_data, sizeof(byte_data));

    if (success != I2C_SUCCESS) {
        return false;
    } else {
        return true;
    }
}

bool trdb_d5m_read(i2c_dev *i2c, uint8_t register_offset, uint16_t *data) {
    uint8_t byte_data[2] = {0, 0};

    int success = i2c_read_array(i2c, TRDB_D5M_I2C_ADDRESS, register_offset, byte_data, sizeof(byte_data));

    if (success != I2C_SUCCESS) {
        return false;
    } else {
        *data = ((uint16_t) byte_data[0] << 8) + byte_data[1];
        return true;
    }
}

#define I2C_0_BASE 0x4041008
void init_I2C()
{
	i2c = i2c_inst((void *) I2C_0_BASE);
	i2c_init(&i2c, I2C_FREQ);
}
bool Write_and_Read_I2C(i2c_dev *i2c,uint8_t register_offset, uint16_t data)
{
	 	bool success = true;
	 	 /* write the 16-bit value 23 to register 10 */
	    success &= trdb_d5m_write(i2c, register_offset, data);

	    /* read from register 10, put data in readdata */
	    uint16_t readdata = 0;
	    success &= trdb_d5m_read(i2c, register_offset, &readdata);

	    if (success && readdata==data ) {
	        return true;
	    } else {
	        return false;
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
  printf("Hello from Nios II!\n");
  Fill_Memory_RGBG();
  Camera_Configuration();


  while(1);
  return 0;
}