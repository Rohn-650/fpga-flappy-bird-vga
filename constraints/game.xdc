# Clock
set_property PACKAGE_PIN Y9 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]
create_clock -period 10.000 [get_ports clk]

# Buttons
# Center (BTNC) - System Reset
set_property PACKAGE_PIN P16 [get_ports {reset_hw}]
set_property IOSTANDARD LVCMOS18 [get_ports {reset_hw}]

# Right (BTNR) - Game Restart
set_property PACKAGE_PIN R18 [get_ports {btn_restart}]
set_property IOSTANDARD LVCMOS18 [get_ports {btn_restart}]

# Upper (BTNU) - Jump Trigger
set_property PACKAGE_PIN T18 [get_ports {btn_jump}]
set_property IOSTANDARD LVCMOS18 [get_ports {btn_jump}]

# VGA
set_property PACKAGE_PIN AA19 [get_ports {hsync}]
set_property PACKAGE_PIN Y19  [get_ports {vsync}]
set_property IOSTANDARD LVCMOS33 [get_ports {hsync}]
set_property IOSTANDARD LVCMOS33 [get_ports {vsync}]

# Colors
set_property PACKAGE_PIN V20 [get_ports {r[0]}]
set_property PACKAGE_PIN U20 [get_ports {r[1]}]
set_property PACKAGE_PIN V19 [get_ports {r[2]}]
set_property PACKAGE_PIN V18 [get_ports {r[3]}]
set_property PACKAGE_PIN AB22 [get_ports {g[0]}]
set_property PACKAGE_PIN AB21 [get_ports {g[1]}]
set_property PACKAGE_PIN AA22 [get_ports {g[2]}]
set_property PACKAGE_PIN AA21 [get_ports {g[3]}]
set_property PACKAGE_PIN Y21 [get_ports {b[0]}]
set_property PACKAGE_PIN Y20 [get_ports {b[1]}]
set_property PACKAGE_PIN AB20 [get_ports {b[2]}]
set_property PACKAGE_PIN AB19 [get_ports {b[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {r[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {g[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[*]}]

# LED for Debug
set_property PACKAGE_PIN T22 [get_ports {LED[0]}]
set_property PACKAGE_PIN T21 [get_ports {LED[1]}]
set_property PACKAGE_PIN U22 [get_ports {LED[2]}]
set_property PACKAGE_PIN U21 [get_ports {LED[3]}]
set_property PACKAGE_PIN V22 [get_ports {LED[4]}]
set_property PACKAGE_PIN W22 [get_ports {LED[5]}]
set_property PACKAGE_PIN U19 [get_ports {LED[6]}]
set_property PACKAGE_PIN U14 [get_ports {LED[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[*]}]