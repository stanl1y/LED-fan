# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

#7 segment display
#set_property PACKAGE_PIN W7 [get_ports {display[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {display[0]}]
#set_property PACKAGE_PIN W6 [get_ports {display[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {display[1]}]
#set_property PACKAGE_PIN U8 [get_ports {display[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {display[2]}]
#set_property PACKAGE_PIN V8 [get_ports {display[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {display[3]}]
#set_property PACKAGE_PIN U5 [get_ports {display[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {display[4]}]
#set_property PACKAGE_PIN V5 [get_ports {display[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {display[5]}]
#set_property PACKAGE_PIN U7 [get_ports {display[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {display[6]}]

#set_property PACKAGE_PIN V7 [get_ports dp]
#set_property IOSTANDARD LVCMOS33 [get_ports dp]

#set_property PACKAGE_PIN U2 [get_ports {digit[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {digit[0]}]
#set_property PACKAGE_PIN U4 [get_ports {digit[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {digit[1]}]
#set_property PACKAGE_PIN V4 [get_ports {digit[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {digit[2]}]
#set_property PACKAGE_PIN W4 [get_ports {digit[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {digit[3]}]


#Buttons
set_property PACKAGE_PIN U18 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

#USB HID (PS/2)
set_property PACKAGE_PIN C17 [get_ports PS2_CLK]
set_property IOSTANDARD LVCMOS33 [get_ports PS2_CLK]
set_property PULLUP true [get_ports PS2_CLK]
set_property PACKAGE_PIN B17 [get_ports PS2_DATA]
set_property IOSTANDARD LVCMOS33 [get_ports PS2_DATA]
set_property PULLUP true [get_ports PS2_DATA]


set_property IOSTANDARD LVCMOS33 [get_ports {led[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property PACKAGE_PIN A17 [get_ports {led[5]}]
set_property PACKAGE_PIN A15 [get_ports {led[4]}]
set_property PACKAGE_PIN B16 [get_ports {led[3]}]
set_property PACKAGE_PIN B15 [get_ports {led[2]}]
set_property PACKAGE_PIN A16 [get_ports {led[1]}]
set_property PACKAGE_PIN A14 [get_ports {led[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports {led[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[12]}]
set_property PACKAGE_PIN C15 [get_ports {led[6]}]
set_property PACKAGE_PIN C16 [get_ports {led[7]}]
set_property PACKAGE_PIN K17 [get_ports {led[8]}]
set_property PACKAGE_PIN M18 [get_ports {led[9]}]
set_property PACKAGE_PIN N17 [get_ports {led[10]}]
set_property PACKAGE_PIN P18 [get_ports {led[11]}]
set_property PACKAGE_PIN L17 [get_ports {led[12]}]
set_property PACKAGE_PIN M19 [get_ports {led[13]}]
set_property PACKAGE_PIN P17 [get_ports {led[14]}]
set_property PACKAGE_PIN R18 [get_ports {led[15]}]

set_property IOSTANDARD LVCMOS33 [get_ports {clockstate_led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {clockstate_led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {clockstate_led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {clockstate_led[0]}]
set_property PACKAGE_PIN U16 [get_ports {clockstate_led[0]}]
set_property PACKAGE_PIN E19 [get_ports {clockstate_led[1]}]
set_property PACKAGE_PIN U19 [get_ports {clockstate_led[2]}]
set_property PACKAGE_PIN V19 [get_ports {clockstate_led[3]}]

