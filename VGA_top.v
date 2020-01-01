`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/01 13:25:30
// Design Name: 
// Module Name: VGA_top
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


module VGA_top(
    clk, rst,
    score0, score1,
    vgaRed, vgaGreen, vgaBlue, hsync, vsync
    );
input clk, rst;
input score0, score1;
output [3:0] vgaRed, vgaGreen, vgaBlue;
output hsync, vsync;

wire clk_25Mhz;
wire valid;
wire [9:0] h_cnt, v_cnt; // h: 640, v: 480
wire v_sync, h_sync;

clock_25MHz vga_clk(.clk(clk), .rst(rst), .nclk(clk_25Mhz));

vga_controll vga_ctrl(
    .clk(clk_25Mhz), .rst(rst),
    .hsync(h_sync), .vsync(v_sync), .valid(valid), .h_cnt(h_cnt), .v_cnt(v_cnt)
);

vga_pixel_gen display(
    .h_cnt(h_cnt), .v_cnt(v_cnt), .valid(valid),
    .vsync(v_sync), .hsync(h_sync), .score0(score0), .score1(score1),
    .vgaRed(vgaRed), .vgaGreen(vgaGreen), .vgaBlue(vgaBlue)
);

assign vsync = v_sync;
assign hsync = h_sync; 

endmodule
