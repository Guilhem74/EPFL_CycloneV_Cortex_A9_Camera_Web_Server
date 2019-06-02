/*
 * Accelerator_Grayscale.c
 *
 *  Created on: 2 juin 2019
 *      Authors: Guilhem Azzano and Pierre Fourcade
 */

#include <stdio.h>
#include <stdint.h>

#include "sys/alt_stdio.h"

#include "system.h"
#include "io.h"

#include "Define_Header.h"
#include "Function_Header.h"

//------------------------------------------------------------------------------------------------

void Test_Accelerator_Grayscale_Table(uint16_t *Address, uint32_t Length_Address)
{
	/* Parameters:
	 * uint16_t *Address       : The address of the first pixel data in the memory.
	 * uint32_t Length_Address : The length of the addresses (or (n_pixels-1)*2) in byte.
	 */

	// Initialize the address:
	IOWR_32DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGADDRESS, Address);
	alt_printf("RegAddress = 0x%x\n", IORD_32DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGADDRESS));

	// Initialize the length:
	IOWR_32DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGLENGTHADDRESS, Length_Address);
	alt_printf("RegLength_Address = 0x%x\n", IORD_32DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGLENGTHADDRESS));

	// Enable:
	IOWR_8DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGCOMMAND, ENABLE);

	// Wait that the task is done:
	uint8_t Check = IORD_8DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGCOMMAND);
	while(Check != 0)
	{
		Check = IORD_8DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGCOMMAND);
	}

	// Check DataRead and DataWrite:
	alt_printf("RegData_Read = 0x%x\n", IORD_32DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGDATAREAD));
	alt_printf("RegData_Write = 0x%x\n", IORD_32DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGDATAWRITE));
}

//------------------------------------------------------------------------------------------------

void Accelerator_Grayscale_Table(uint16_t *Address, uint32_t Length_Address)
{
	/* Parameters:
	 * uint32_t *Address       : The address of the first variable in the memory.
	 * uint32_t Length_Address : The length of the addresses (or (n_pixels-1)*2) in byte.
	 */

	// Initialize the address:
	IOWR_32DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGADDRESS, Address);

	// Initialize the length:
	IOWR_32DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGLENGTHADDRESS, Length_Address);

	// Enable:
	IOWR_8DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGCOMMAND, ENABLE);

	// Wait that the task is done:
	uint8_t Check = IORD_8DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGCOMMAND);
	while(Check != 0)
	{
		Check = IORD_8DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGCOMMAND);
	}
}

//------------------------------------------------------------------------------------------------

void Test_Accelerator_Grayscale_Image(int Address, int Length_Address)
{
	/* Parameters:
	 * int Address        : The address of the first pixel data in the memory.
	 * int Length_Address : The length of the addresses (or (n_pixels-1)*2) in byte.
	 */

	// Initialize the address:
	IOWR_32DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGADDRESS, Address);
	alt_printf("RegAddress = 0x%x\n", IORD_32DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGADDRESS));

	// Initialize the length:
	IOWR_32DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGLENGTHADDRESS, Length_Address);
	alt_printf("RegLength_Address = 0x%x\n", IORD_32DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGLENGTHADDRESS));

	// Enable:
	IOWR_8DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGCOMMAND, ENABLE);

	// Wait that the task is done:
	uint8_t Check = IORD_8DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGCOMMAND);
	while(Check != 0)
	{
		Check = IORD_8DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGCOMMAND);
	}

	// Check DataRead and DataWrite:
	alt_printf("RegData_Read = 0x%x\n", IORD_32DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGDATAREAD));
	alt_printf("RegData_Write = 0x%x\n", IORD_32DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGDATAWRITE));
}

//------------------------------------------------------------------------------------------------

void Accelerator_Grayscale_Image(int Address, int Length_Address)
{
	/* Parameters:
	 * int Address        : The address of the first variable in the memory.
	 * int Length_Address : The length of the addresses (or (n_pixels-1)*2) in byte.
	 */

	// Initialize the address:
	IOWR_32DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGADDRESS, Address);

	// Initialize the length:
	IOWR_32DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGLENGTHADDRESS, Length_Address);

	// Enable:
	IOWR_8DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGCOMMAND, ENABLE);

	// Wait that the task is done:
	uint8_t Check = IORD_8DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGCOMMAND);
	while(Check != 0)
	{
		Check = IORD_8DIRECT(ACCELERATOR_GRAYSCALE_0_BASE, REGCOMMAND);
	}
}

//------------------------------------------------------------------------------------------------
