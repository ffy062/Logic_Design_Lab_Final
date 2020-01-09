`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/27 19:54:30
// Design Name: 
// Module Name: score_and_display
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


module score_and_display(clk, goal, rst, dis_score, score0, score1);
input clk, goal, dis_score, rst;
output reg [3:0] score0, score1;
reg [3:0] next_score0, next_score1;


always@(posedge clk) begin
    if(dis_score == 1'b0 || rst) begin
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
        if(score0 == 9 && score1 == 9) begin
            next_score0 = score0;
            next_score1 = score1;
        end
        else begin
        next_score0 = (score0 == 4'd9)? 4'd0 : score0 + 4'd1;
        next_score1 = (score0 == 4'd9)? score1 + 4'd1 : score1;
        end
    end
    else begin
        next_score0 = score0;
        next_score1 = score1;
    end
end

endmodule

