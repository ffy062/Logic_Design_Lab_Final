`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/16 22:52:09
// Design Name: 
// Module Name: test
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



// top module

module top(
    clk, 
    rst, start, stop, 
    goal,
    seg, an, 
    pmod_1, pmod_2, pmod_4,
    vgaRed, vgaGreen, vgaBlue, hsync, vsync
    );
input clk, rst, goal, start, stop;
output [6:0] seg;
output [3:0] an;
output pmod_1, pmod_2, pmod_4;
output [3:0] vgaRed, vgaGreen, vgaBlue;
output hsync, vsync;

wire fsmclk, dclk, ssclk;
wire goal_d, goal_o, rst_o, rst_l, start_d, start_o, stop_d, stop_o; 
wire [3:0] dis0, dis1, dis2, dis3, num;

clock1Hz clk1s(clk, rst_o, fsmclk);
clock100Hz clkde(clk, rst_o, dclk);
clk_7seg clkss(clk, rst_o, ssclk);

debounce de_r(dclk, rst, rst_d);
one_pause op_r(clk, rst, rst_o);
long_press lp_r(clk, rst_d, rst_l);

debounce de_s(dclk, start, start_d);
one_pause op_s(clk, start_d, start_o);

debounce de_g(dclk, ~goal, goal_d);
one_pause op_g(clk, goal_d, goal_o);

debounce de_p(dclk, stop, stop_d);
one_pause op_p(clk, stop_d, stop_o);

fsm basket(
    clk, rst_l, start_o, stop_o, goal_o, 
    dis0, dis1, dis2, dis3, pmod_1, pmod_2, pmod_4
    );

s_segment ss(ssclk, rst_o, dis0, dis1, dis2, dis3, num, an);
sevensegment ss_d(num, seg);

VGA_top vga_display(
    .clk(clk), .rst(rst_l), .score0(dis0), .score1(dis1), 
    .vgaRed(vgaRed), .vgaGreen(vgaGreen), .vgaBlue(vgaBlue), .hsync(hsync), .vsync(vsync)
    );




endmodule



