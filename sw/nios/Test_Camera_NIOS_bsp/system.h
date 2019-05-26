/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'nios2_gen2_0' in SOPC Builder design 'soc_system'
 * SOPC Builder design path: C:/EPFL_CycloneV_Cortex_A9_Camera_Web_Server/hw/quartus/soc_system.sopcinfo
 *
 * Generated: Sun May 26 20:34:42 CEST 2019
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_gen2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x04000820
#define ALT_CPU_CPU_ARCH_NIOS2_R1
#define ALT_CPU_CPU_FREQ 100000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "fast"
#define ALT_CPU_DATA_ADDR_WIDTH 0x1b
#define ALT_CPU_DCACHE_BYPASS_MASK 0x80000000
#define ALT_CPU_DCACHE_LINE_SIZE 32
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_DCACHE_SIZE 2048
#define ALT_CPU_EXCEPTION_ADDR 0x00000020
#define ALT_CPU_FLASH_ACCELERATOR_LINES 0
#define ALT_CPU_FLASH_ACCELERATOR_LINE_SIZE 0
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 100000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 1
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_EXTRA_EXCEPTION_INFO
#define ALT_CPU_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 32
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_ICACHE_SIZE 4096
#define ALT_CPU_INITDA_SUPPORTED
#define ALT_CPU_INST_ADDR_WIDTH 0x1b
#define ALT_CPU_NAME "nios2_gen2_0"
#define ALT_CPU_NUM_OF_SHADOW_REG_SETS 0
#define ALT_CPU_OCI_VERSION 1
#define ALT_CPU_RESET_ADDR 0x00000000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x04000820
#define NIOS2_CPU_ARCH_NIOS2_R1
#define NIOS2_CPU_FREQ 100000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_DATA_ADDR_WIDTH 0x1b
#define NIOS2_DCACHE_BYPASS_MASK 0x80000000
#define NIOS2_DCACHE_LINE_SIZE 32
#define NIOS2_DCACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_SIZE 2048
#define NIOS2_EXCEPTION_ADDR 0x00000020
#define NIOS2_FLASH_ACCELERATOR_LINES 0
#define NIOS2_FLASH_ACCELERATOR_LINE_SIZE 0
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 1
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_EXTRA_EXCEPTION_INFO
#define NIOS2_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_ICACHE_SIZE 4096
#define NIOS2_INITDA_SUPPORTED
#define NIOS2_INST_ADDR_WIDTH 0x1b
#define NIOS2_NUM_OF_SHADOW_REG_SETS 0
#define NIOS2_OCI_VERSION 1
#define NIOS2_RESET_ADDR 0x00000000


/*
 * Camera_Component_0 configuration
 *
 */

#define ALT_MODULE_CLASS_Camera_Component_0 Camera_Component
#define CAMERA_COMPONENT_0_BASE 0x4001000
#define CAMERA_COMPONENT_0_IRQ -1
#define CAMERA_COMPONENT_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CAMERA_COMPONENT_0_NAME "/dev/Camera_Component_0"
#define CAMERA_COMPONENT_0_SPAN 32
#define CAMERA_COMPONENT_0_TYPE "Camera_Component"


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_NEW_SDRAM_CONTROLLER
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SYSID_QSYS
#define __ALTERA_NIOS2_GEN2
#define __CAMERA_COMPONENT
#define __I2C


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone V"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart_0"
#define ALT_STDERR_BASE 0x4001038
#define ALT_STDERR_DEV jtag_uart_0
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart_0"
#define ALT_STDIN_BASE 0x4001038
#define ALT_STDIN_DEV jtag_uart_0
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart_0"
#define ALT_STDOUT_BASE 0x4001038
#define ALT_STDOUT_DEV jtag_uart_0
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "soc_system"


/*
 * hal configuration
 *
 */

#define ALT_INCLUDE_INSTRUCTION_RELATED_EXCEPTION_API
#define ALT_MAX_FD 32
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none


/*
 * i2c_Component configuration
 *
 */

#define ALT_MODULE_CLASS_i2c_Component I2c
#define I2C_COMPONENT_BASE 0x4001040
#define I2C_COMPONENT_IRQ -1
#define I2C_COMPONENT_IRQ_INTERRUPT_CONTROLLER_ID -1
#define I2C_COMPONENT_NAME "/dev/i2c_Component"
#define I2C_COMPONENT_SPAN 4
#define I2C_COMPONENT_TYPE "I2c"


