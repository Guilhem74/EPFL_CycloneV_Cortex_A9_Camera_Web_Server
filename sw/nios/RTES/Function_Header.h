/*
 * Function_Header.h
 *
 *  Created on: 10 mars 2019
 *     Authors: Guilhem Azzano and Pierre Fourcade
 *
 * Description:
 * This file corresponds to the linker of the different functions.
 */

#include <stdio.h>
#include <stdint.h>

#ifndef FUNCTION_HEADER_H_
#define FUNCTION_HEADER_H_

// Accelerator_Grayscale.c
void Test_Accelerator_Grayscale_Table(uint16_t *, uint32_t);
void Accelerator_Grayscale_Table(uint16_t *, uint32_t);
void Accelerator_Grayscale_Image(int, int);

// C_Grayscale.c
void C_Grayscale_Table(uint16_t *, uint32_t);
void C_Grayscale_Image(int, int);

// Create_Image.c
void Partial_Image(int, int, int );
void RGB_Flag(int, int);

#endif /* FUNCTION_HEADER_H_ */
