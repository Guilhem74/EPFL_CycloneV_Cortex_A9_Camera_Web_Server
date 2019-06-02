#include <assert.h>
#include <errno.h>
#include <fcntl.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>

#include "alt_generalpurpose_io.h"
#include "hps_linux.h"
#include "hwlib.h"
#include "socal/alt_gpio.h"
#include "socal/hps.h"
#include "socal/socal.h"
#include "../hps_soc_system.h"
 void Extract_Colors(int16_t Data,int* Storage);
void open_physical_memory_device() {
    // We need to access the system's physical memory so we can map it to user
    // space. We will use the /dev/mem file to do this. /dev/mem is a character
    // device file that is an image of the main memory of the computer. Byte
    // addresses in /dev/mem are interpreted as physical memory addresses.
    // Remember that you need to execute this program as ROOT in order to have
    // access to /dev/mem.

    fd_dev_mem = open("/dev/mem", O_RDWR | O_SYNC);
    if(fd_dev_mem  == -1) {
        printf("ERROR: could not open \"/dev/mem\".\n");
        printf("    errno = %s\n", strerror(errno));
        exit(EXIT_FAILURE);
    }
}

void close_physical_memory_device() {
    close(fd_dev_mem);
}

void mmap_hps_peripherals() {
    hps_gpio = mmap(NULL, hps_gpio_span, PROT_READ | PROT_WRITE, MAP_SHARED, fd_dev_mem, hps_gpio_ofst);
    if (hps_gpio == MAP_FAILED) {
        printf("Error: hps_gpio mmap() failed.\n");
        printf("    errno = %s\n", strerror(errno));
        close(fd_dev_mem);
        exit(EXIT_FAILURE);
    }
}

void munmap_hps_peripherals() {
    if (munmap(hps_gpio, hps_gpio_span) != 0) {
        printf("Error: hps_gpio munmap() failed\n");
        printf("    errno = %s\n", strerror(errno));
        close(fd_dev_mem);
        exit(EXIT_FAILURE);
    }

    hps_gpio = NULL;
}

void mmap_fpga_peripherals() {
    // Use mmap() to map the address space related to the fpga leds into user
    // space so we can interact with them.

    // The fpga leds are connected to the h2f_lw_axi_master, so its base
    // address is calculated from that of the h2f_lw_axi_master.

    // IMPORTANT: If you try to only mmap the fpga leds, it is possible for the
    // operation to fail, and you will get "Invalid argument" as errno. The
    // mmap() manual page says that you can only map a file from an offset which
    // is a multiple of the system's page size.

    // In our specific case, our fpga leds are located at address 0xFF200000,
    // which is a multiple of the page size, however this is due to luck because
    // the fpga leds are the only peripheral connected to the h2f_lw_axi_master.
    // The typical page size in Linux is 0x1000 bytes.

    // So, generally speaking, you will have to mmap() the closest address which
    // is a multiple of your page size and access your peripheral by a specific
    // offset from the mapped address.

    h2f_lw_axi_master = mmap(NULL, h2f_lw_axi_master_span, PROT_READ | PROT_WRITE, MAP_SHARED, fd_dev_mem, h2f_lw_axi_master_ofst);
    if (h2f_lw_axi_master == MAP_FAILED) {
        printf("Error: h2f_lw_axi_master mmap() failed.\n");
        printf("    errno = %s\n", strerror(errno));
        close(fd_dev_mem);
        exit(EXIT_FAILURE);
    }

    Avalon_Bus_Address_Span_Expender = h2f_lw_axi_master;
}

void munmap_fpga_peripherals() {
    if (munmap(h2f_lw_axi_master, h2f_lw_axi_master_span) != 0) {
        printf("Error: h2f_lw_axi_master munmap() failed\n");
        printf("    errno = %s\n", strerror(errno));
        close(fd_dev_mem);
        exit(EXIT_FAILURE);
    }

    h2f_lw_axi_master = NULL;
    Avalon_Bus_Address_Span_Expender         = NULL;
}

void mmap_peripherals() {
    mmap_hps_peripherals();
    mmap_fpga_peripherals();
}

void munmap_peripherals() {
    munmap_hps_peripherals();
    munmap_fpga_peripherals();
}

void setup_hps_gpio() {
    // Initialize the HPS PIO controller:
    //     Set the direction of the HPS_LED GPIO bit to "output"
    //     Set the direction of the HPS_KEY_N GPIO bit to "input"
    void *hps_gpio_direction = ALT_GPIO_SWPORTA_DDR_ADDR(hps_gpio);
    alt_setbits_word(hps_gpio_direction, ALT_GPIO_PIN_OUTPUT << HPS_LED_PORT_BIT);
    alt_setbits_word(hps_gpio_direction, ALT_GPIO_PIN_INPUT << HPS_KEY_N_PORT_BIT);
}

void setup_fpga_leds() {
    // Switch on first LED only
    alt_write_word(Avalon_Bus_Address_Span_Expender, 0x1);
}

void handle_hps_led() {
    void *hps_gpio_data = ALT_GPIO_SWPORTA_DR_ADDR(hps_gpio);
    void *hps_gpio_port = ALT_GPIO_EXT_PORTA_ADDR(hps_gpio);

    uint32_t hps_gpio_input = alt_read_word(hps_gpio_port) & HPS_KEY_N_MASK;

    // HPS_KEY_N is active-low
    bool toggle_hps_led = (~hps_gpio_input & HPS_KEY_N_MASK);

    if (toggle_hps_led) {
        uint32_t hps_led_value = alt_read_word(hps_gpio_data);
        hps_led_value >>= HPS_LED_PORT_BIT;
        hps_led_value = !hps_led_value;
        hps_led_value <<= HPS_LED_PORT_BIT;
        alt_replbits_word(hps_gpio_data, HPS_LED_MASK, hps_led_value);
    }
}

