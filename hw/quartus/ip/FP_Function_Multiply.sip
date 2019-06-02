set_global_assignment -entity "FP_Function_Multiply" -library "lib_FP_Function_Multiply" -name IP_TOOL_NAME "altera_fp_functions"
set_global_assignment -entity "FP_Function_Multiply" -library "lib_FP_Function_Multiply" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "FP_Function_Multiply" -library "lib_FP_Function_Multiply" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_FP_Function_Multiply" -name SPD_FILE [file join $::quartus(sip_path) "FP_Function_Multiply.spd"]

set_global_assignment -library "lib_FP_Function_Multiply" -name MISC_FILE [file join $::quartus(sip_path) "FP_Function_Multiply_sim/dspba_library_package.vhd"]
set_global_assignment -library "lib_FP_Function_Multiply" -name MISC_FILE [file join $::quartus(sip_path) "FP_Function_Multiply_sim/dspba_library.vhd"]
set_global_assignment -library "lib_FP_Function_Multiply" -name MISC_FILE [file join $::quartus(sip_path) "FP_Function_Multiply_sim/FP_Function_Multiply.vhd"]
