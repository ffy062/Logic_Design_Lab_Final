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

`define 0 rst 
`define 1 b_rst
`define 2 b_play
`define 3 play
`define 4 finish 




// top module

module top(clk, rst, start, goal, seg, an);
input clk, rst, goal, start;
output [6:0] seg;
output [3:0] an;

wire fsmclk, dclk, ssclk, goal_d, goal_o, goal_e; 
wire [3:0]score0, score1, num;

clock1Hz clk1s(clk, rst, fsmclk);
clock100Hz clkde(clk, rst, dclk);
clk_7seg clkss(clk, rst, ssclk);
debounce de0(dclk, rst, ~goal, goal_d);
one_pause op0(clk, goal_d, goal_o);
s_segment ss(ssclk, rst, score0, score1, num, an);
sevensegment ss_d(num, seg);


endmodule



// finite state machine and score scounter

module score_counter(clk, rst, goal, score0, score1);
input clk, rst, goal;
output reg [3:0] score0, score1;
reg [3:0] next_score0, next_score1;

always@(posedge clk, posedge rst) begin
    if(rst == 1'b1) begin
        score0 <= 4'd0;
        score1 <= 4'd0;
    end
    else begin
        score0 <= next_score0;
        score1 <= next_score1;
    end
end

always @ (*) begin
    if(goal == 1'b1) begin
        next_score0 = (score0 == 4'd9)? 4'd0 : score0 + 4'd1;
        next_score1 = (score0 == 4'd9)? score1 + 4'd1 : score1;
    end
    else begin
        next_score0 = score0;
        next_score1 = score1;
    end
end

endmodule

module fsm(clk, rst, start, en_score);
input clk, rst, start;
output en_score;
reg [2:0] state, next_state;

always@(posedge clk) begin
    state <= next_state;
end

endmodule




// seven segment and display

module s_segment(clk, rst, a, b, out, an);
input clk, rst;
input [3:0] a, b;
output reg [3:0] out;
output reg [3:0] an;
wire [3:0] next_an;

always@(posedge clk) begin
    if(rst == 1'b1) begin
        an <= 4'b1110;
    end
    else begin
        an <= next_an;
    end
end

assign next_an = (an == 4'b1110)? 4'b1101 : 4'b1110;

always@(*) begin
    if(an == 4'b1110) begin
        out <= a;
    end
    else begin
        out <= b;
    end
end

endmodule 

module sevensegment(num, D_ss);
input [3:0] num;
output reg[6:0] D_ss;

always@(*) begin
    case (num)
        4'd0: D_ss = 7'b1000000;
        4'd1: D_ss = 7'b1111001;
        4'd2: D_ss = 7'b0100100;
        4'd3: D_ss = 7'b0110000;
        4'd4: D_ss = 7'b0011001;
        4'd5: D_ss = 7'b0010010;
        4'd6: D_ss = 7'b0000010;
        4'd7: D_ss = 7'b1111000;
        4'd8: D_ss = 7'b0000000;
        4'd9: D_ss = 7'b0010000;
        4'd10: D_ss = 7'b0111111;
        default: D_ss = 7'b0000000;
    endcase
end

endmodule



// clock and counter

module counter1sec(clk, rst, out);
input clk, rst;
output out;
reg [30:0] cnt;
wire [30:0]next_cnt;
// 31'd99999999

always@(posedge clk) begin
    if(rst == 1'b1) begin
        cnt <= 31'd99999999;
    end
    else begin
        cnt <= next_cnt;
    end
end
assign next_cnt = (cnt == 31'd0)? 31'd0 : cnt - 31'd1;
assign out = (cnt == 31'd0)? 1'b0 : 1'b1; 

endmodule

module clock1Hz(clk, rst, nclk);
input clk, rst;
output nclk;
reg [30:0] cnt;
wire [30:0]next_cnt;
// 31'd99999999

always@(posedge clk) begin
    if(rst == 1'b1) begin
        cnt <= 31'd0;
    end
    else begin
        cnt <= next_cnt;
    end
end
assign next_cnt = (cnt == 31'd99999999)? 31'd0 : cnt + 31'd1;
assign nclk = (cnt > 31'd49999999)? 1'b1 : 1'b0; 

endmodule

module clock100Hz(clk, rst, nclk);
input clk, rst;
output nclk;
reg [20:0] cnt;
wire [20:0] next_cnt;
// 21'd999999

always@(posedge clk) begin
    if(rst == 1'b1) begin
        cnt <= 21'd0;
    end
    else begin
        cnt <= next_cnt;
    end
end
assign next_cnt = (cnt == 21'd999999)? 21'd0 : cnt + 21'd1;
assign nclk = (cnt > 21'd499999)? 1'b1 : 1'b0;

endmodule

module clk_7seg(clk, rst, nclk);
input clk, rst;
output nclk;
reg [17:0] cnt;
wire [17:0] next_cnt;
// 
always@(posedge clk) begin
    if(rst == 1'b1) begin
        cnt <= 18'd0;
    end
    else begin
        cnt <= next_cnt;
    end
end
assign next_cnt = cnt + 18'd1;
assign nclk = cnt[17];

endmodule




// debounce and onepause

module debounce(clk, rst, in, in_d);
input clk, rst, in;
output in_d;
reg [8-1:0] DFF;

always@(posedge clk, posedge rst) begin
    if(rst == 1'b1) begin
        DFF <= 8'b00000000;
    end
    else begin
        DFF[7:1] <= DFF[6:0];
        DFF[0] <= in;
    end
end
assign in_d = (DFF == 8'b11111111)? 1'b1 : 1'b0;

endmodule

module one_pause(clk, in_d, in_o);
input clk, in_d;
output reg in_o;
reg in_delay;

always@(posedge clk) begin
    in_o <= (!in_delay) & in_d;
    in_delay <= in_d;
end

endmodule