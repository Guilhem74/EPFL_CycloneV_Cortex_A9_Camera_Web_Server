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

	printf("    \n");
	printf("Table_Grayscale(): Done !\n");
}

//------------------------------------------------------------------------------------------------

void Image_Grayscale()
{
	// If the code is to be used on an image:
	uint32_t Address        = SDRAM_CONTROLLER_BASE;
	uint32_t Length_Address = (NB_PIXEL-1)*2;

	// Performance counter initialization:
	PERF_RESET(PERFORMANCE_COUNTER_BASE);
	PERF_START_MEASURING(PERFORMANCE_COUNTER_BASE);

	// Section 1: C_Grayscale
	Partial_Image(Address, Length_Address, GREEN);
	PERF_BEGIN(PERFORMANCE_COUNTER_BASE, 1);
	C_Grayscale_Image(Address, Length_Address);
	PERF_END(PERFORMANCE_COUNTER_BASE, 1);

	// Section 2: Accelerator_Grayscale
	Partial_Image(Address, Length_Address, RED);
	PERF_BEGIN(PERFORMANCE_COUNTER_BASE, 2);
	Accelerator_Grayscale_Image(Address, Length_Address);
	PERF_END(PERFORMANCE_COUNTER_BASE, 2);

	// Report of the two section:
	perf_print_formatted_report((void *)PERFORMANCE_COUNTER_BASE,
								alt_get_cpu_freq(),
								2,
								"C   - Image",
								"DMA - Image");

	printf("    \n");
	printf("Image_Grayscale(): Done !\n");
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
	RGB_Flag(SDRAM_CONTROLLER_BASE, (76800-1)*2);
	RGB_Flag(SDRAM_CONTROLLER_BASE+((76800-1)*2), (76800-1)*2);
	Partial_Image(SDRAM_CONTROLLER_BASE, (76800-1)*2,BLUE);
	Partial_Image(SDRAM_CONTROLLER_BASE+((76800-1)*2), (76800-1)*2,BLUE);

	C_Grayscale_Image(SDRAM_CONTROLLER_BASE, (76800-1)*2);

	//Accelerator_Grayscale_Table(SDRAM_CONTROLLER_BASE, (76800-1)*2);
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
