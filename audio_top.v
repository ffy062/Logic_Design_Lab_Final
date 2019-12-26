`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/26 13:18:32
// Design Name: 
// Module Name: audio_top
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


module audio_top(clk, rst, play, loop, pmod_1, pmod_2, pmod_4);
input clk, rst, play, loop;
output pmod_1, pmod_2, pmod_4;

parameter beat_freq = 23'd8; // one beat  = 1/8 sec
parameter duty = 10'd512; // duty cycle = 50 %

wire sp_clk;
wire [31:0]freq;
wire [7:0] beatnum;

PWM_gen speedgen(.clk(clk), .rst(rst), .freq(beat_freq), .duty(duty), .pwm(sp_clk));
playctrl(.clk(clk), .play(play), .loop(loop), .rst(rst), .ibeat(beatnum));
goal_music music0(.beatnum(beatnum), .tone(freq));
PWM_gen tonegen(.clk(clk), .rst(rst), .freq(freq), .duty(duty), .pwm(pmod_1));


endmodule
