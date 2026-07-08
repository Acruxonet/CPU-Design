// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Mon Jun 26 15:11:09 2023
// Host        : LAPTOP-E4IJ843E running 64-bit major release  (build 9200)
// Command     : write_verilog -mode synth_stub C:/Users/user/Desktop/projects/edf_file/MIO_BUS.v
// Design      : MIO_BUS
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module MIO_BUS(clk, rst, BTN, SW, PC, mem_w, Cpu_data2bus, addr_bus,
  ram_data_out, led_out, counter_out, counter0_out, counter1_out, counter2_out, Cpu_data4bus,
  ram_data_in, ram_addr, data_ram_we, GPIOf0000000_we, GPIOe0000000_we, counter_we,
  Peripheral_in)
/* synthesis syn_black_box black_box_pad_pin="clk,rst,BTN[4:0],SW[15:0],PC[31:0],mem_w,Cpu_data2bus[31:0],addr_bus[31:0],ram_data_out[31:0],led_out[15:0],counter_out[31:0],counter0_out,counter1_out,counter2_out,Cpu_data4bus[31:0],ram_data_in[31:0],ram_addr[9:0],data_ram_we,GPIOf0000000_we,GPIOe0000000_we,counter_we,Peripheral_in[31:0]" */;
  input wire clk;
  input wire rst;
  input wire [4:0]BTN;
  input wire [15:0]SW;
  input wire [31:0]PC;
  input wire mem_w;
  input wire [31:0]Cpu_data2bus;
  input wire [31:0]addr_bus;
  input wire [31:0]ram_data_out;
  input wire [15:0]led_out;
  input wire [31:0]counter_out;
  input wire counter0_out;
  input wire counter1_out;
  input wire counter2_out;
  output wire [31:0]Cpu_data4bus;
  output wire [31:0]ram_data_in;
  output wire [9:0]ram_addr;
  output wire data_ram_we;
  output wire GPIOf0000000_we;
  output wire GPIOe0000000_we;
  output wire counter_we;
  output wire [31:0]Peripheral_in;
endmodule
