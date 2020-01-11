`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/28 16:58:47
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


module audio_top(clk, rst, goal, cnt, start, pmod_1, pmod_2, pmod_4);
input clk, rst, goal, cnt, start;
output pmod_1, pmod_2, pmod_4;

wire [2:0] p1, p2, p4;


goal_audio goal_s(.clk(clk), .rst(rst), .play(goal), .loop(1'b0), .pmod_1(p1[0]), .pmod_2(p2[0]), .pmod_4(p4[0]));
cnt_audio cnt_s(.clk(clk), .rst(rst), .play(cnt), .loop(1'b0), .pmod_1(p1[1]), .pmod_2(p2[1]), .pmod_4(p4[1]));
start_audio start_s(.clk(clk), .rst(rst), .play(start), .loop(1'b0), .pmod_1(p1[2]), .pmod_2(p2[2]), .pmod_4(p4[2]));

assign pmod_1 = | p1[2:0];
assign pmod_2 = | p2[2:0];
assign pmod_4 = | p4[2:0];

endmodule
