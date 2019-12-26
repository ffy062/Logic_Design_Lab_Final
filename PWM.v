`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/26 13:21:30
// Design Name: 
// Module Name: PWM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PWM(clk, rst, freq, duty, pwm);
input clk, rst;
input [31:0]freq;
input [9:0] duty;
output pwm;

wire [31:0] cnt_max = 32'd100_000_000 / freq;
wire [31:0] duty_cyc = cnt_max * duty / 1024;



endmodule
