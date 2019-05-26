################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../utils/alt_p2uart.c \
../utils/alt_printf.c \
../utils/alt_retarget_gnu.c 

OBJS += \
./utils/alt_p2uart.o \
./utils/alt_printf.o \
./utils/alt_retarget_gnu.o 

C_DEPS += \
./utils/alt_p2uart.d \
./utils/alt_printf.d \
./utils/alt_retarget_gnu.d 


# Each subdirectory must supply rules for building sources it contributes
utils/%.o: ../utils/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler 4 [arm-linux-gnueabihf]'
	arm-linux-gnueabihf-gcc -Dsoc_cv_av -IC:\intelFPGA\18.1\embedded\ip\altera\hps\altera_hps\hwlib\include -IC:\intelFPGA\18.1\embedded\ip\altera\hps\altera_hps\hwlib\include\soc_cv_av -O0 -g -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


