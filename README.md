EPFL_CycloneV_Cortex_A9_Camera_Web_Server

- Using a Multiprocessor architecture to capture, filter and display an image.
- Multimaster system to perform the filtering: Hardware Accelerator, NIOS Processor and ARM Processor. Then compare the performances of the different designs.
- Displaying the image on a WebServer.

Driver linux is available in sw/hps/application/DE1_SoC_demo_hps_linux_2/
-> Access to the sdram to read two consecutives images of 320x240 pixels

Accelerator hdl and configuration is available in hw/hdl files and sw/nios/RTES/

Profiling showed that the accelerator unit with floating point hardware was a lot faster than the C code implemented in the NIOS processor. But the ARM processor, with its 800MHz clock achieved similar results than the accelerator.

For a single processing both are quite equivalent for an image of 320*240px.

Hardware accelerator could be interesting in the parallelisation of the image processing.
