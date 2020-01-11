`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/09 09:46:23
// Design Name: 
// Module Name: start_audio
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


module start_audio(clk, rst, play, loop, pmod_1, pmod_2, pmod_4);
input clk, rst, play, loop;
output pmod_1, pmod_2, pmod_4;

parameter beat_freq = 23'd8; // one beat  = 1/8 sec
parameter duty = 10'd512; // duty cycle = 50 %

assign pmod_2 = 1'd1;	//no gain(6dB)

wire sp_clk;
wire [31:0]freq;
wire [7:0] beatnum;

PWM_gen speedgen_s(.clk(clk), .rst(rst), .freq(beat_freq), .duty(duty), .pwm(sp_clk));
playctrl #(3)beatgen_s(.clk(sp_clk), .play(play), .loop(loop), .rst(rst), .ibeat(beatnum));
start_beat sound_s(.beatnum(beatnum), .tone(freq), .pmod4(pmod_4));
PWM_gen tonegen_s(.clk(clk), .rst(rst), .freq(freq), .duty(duty), .pwm(pmod_1));
endmodule

