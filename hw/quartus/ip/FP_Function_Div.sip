set_global_assignment -entity "FP_Function_Div" -library "lib_FP_Function_Div" -name IP_TOOL_NAME "altera_fp_functions"
set_global_assignment -entity "FP_Function_Div" -library "lib_FP_Function_Div" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "FP_Function_Div" -library "lib_FP_Function_Div" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_FP_Function_Div" -name SPD_FILE [file join $::quartus(sip_path) "FP_Function_Div.spd"]

set_global_assignment -library "lib_FP_Function_Div" -name MISC_FILE [file join $::quartus(sip_path) "FP_Function_Div_sim/FP_Function_Div_memoryC0_uid146_invTables_lutmem.hex"]
set_global_assignment -library "lib_FP_Function_Div" -name MISC_FILE [file join $::quartus(sip_path) "FP_Function_Div_sim/FP_Function_Div_memoryC0_uid147_invTables_lutmem.hex"]
set_global_assignment -library "lib_FP_Function_Div" -name MISC_FILE [file join $::quartus(sip_path) "FP_Function_Div_sim/FP_Function_Div_memoryC1_uid150_invTables_lutmem.hex"]
set_global_assignment -library "lib_FP_Function_Div" -name MISC_FILE [file join $::quartus(sip_path) "FP_Function_Div_sim/FP_Function_Div_memoryC1_uid151_invTables_lutmem.hex"]
set_global_assignment -library "lib_FP_Function_Div" -name MISC_FILE [file join $::quartus(sip_path) "FP_Function_Div_sim/FP_Function_Div_memoryC2_uid154_invTables_lutmem.hex"]
set_global_assignment -library "lib_FP_Function_Div" -name MISC_FILE [file join $::quartus(sip_path) "FP_Function_Div_sim/dspba_library_package.vhd"]
set_global_assignment -library "lib_FP_Function_Div" -name MISC_FILE [file join $::quartus(sip_path) "FP_Function_Div_sim/dspba_library.vhd"]
set_global_assignment -library "lib_FP_Function_Div" -name MISC_FILE [file join $::quartus(sip_path) "FP_Function_Div_sim/FP_Function_Div.vhd"]