void handle_fpga_leds() {
    uint32_t leds_mask = alt_read_hword(Avalon_Bus_Address_Span_Expender);

    if (leds_mask != (0x01 << (HPS_FPGA_LEDS_DATA_WIDTH - 1))) {
        // rotate leds
        leds_mask <<= 1;
    } else {
        // reset leds
        leds_mask = 0x1;
    }

    alt_write_word(Avalon_Bus_Address_Span_Expender, leds_mask);
}
void Convert_Pixels(int32_t Data,int* Storage)
 {
 	Extract_Colors(Data&0xFFFF,Storage);
 	Extract_Colors((Data&0xFFFF0000)>>16,Storage+3);

 }
void Convert_Pixels_Gray(int32_t Data,int* Storage)
 {
	Storage[0]=Data&0xFFFF;
	Storage[1]=Data&0xFFFF;
	Storage[2]=Data&0xFFFF;
	Storage[3]=(Data&0xFFFF0000)>>16;
	Storage[4]=(Data&0xFFFF0000)>>16;
	Storage[5]=(Data&0xFFFF0000)>>16;

 }
 void Extract_Colors(int16_t Data,int* Storage)
 {
 	int Red=0, Blue=0, Green=0;
 	Red=(Data & 0xF800)>>11;
 	Blue=(Data & 0x001F);
 	Green=(Data & 0x07E0)>>5;
 	int Color=Red;
 	if(Color>32)
 		Storage[0]=32;
 	else
 		Storage[0]=Color;
 	Color=Green/2;
 	if(Color>32)
 		Storage[1]=32;
 	else
 		Storage[1]=Color;
 	Color=Blue;
 	if(Color>32)
 		Storage[2]=32;
 	else
 		Storage[2]=Color;
 	return ;
 }
void Capture_Image_Computer(int Address, int Frame)
{
	char filename[80];
	sprintf(filename, "/var/www/html/image0.ppm",Frame);
		FILE *foutput = fopen(filename, "w");
		if (foutput) {
			/* Use fprintf function to write to file through file pointer */
			fprintf(foutput, "P3\n320 240\n32\n");
			printf("Good: open \"%s\" for writing\n", filename);
			//
			int Pixels[6];
			int i=0,j=0;
			for ( i=0;i<240;i++)
			{
				for( j=0;j<160;j++)
				{
					int32_t Data_Memory_Case=alt_read_word(Address+ i*160*4+j*4+160*240*4*Frame);
					Convert_Pixels(Data_Memory_Case,Pixels);
					//printf( "%3d %3d %3d %3d %3d %3d ",Pixels[0,Pixels[1],Pixels[2],Pixels[3],Pixels[4],Pixels[5]);

					fprintf(foutput, "%3d %3d %3d %3d %3d %3d ",Pixels[0],Pixels[1],Pixels[2],Pixels[3],Pixels[4],Pixels[5]);

				}
				//printf( "\n");
				//printf( "%3d %3d %3d %3d %3d %3d \r\n",Pixels[0],Pixels[1],Pixels[2],Pixels[3],Pixels[4],Pixels[5]);

				fprintf(foutput, "\r\n");

			}
			fclose(foutput);
		    system("pnmtopng /var/www/html/image0.ppm > /var/www/html/image.png");
		}
		else
		{
			printf("Error: could not open \"%s\" for writing\n", filename);

		}
}
void Capture_Image_Computer_Gray(int Address, int Frame)
{
	char filename[80];
	sprintf(filename, "/var/www/html/image0_gray.ppm",Frame);
		FILE *foutput = fopen(filename, "w");
		if (foutput) {
			/* Use fprintf function to write to file through file pointer */
			fprintf(foutput, "P3\n320 240\n255\n");
			printf("Good: open \"%s\" for writing\n", filename);
			//
			int Pixels[6];
			int i=0,j=0;
			for ( i=0;i<240;i++)
			{
				for( j=0;j<160;j++)
				{
					int32_t Data_Memory_Case=alt_read_word(Address+ i*160*4+j*4+160*240*4*Frame);
					Convert_Pixels_Gray(Data_Memory_Case,Pixels);
					//printf( "%3d %3d %3d %3d %3d %3d ",Pixels[0,Pixels[1],Pixels[2],Pixels[3],Pixels[4],Pixels[5]);

					fprintf(foutput, "%3d %3d %3d %3d %3d %3d ",Pixels[0],Pixels[1],Pixels[2],Pixels[3],Pixels[4],Pixels[5]);

				}
				//printf( "\n");
				//printf( "%3d %3d %3d %3d %3d %3d \r\n",Pixels[0],Pixels[1],Pixels[2],Pixels[3],Pixels[4],Pixels[5]);

				fprintf(foutput, "\r\n");

			}
			fclose(foutput);
		    system("pnmtopng /var/www/html/image0_gray.ppm > /var/www/html/image_gray.png");
		}
		else
		{
			printf("Error: could not open \"%s\" for writing\n", filename);

		}
}
int main() {
    printf("DE1-SoC linux demo\n");

    open_physical_memory_device();
    mmap_peripherals();
    //setup_hps_gpio();
    //setup_fpga_leds();
    int i=0;
    while(1)
    	{
    	Capture_Image_Computer(Avalon_Bus_Address_Span_Expender,1);
    	Capture_Image_Computer_Gray(Avalon_Bus_Address_Span_Expender,0);
    		printf("Done\r\n");
    	};

    munmap_peripherals();
    close_physical_memory_device();

    return 0;
}
