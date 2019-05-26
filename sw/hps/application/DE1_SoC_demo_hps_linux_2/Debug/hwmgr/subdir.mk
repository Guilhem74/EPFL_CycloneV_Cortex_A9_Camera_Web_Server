################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../hwmgr/alt_interrupt_armcc.s \
../hwmgr/alt_interrupt_armclang.s 

C_SRCS += \
../hwmgr/alt_16550_uart.c \
../hwmgr/alt_address_space.c \
../hwmgr/alt_cache.c \
../hwmgr/alt_can.c \
../hwmgr/alt_dma.c \
../hwmgr/alt_dma_program.c \
../hwmgr/alt_generalpurpose_io.c \
../hwmgr/alt_globaltmr.c \
../hwmgr/alt_i2c.c \
../hwmgr/alt_interrupt.c \
../hwmgr/alt_mmu.c \
../hwmgr/alt_nand.c \
../hwmgr/alt_qspi.c \
../hwmgr/alt_sdmmc.c \
../hwmgr/alt_spi.c \
../hwmgr/alt_timers.c \
../hwmgr/alt_watchdog.c 

OBJS += \
./hwmgr/alt_16550_uart.o \
./hwmgr/alt_address_space.o \
./hwmgr/alt_cache.o \
./hwmgr/alt_can.o \
./hwmgr/alt_dma.o \
./hwmgr/alt_dma_program.o \
./hwmgr/alt_generalpurpose_io.o \
./hwmgr/alt_globaltmr.o \
./hwmgr/alt_i2c.o \
./hwmgr/alt_interrupt.o \
./hwmgr/alt_interrupt_armcc.o \
./hwmgr/alt_interrupt_armclang.o \
./hwmgr/alt_mmu.o \
./hwmgr/alt_nand.o \
./hwmgr/alt_qspi.o \
./hwmgr/alt_sdmmc.o \
./hwmgr/alt_spi.o \
./hwmgr/alt_timers.o \
./hwmgr/alt_watchdog.o 

C_DEPS += \
./hwmgr/alt_16550_uart.d \
./hwmgr/alt_address_space.d \
./hwmgr/alt_cache.d \
./hwmgr/alt_can.d \
./hwmgr/alt_dma.d \
./hwmgr/alt_dma_program.d \
./hwmgr/alt_generalpurpose_io.d \
./hwmgr/alt_globaltmr.d \
./hwmgr/alt_i2c.d \
./hwmgr/alt_interrupt.d \
./hwmgr/alt_mmu.d \
./hwmgr/alt_nand.d \
./hwmgr/alt_qspi.d \
./hwmgr/alt_sdmmc.d \
./hwmgr/alt_spi.d \
./hwmgr/alt_timers.d \
./hwmgr/alt_watchdog.d 


# Each subdirectory must supply rules for building sources it contributes
hwmgr/%.o: ../hwmgr/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler 4 [arm-linux-gnueabihf]'
	arm-linux-gnueabihf-gcc -Dsoc_cv_av -IC:\intelFPGA\18.1\embedded\ip\altera\hps\altera_hps\hwlib\include -IC:\intelFPGA\18.1\embedded\ip\altera\hps\altera_hps\hwlib\include\soc_cv_av -O0 -g -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

hwmgr/%.o: ../hwmgr/%.s
	@echo 'Building file: $<'
	@echo 'Invoking: GCC Assembler 4 [arm-linux-gnueabihf]'
	arm-linux-gnueabihf-as  -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


