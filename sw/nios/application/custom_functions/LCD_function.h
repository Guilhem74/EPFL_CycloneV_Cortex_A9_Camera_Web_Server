#ifndef LCD_Function_H
#define LCD_Function_H
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
#include "system.h"
#include "sys/alt_stdio.h"
#include "HAL/inc/io.h"
#include <string.h>
#include <math.h>
#include <stdio.h>
#include "../Configuration.h"

// Registers
#define REGCOMMANDDATA 		0
#define REGSTATECOMMANDDATA 4
#define REGSTARTADD			8
#define REGLENGTHBUFFER 	12
#define REGDISPLAYBUFFER	16
#define REGBUFFERSAVED		20

// Address
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


// Memory functions
void LCD_Write_Command(int);
void LCD_Write_Data(int);
void LCD_Display(void);

// Memory functions
void Fill_Memory(int,int,int);
void Fill_Memory_RGBG(void);
void Fill_Memory_0_1(void);
void Fill_Test_0(void);
void Fill_Test_1(void);

void LCD_Configuration();

#endif
