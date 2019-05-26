#include "../custom_functions/function_i2c.h"
#include "system.h"
#define I2C_FREQ              (50000000) /* Clock frequency driving the i2c core: 50 MHz in this example (ADAPT TO YOUR DESIGN) */
#define TRDB_D5M_I2C_ADDRESS  (0xba)

#define TRDB_D5M_0_I2C_0_BASE I2C_0_BASE   /* i2c base address from system.h (ADAPT TO YOUR DESIGN) */
i2c_dev i2c;
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
bool Test_i2c()
{
	init_I2C();
    if (Write_and_Read_I2C(&i2c,10,23)) {
    	printf("I2C PASS\r\n");
        return EXIT_SUCCESS;
    } else {
    	printf("I2C FAIL\r\n");
        return EXIT_FAILURE;
    }
}
void init_I2C()
{
	i2c = i2c_inst((void *) TRDB_D5M_0_I2C_0_BASE);
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
#if LCD_Connected
    success &= Write_and_Read_I2C(&i2c,TRDB_D5M_RED_GAIN_REG,15);//Binning x4
   success &= Write_and_Read_I2C(&i2c,TRDB_D5M_GREEN_1_GAIN_REG,12);//Binning x4
   success &= Write_and_Read_I2C(&i2c,TRDB_D5M_GREEN_2_GAIN_REG,12);//Binning x4
   success &= Write_and_Read_I2C(&i2c,TRDB_D5M_BLUE_GAIN_REG,14);//Binning x4
#else
   success &= Write_and_Read_I2C(&i2c,TRDB_D5M_RED_GAIN_REG,8);//Binning x4
  success &= Write_and_Read_I2C(&i2c,TRDB_D5M_GREEN_1_GAIN_REG,12);//Binning x4
  success &= Write_and_Read_I2C(&i2c,TRDB_D5M_GREEN_2_GAIN_REG,12);//Binning x4
  success &= Write_and_Read_I2C(&i2c,TRDB_D5M_BLUE_GAIN_REG,10);//Binning x4
#endif

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
