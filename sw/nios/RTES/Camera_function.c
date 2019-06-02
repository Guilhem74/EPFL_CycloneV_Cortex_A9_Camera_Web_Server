#include "Camera_function.h"

#define CMOS_SENSOR_OUTPUT_GENERATOR_0_PIX_DEPTH_REDEFINED  (12)     /* cmos_sensor_output_generator pix depth from system.h (ADAPT TO YOUR DESIGN) */
#define Number_Of_Pixels_RGB CMOS_SENSOR_OUTPUT_GENERATOR_0_WIDTH*CMOS_SENSOR_OUTPUT_GENERATOR_0_HEIGHT/4 // One pixel = 4 sensors values
#define Number_Of_Memory_Slot Number_Of_Pixels_RGB/2 //One memory slot =2 Pixels


/* Camera Acquisition Module Part */
#define CAMERA_MODULE_REGISTER_ADDRESS                 (0 * 4) /* RW */
#define CAMERA_MODULE_REGISTER_LENGTH                (1 * 4) /* RW */
#define CAMERA_MODULE_REGISTER_START          (2 * 4) /* RW */
#define CAMERA_MODULE_REGISTER_STOP            (3 * 4) /* RW */
#define CAMERA_MODULE_REGISTER_SNAPSHOT             (4 * 4) /* RW */
#define CAMERA_MODULE_REGISTER_FLAG            (5 * 4) /* RW */
int Camera_Acquisition_Module_SETUP_Address_Memory(int Address)
{
	IOWR_32DIRECT(CAMERA_MODULE_0_BASE, CAMERA_MODULE_REGISTER_ADDRESS, Address);
	for (int i=0;i<10;i++);
	return IORD_32DIRECT(CAMERA_MODULE_0_BASE,CAMERA_MODULE_REGISTER_ADDRESS);
}
// Length : Number of pixel to store. reminder : 1 Memory slot =2 pixels and 1 memory slot = 4 bytes
int Camera_Acquisition_Module_SETUP_Length_Frame(int Pixel_Number)
{
	IOWR_32DIRECT(CAMERA_MODULE_0_BASE, CAMERA_MODULE_REGISTER_LENGTH, Pixel_Number/2*4);//*4 because 32bits;
	for (int i=0;i<10;i++);
	return IORD_32DIRECT(CAMERA_MODULE_0_BASE,CAMERA_MODULE_REGISTER_LENGTH);
}
int Camera_Acquisition_Module_Start()
{
	IOWR_32DIRECT(CAMERA_MODULE_0_BASE, CAMERA_MODULE_REGISTER_START, 1);//*4 because 32bits;
	for (int i=0;i<10;i++);
	return IORD_32DIRECT(CAMERA_MODULE_0_BASE,CAMERA_MODULE_REGISTER_START);
}
int Camera_Acquisition_Module_Stop()
{
	IOWR_32DIRECT(CAMERA_MODULE_0_BASE, CAMERA_MODULE_REGISTER_STOP, 1);//*4 because 32bits;
	for (int i=0;i<10;i++);
	return IORD_32DIRECT(CAMERA_MODULE_0_BASE,CAMERA_MODULE_REGISTER_STOP);
}
void Camera_Acquisition_Module_Display_Registers()
{
	printf("CAMERA_MODULE_REGISTER_ADDRESS=0x%x\r\n",IORD_32DIRECT(CAMERA_MODULE_0_BASE,CAMERA_MODULE_REGISTER_ADDRESS));
	printf("CAMERA_MODULE_REGISTER_LENGTH=%d\r\n",IORD_32DIRECT(CAMERA_MODULE_0_BASE,CAMERA_MODULE_REGISTER_LENGTH));
	printf("CAMERA_MODULE_REGISTER_START=%d\r\n",IORD_32DIRECT(CAMERA_MODULE_0_BASE,CAMERA_MODULE_REGISTER_START));
	printf("CAMERA_MODULE_REGISTER_STOP=%d\r\n",IORD_32DIRECT(CAMERA_MODULE_0_BASE,CAMERA_MODULE_REGISTER_STOP));
	printf("CAMERA_MODULE_REGISTER_SNAPSHOT=%d\r\n",IORD_32DIRECT(CAMERA_MODULE_0_BASE,CAMERA_MODULE_REGISTER_SNAPSHOT));
	printf("CAMERA_MODULE_REGISTER_FLAG=%d\r\n",IORD_32DIRECT(CAMERA_MODULE_0_BASE,CAMERA_MODULE_REGISTER_FLAG));
}
/* Pixels Generator Part */

 void Test_Camera_Memory()
 {
 	Camera_Acquisition_Module_Stop();
 	delay(5000);
 	Camera_Acquisition_Module_SETUP_Address_Memory(SDRAM_CONTROLLER_BASE);//Address of the HPC, 256 MB Available from it
 	Camera_Acquisition_Module_SETUP_Length_Frame(76800);//320*240
 	Camera_Acquisition_Module_Start();//Set a one in the start register


 			Capture_Image_Computer(SDRAM_CONTROLLER_BASE,2);
 			Capture_Image_Computer(SDRAM_CONTROLLER_BASE,1);
 			Capture_Image_Computer(SDRAM_CONTROLLER_BASE,0);


 }
 void Capture_Image_Computer(int Address, int Frame)
 {
 	char filename[80];
 	sprintf(filename, "/mnt/host/image%d.ppm",Frame);
 		FILE *foutput = fopen(filename, "w");
 		if (foutput) {
 			/* Use fprintf function to write to file through file pointer */
 			fprintf(foutput, "P3\n320 240\n32\n");
 			printf("Good: open \"%s\" for writing\n", filename);
 			//
 			delay(5000000);
 			int Pixels[6];

 			for (int i=0;i<240;i++)
 			{
 				for(int j=0;j<160;j++)
 				{
 					int32_t Data_Memory_Case=IORD_32DIRECT(Address, i*160*4+j*4+160*240*4*Frame);
 					Convert_Pixels(Data_Memory_Case,Pixels);
 					//printf( "%3d %3d %3d %3d %3d %3d ",Pixels[0,Pixels[1],Pixels[2],Pixels[3],Pixels[4],Pixels[5]);

 					fprintf(foutput, "%3d %3d %3d %3d %3d %3d ",Pixels[0],Pixels[1],Pixels[2],Pixels[3],Pixels[4],Pixels[5]);

 				}
 				//printf( "\n");
 				printf( "%3d %3d %3d %3d %3d %3d ",Pixels[0],Pixels[1],Pixels[2],Pixels[3],Pixels[4],Pixels[5]);

 				fprintf(foutput, "\r\n");

 			}
 			fclose(foutput);
 		}
 		else
 		{
 			printf("Error: could not open \"%s\" for writing\n", filename);

 		}
 }

 void delay(int duration )
 {
 	int i;
 	for (i=0;i<duration;i++);
 }
 void Convert_Pixels(int32_t Data,int* Storage)
 {
 	Extract_Colors(Data&0xFFFF,Storage);
 	Extract_Colors((Data&0xFFFF0000)>>16,Storage+3);

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
