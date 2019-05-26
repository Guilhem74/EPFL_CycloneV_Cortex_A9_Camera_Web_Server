################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../hwmgr/soc_cv_av/alt_bridge_f2s_armcc.s \
../hwmgr/soc_cv_av/alt_bridge_f2s_gnu.s 

C_SRCS += \
../hwmgr/soc_cv_av/alt_bridge_manager.c \
../hwmgr/soc_cv_av/alt_clock_manager.c \
../hwmgr/soc_cv_av/alt_clock_manager_init.c \
../hwmgr/soc_cv_av/alt_ecc.c \
../hwmgr/soc_cv_av/alt_fpga_manager.c \
../hwmgr/soc_cv_av/alt_reset_manager.c \
../hwmgr/soc_cv_av/alt_sdram.c \
../hwmgr/soc_cv_av/alt_system_manager.c 

OBJS += \
./hwmgr/soc_cv_av/alt_bridge_f2s_armcc.o \
./hwmgr/soc_cv_av/alt_bridge_f2s_gnu.o \
./hwmgr/soc_cv_av/alt_bridge_manager.o \
./hwmgr/soc_cv_av/alt_clock_manager.o \
./hwmgr/soc_cv_av/alt_clock_manager_init.o \
./hwmgr/soc_cv_av/alt_ecc.o \
./hwmgr/soc_cv_av/alt_fpga_manager.o \
./hwmgr/soc_cv_av/alt_reset_manager.o \
./hwmgr/soc_cv_av/alt_sdram.o \
./hwmgr/soc_cv_av/alt_system_manager.o 

C_DEPS += \
./hwmgr/soc_cv_av/alt_bridge_manager.d \
./hwmgr/soc_cv_av/alt_clock_manager.d \
./hwmgr/soc_cv_av/alt_clock_manager_init.d \
./hwmgr/soc_cv_av/alt_ecc.d \
./hwmgr/soc_cv_av/alt_fpga_manager.d \
./hwmgr/soc_cv_av/alt_reset_manager.d \
./hwmgr/soc_cv_av/alt_sdram.d \
./hwmgr/soc_cv_av/alt_system_manager.d 


# Each subdirectory must supply rules for building sources it contributes
hwmgr/soc_cv_av/%.o: ../hwmgr/soc_cv_av/%.s
	@echo 'Building file: $<'
	@echo 'Invoking: GCC Assembler 4 [arm-linux-gnueabihf]'
	arm-linux-gnueabihf-as  -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

hwmgr/soc_cv_av/%.o: ../hwmgr/soc_cv_av/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler 4 [arm-linux-gnueabihf]'
	arm-linux-gnueabihf-gcc -Dsoc_cv_av -IC:\intelFPGA\18.1\embedded\ip\altera\hps\altera_hps\hwlib\include -IC:\intelFPGA\18.1\embedded\ip\altera\hps\altera_hps\hwlib\include\soc_cv_av -O0 -g -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


