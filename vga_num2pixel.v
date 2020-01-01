`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/02 00:47:16
// Design Name: 
// Module Name: vga_num2pixel
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


module vga_num2pixel(num, seg0, seg1, seg2, seg3, seg4, seg5, seg6);
input num;
output reg [11:0] seg0, seg1, seg2, seg3, seg4, seg5, seg6;

integer i;

always@(*) begin
    case(num)
        4'd0: begin
            seg0 = 12'hfff;
            seg1 = 12'hfff;
            seg2 = 12'hfff;
            seg3 = 12'hfff;
            seg4 = 12'hfff;
            seg5 = 12'hfff;
            seg6 = 12'h000;
        end
        4'd1: begin
            seg0 = 12'h000;
            seg1 = 12'hfff;
            seg2 = 12'hfff;
            seg3 = 12'h000;
            seg4 = 12'h000;
            seg5 = 12'h000;
            seg6 = 12'h000;
        end
        4'd2: begin
            seg0 = 12'hfff;
            seg1 = 12'hfff;
            seg2 = 12'h000;
            seg3= 12'hfff;
            seg4 = 12'hfff;
            seg5 = 12'h000;
            seg6 = 12'hfff;
        end
        4'd3: begin
            seg0 = 12'hfff;
            seg1 = 12'hfff;
            seg2 = 12'hfff;
            seg3 = 12'hfff;
            seg4 = 12'h000;
            seg5 = 12'h000;
            seg6 = 12'hfff;
        end
        4'd4: begin
            seg0 = 12'h000;
            seg1 = 12'hfff;
            seg2 = 12'hfff;
            seg3 = 12'h000;
            seg4 = 12'h000;
            seg5 = 12'hfff;
            seg6 = 12'hfff;
        end
        4'd5: begin
            seg0 = 12'hfff;
            seg1 = 12'h000;
            seg2 = 12'hfff;
            seg3 = 12'hfff;
            seg4 = 12'h000;
            seg5 = 12'hfff;
            seg6 = 12'hfff;
        end
        4'd6: begin
            seg0 = 12'hfff;
            seg1 = 12'h000;
            seg2 = 12'hfff;
            seg3 = 12'hfff;
            seg4 = 12'hfff;
            seg5 = 12'hfff;
            seg6 = 12'hfff;
        end
        4'd7: begin
            seg0 = 12'hfff;
            seg1 = 12'hfff;
            seg2 = 12'hfff;
            seg3 = 12'h000;
            seg4 = 12'h000;
            seg5 = 12'h000;
            seg6 = 12'h000;
        end
        4'd8: begin
            seg0 = 12'hfff;
            seg1 = 12'hfff;
            seg2 = 12'hfff;
            seg3 = 12'hfff;
            seg4 = 12'hfff;
            seg5 = 12'hfff;
            seg6 = 12'hfff;
        end
        4'd9: begin
            seg0 = 12'hfff;
            seg1 = 12'hfff;
            seg2 = 12'hfff;
            seg3 = 12'h000;
            seg4 = 12'h000;
            seg5 = 12'hfff;
            seg6 = 12'hfff;
        end
        4'd10: begin
            seg0 = 12'h000;
            seg1 = 12'h000;
            seg2 = 12'h000;
            seg3 = 12'h000;
            seg4 = 12'h000;
            seg5 = 12'h000;
            seg6 = 12'hfff;
        end
        default: begin
            seg0 = 12'h000;
            seg1 = 12'h000;
            seg2 = 12'h000;
            seg3 = 12'h000;
            seg4 = 12'h000;
            seg5 = 12'h000;
            seg6 = 12'hfff;
        end
    endcase
end

endmodule