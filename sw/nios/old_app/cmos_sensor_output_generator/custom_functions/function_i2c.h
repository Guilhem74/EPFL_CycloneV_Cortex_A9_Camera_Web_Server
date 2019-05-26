#ifndef I2C_Function_H
#define I2C_Function_H
#include "../Configuration.h"

#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
#include "system.h"
#include "sys/alt_stdio.h"
#include "HAL/inc/io.h"
#include <string.h>
#include <math.h>
#include "../i2c/i2c.h"
#include "Register_Map_Camera.h"
bool Camera_Configuration();
bool Test_i2c();
void init_I2C();
bool Write_and_Read_I2C(i2c_dev *i2c,uint8_t register_offset, uint16_t data);
bool trdb_d5m_write(i2c_dev *i2c, uint8_t register_offset, uint16_t data);
bool trdb_d5m_read(i2c_dev *i2c, uint8_t register_offset, uint16_t *data);
#endif
