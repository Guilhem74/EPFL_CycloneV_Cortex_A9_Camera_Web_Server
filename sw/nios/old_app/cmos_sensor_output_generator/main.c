#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
#include "system.h"
#include "sys/alt_stdio.h"
#include "HAL/inc/io.h"
#include <string.h>
#include <math.h>
#include <stdio.h>
#include "Configuration.h"
#include "custom_functions/Camera_function.h"
#include "CMOS_Sensor/cmos_sensor_output_generator.h"
#include "CMOS_Sensor/cmos_sensor_output_generator_regs.h"
#include "custom_functions/Memory_Access.h"
#include "custom_functions/function_i2c.h"
#include "custom_functions/LCD_function.h"



int main(void) {
	printf("Hello from Nios II and Camera Generator!\n");
	printf("Compiled %s %s\n", __DATE__, __TIME__);
	delay(1000);

#if DEBUG_MEMORY
	Quick_Test_Memory_Map();
	#if ULTRA_Debug
		Test_Memory_Map();
	#endif
#endif
#if DEBUG_I2C && Camera_Connected
	Test_i2c();
#endif
#if Frame_Generator && !Camera_Connected
	Test_Function_Generator();
#endif
#if LCD_Connected
	LCD_Configuration();
#endif
#if Camera_Connected
	Camera_Configuration();
	Test_Camera_Memory();
#endif

	/*while(1)
	{	LCD_Configuration();

	}*/
}


