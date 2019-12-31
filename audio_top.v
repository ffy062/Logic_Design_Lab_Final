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


module audio_top(clk, rst, goal, cnt, pmod_1, pmod_2, pmod_4);
input clk, rst, goal, cnt;
output pmod_1, pmod_2, pmod_4;

wire [1:0] p1, p2, p4;


goal_audio goal_s(.clk(clk), .rst(rst), .play(goal), .loop(1'b0), .pmod_1(p1[0]), .pmod_2(p2[0]), .pmod_4(p4[0]));
cnt_audio cnt_s(.clk(clk), .rst(rst), .play(cnt), .loop(1'b0), .pmod_1(p1[1]), .pmod_2(p2[1]), .pmod_4(p4[1]));

assign pmod_1 = | p1[1:0];
assign pmod_2 = | p2[1:0];
assign pmod_4 = | p4[1:0];

endmodule
