## Clock Signal
## System clock connected to W5
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports clk_100MHz]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk_100MHz]

## SPI Interface (Connected to JB Header)
## SPI Clock
set_property -dict { PACKAGE_PIN B16   IOSTANDARD LVCMOS33 } [get_ports sclk]
## SPI Data In (Master In, Slave Out)
set_property -dict { PACKAGE_PIN B15   IOSTANDARD LVCMOS33 } [get_ports miso]
## SPI Chip Select
set_property -dict { PACKAGE_PIN A14   IOSTANDARD LVCMOS33 } [get_ports cs_n]

## Reset Signal
## Reset Button (btnC)
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports reset_n]

## Seven-Segment Display Segments
## Segment 0
set_property -dict { PACKAGE_PIN W7   IOSTANDARD LVCMOS33 } [get_ports {seg[0]}]
## Segment 1
set_property -dict { PACKAGE_PIN W6   IOSTANDARD LVCMOS33 } [get_ports {seg[1]}]
## Segment 2
set_property -dict { PACKAGE_PIN U8   IOSTANDARD LVCMOS33 } [get_ports {seg[2]}]
## Segment 3
set_property -dict { PACKAGE_PIN V8   IOSTANDARD LVCMOS33 } [get_ports {seg[3]}]
## Segment 4
set_property -dict { PACKAGE_PIN U5   IOSTANDARD LVCMOS33 } [get_ports {seg[4]}]
## Segment 5
set_property -dict { PACKAGE_PIN V5   IOSTANDARD LVCMOS33 } [get_ports {seg[5]}]
## Segment 6
set_property -dict { PACKAGE_PIN U7   IOSTANDARD LVCMOS33 } [get_ports {seg[6]}]

## Seven-Segment Digit Enable (Anodes)
## Digit 0 Enable
set_property -dict { PACKAGE_PIN U2   IOSTANDARD LVCMOS33 } [get_ports {digit[0]}]
## Digit 1 Enable
set_property -dict { PACKAGE_PIN U4   IOSTANDARD LVCMOS33 } [get_ports {digit[1]}]
## Digit 2 Enable
set_property -dict { PACKAGE_PIN V4   IOSTANDARD LVCMOS33 } [get_ports {digit[2]}]
## Digit 3 Enable
set_property -dict { PACKAGE_PIN W4   IOSTANDARD LVCMOS33 } [get_ports {digit[3]}]

## Configuration Options
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
