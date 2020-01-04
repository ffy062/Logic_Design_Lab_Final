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

// btnU short: change theme long: reset
// btnC start game
// btnL practice mode
// btnR game pause
// btnD back

module top(
    clk, 
    btnU, btnC, btnR, btnL, btnD,
    sw0, sw1, 
    goal,
    seg, an, 
    pmod_1, pmod_2, pmod_4,
    vgaRed, vgaGreen, vgaBlue, hsync, vsync
    );
input clk;
input btnU, btnC, btnR, btnL, btnD;
input goal;
input sw0, sw1;
output [6:0] seg;
output [3:0] an;
output pmod_1, pmod_2, pmod_4;
output [3:0] vgaRed, vgaGreen, vgaBlue;
output hsync, vsync;

wire fsmclk, dclk, ssclk;
wire goal_d, goal_o, btnU_o, btnU_l, btnC_d, btnC_o, btnR_d, btnR_o;
wire btnL_d, btnL_o, btnD_d, btnD_o; 
wire [3:0] dis0, dis1, dis2, dis3, num;
wire [3:0] state;

clock1Hz clk1s(clk, btnU_o, fsmclk);
clock100Hz clkde(clk, btnU_o, dclk);
clk_7seg clkss(clk, btnU_o, ssclk);

debounce de_u(dclk, btnU, btnU_d);
one_pause op_u(clk, btnU_d, btnU_o);
long_press lp_u(clk, btnU_d, btnU_l);

debounce de_c(dclk, btnC, btnC_d);
one_pause op_c(clk, btnC_d, btnC_o);

debounce de_g(dclk, ~goal, goal_d);
one_pause op_g(clk, goal_d, goal_o);

debounce de_r(dclk, btnR, btnR_d);
one_pause op_r(clk, btnR_d, btnR_o);

debounce de_l(dclk, btnL, btnL_d);
one_pause op_l(clk, btnL_d, btnL_o);

debounce de_d(dclk, btnD, btnD_d);
one_pause op_d(clk, btnD_d, btnD_o);

fsm basket(
    .clk(clk), .rst(btnU_l), .start(btnC_o), .stop(btnR_o),
    .pmode(btnL_o), .back(btnD_o), .goal(goal_o), 
    .dig0(dis0), .dig1(dis1), .dig2(dis2), .dig3(dis3), .c_state(state), 
    .pmod1(pmod_1), .pmod2(pmod_2), .pmod4(pmod_4)
    );

s_segment ss(ssclk, btnU_o, dis0, dis1, dis2, dis3, num, an);
sevensegment ss_d(num, seg);

VGA_top vga_display(
    .clk(clk), .rst(btnU_l), .theme_c(btnU_o), 
    .state(state), .score0(dis0), .score1(dis1), .cnt0(dis2), .cnt1(dis3),
    .vgaRed(vgaRed), .vgaGreen(vgaGreen), .vgaBlue(vgaBlue), 
    .hsync(hsync), .vsync(vsync)
    );


endmodule



