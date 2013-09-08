# Clock / Reset
set_location_assignment PIN_AD27 -to rst_n_pad_i
set_location_assignment PIN_AF14 -to sys_clk_pad_i
set_instance_assignment -name IO_STANDARD "1.5 V" -to sys_clk_pad_i

# UART
#set_location_assignment PIN_B25 -to uart0_srx_pad_i
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to uart0_srx_pad_i
#set_location_assignment PIN_C25 -to uart0_stx_pad_o
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to uart0_stx_pad_o

# GPIO
# gpio0_io[3:0] connected to leds
set_location_assignment PIN_AF10 -to gpio0_io[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[0]
set_location_assignment PIN_AD10 -to gpio0_io[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[1]
set_location_assignment PIN_AE11 -to gpio0_io[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[2]
set_location_assignment PIN_AD7 -to gpio0_io[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[3]
#set_location_assignment PIN_xxx -to gpio0_io[4]
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[4]
#set_location_assignment PIN_xxx -to gpio0_io[5]
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[5]
#set_location_assignment PIN_xxx -to gpio0_io[6]
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[6]
#set_location_assignment PIN_xxx -to gpio0_io[7]
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[7]