/*
 * jtag_uart_0 configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart_0 altera_avalon_jtag_uart
#define JTAG_UART_0_BASE 0x4001038
#define JTAG_UART_0_IRQ 0
#define JTAG_UART_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_0_NAME "/dev/jtag_uart_0"
#define JTAG_UART_0_READ_DEPTH 64
#define JTAG_UART_0_READ_THRESHOLD 8
#define JTAG_UART_0_SPAN 8
#define JTAG_UART_0_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_0_WRITE_DEPTH 64
#define JTAG_UART_0_WRITE_THRESHOLD 8


/*
 * nios_leds configuration
 *
 */

#define ALT_MODULE_CLASS_nios_leds altera_avalon_pio
#define NIOS_LEDS_BASE 0x4001020
#define NIOS_LEDS_BIT_CLEARING_EDGE_REGISTER 0
#define NIOS_LEDS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define NIOS_LEDS_CAPTURE 0
#define NIOS_LEDS_DATA_WIDTH 4
#define NIOS_LEDS_DO_TEST_BENCH_WIRING 0
#define NIOS_LEDS_DRIVEN_SIM_VALUE 0
#define NIOS_LEDS_EDGE_TYPE "NONE"
#define NIOS_LEDS_FREQ 50000000
#define NIOS_LEDS_HAS_IN 0
#define NIOS_LEDS_HAS_OUT 1
#define NIOS_LEDS_HAS_TRI 0
#define NIOS_LEDS_IRQ -1
#define NIOS_LEDS_IRQ_INTERRUPT_CONTROLLER_ID -1
#define NIOS_LEDS_IRQ_TYPE "NONE"
#define NIOS_LEDS_NAME "/dev/nios_leds"
#define NIOS_LEDS_RESET_VALUE 0
#define NIOS_LEDS_SPAN 16
#define NIOS_LEDS_TYPE "altera_avalon_pio"


/*
 * sdram_controller_0 configuration
 *
 */

#define ALT_MODULE_CLASS_sdram_controller_0 altera_avalon_new_sdram_controller
#define SDRAM_CONTROLLER_0_BASE 0x0
#define SDRAM_CONTROLLER_0_CAS_LATENCY 3
#define SDRAM_CONTROLLER_0_CONTENTS_INFO
#define SDRAM_CONTROLLER_0_INIT_NOP_DELAY 0.0
#define SDRAM_CONTROLLER_0_INIT_REFRESH_COMMANDS 2
#define SDRAM_CONTROLLER_0_IRQ -1
#define SDRAM_CONTROLLER_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SDRAM_CONTROLLER_0_IS_INITIALIZED 1
#define SDRAM_CONTROLLER_0_NAME "/dev/sdram_controller_0"
#define SDRAM_CONTROLLER_0_POWERUP_DELAY 100.0
#define SDRAM_CONTROLLER_0_REFRESH_PERIOD 7.8125
#define SDRAM_CONTROLLER_0_REGISTER_DATA_IN 1
#define SDRAM_CONTROLLER_0_SDRAM_ADDR_WIDTH 0x19
#define SDRAM_CONTROLLER_0_SDRAM_BANK_WIDTH 2
#define SDRAM_CONTROLLER_0_SDRAM_COL_WIDTH 10
#define SDRAM_CONTROLLER_0_SDRAM_DATA_WIDTH 16
#define SDRAM_CONTROLLER_0_SDRAM_NUM_BANKS 4
#define SDRAM_CONTROLLER_0_SDRAM_NUM_CHIPSELECTS 1
#define SDRAM_CONTROLLER_0_SDRAM_ROW_WIDTH 13
#define SDRAM_CONTROLLER_0_SHARED_DATA 0
#define SDRAM_CONTROLLER_0_SIM_MODEL_BASE 0
#define SDRAM_CONTROLLER_0_SPAN 67108864
#define SDRAM_CONTROLLER_0_STARVATION_INDICATOR 0
#define SDRAM_CONTROLLER_0_TRISTATE_BRIDGE_SLAVE ""
#define SDRAM_CONTROLLER_0_TYPE "altera_avalon_new_sdram_controller"
#define SDRAM_CONTROLLER_0_T_AC 5.4
#define SDRAM_CONTROLLER_0_T_MRD 3
#define SDRAM_CONTROLLER_0_T_RCD 15.0
#define SDRAM_CONTROLLER_0_T_RFC 70.0
#define SDRAM_CONTROLLER_0_T_RP 15.0
#define SDRAM_CONTROLLER_0_T_WR 14.0


/*
 * sysid configuration
 *
 */

#define ALT_MODULE_CLASS_sysid altera_avalon_sysid_qsys
#define SYSID_BASE 0x4001030
#define SYSID_ID 0
#define SYSID_IRQ -1
#define SYSID_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_NAME "/dev/sysid"
#define SYSID_SPAN 8
#define SYSID_TIMESTAMP 1558894435
#define SYSID_TYPE "altera_avalon_sysid_qsys"

#endif /* __SYSTEM_H_ */
