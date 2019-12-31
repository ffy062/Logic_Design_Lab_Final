`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/28 16:37:02
// Design Name: 
// Module Name: cnt_beat
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


module cnt_beat(beatnum, tone, pmod4);
input [7:0] beatnum;
output reg [31:0] tone;
output reg pmod4;

always@(*) begin
    case(beatnum)
        8'd0 : tone = 32'd262;
        8'd1 : tone = 32'd262;
        8'd2 : tone = 32'd262;
        //8'd3 : tone = 32'd262;
        default: tone = 32'd0;
    endcase
end

always@(*) begin
    case(beatnum)
        8'd0 : pmod4 = 1'b1;
        8'd1 : pmod4 = 1'b1;
        8'd2 : pmod4 = 1'b1;
        //8'd3 : pmod4 = 1'b1;
        default: pmod4 = 1'b0;
    endcase
end

endmodule
