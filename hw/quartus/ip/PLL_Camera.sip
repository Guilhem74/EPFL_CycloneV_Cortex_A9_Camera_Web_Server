set_global_assignment -entity "PLL_Camera" -library "lib_PLL_Camera" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "PLL_Camera" -library "lib_PLL_Camera" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "PLL_Camera" -library "lib_PLL_Camera" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_PLL_Camera" -name SPD_FILE [file join $::quartus(sip_path) "PLL_Camera.spd"]

set_global_assignment -library "lib_PLL_Camera" -name MISC_FILE [file join $::quartus(sip_path) "PLL_Camera_sim/PLL_Camera.vho"]
