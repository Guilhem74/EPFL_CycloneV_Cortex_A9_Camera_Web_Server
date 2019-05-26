################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../hwmgr/soc_a10/alt_bridge_manager.c \
../hwmgr/soc_a10/alt_clock_manager.c \
../hwmgr/soc_a10/alt_ecc.c \
../hwmgr/soc_a10/alt_fpga_manager.c \
../hwmgr/soc_a10/alt_reset_manager.c \
../hwmgr/soc_a10/alt_sdram.c \
../hwmgr/soc_a10/alt_system_manager.c 

OBJS += \
./hwmgr/soc_a10/alt_bridge_manager.o \
./hwmgr/soc_a10/alt_clock_manager.o \
./hwmgr/soc_a10/alt_ecc.o \
./hwmgr/soc_a10/alt_fpga_manager.o \
./hwmgr/soc_a10/alt_reset_manager.o \
./hwmgr/soc_a10/alt_sdram.o \
./hwmgr/soc_a10/alt_system_manager.o 

C_DEPS += \
./hwmgr/soc_a10/alt_bridge_manager.d \
./hwmgr/soc_a10/alt_clock_manager.d \
./hwmgr/soc_a10/alt_ecc.d \
./hwmgr/soc_a10/alt_fpga_manager.d \
./hwmgr/soc_a10/alt_reset_manager.d \
./hwmgr/soc_a10/alt_sdram.d \
./hwmgr/soc_a10/alt_system_manager.d 


# Each subdirectory must supply rules for building sources it contributes
hwmgr/soc_a10/%.o: ../hwmgr/soc_a10/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler 4 [arm-linux-gnueabihf]'
	arm-linux-gnueabihf-gcc -Dsoc_cv_av -IC:\intelFPGA\18.1\embedded\ip\altera\hps\altera_hps\hwlib\include -IC:\intelFPGA\18.1\embedded\ip\altera\hps\altera_hps\hwlib\include\soc_cv_av -O0 -g -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


