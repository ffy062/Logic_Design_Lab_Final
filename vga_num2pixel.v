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


// ---0---
// 5     1
// -     - 
// 8--6--7
// -     -
// 4     2
// ---3---

module vga_num2pixel(
    num, theme,  
    seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8
    );
input [3:0] num;
input [1:0] theme;
output reg [11:0] seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8;

reg [11:0] backgrond, wcolor1;

always@(*) begin
    case(theme)
        2'b00: begin
            backgrond = 12'h000;
            wcolor1 = 12'hfff;
        end
        2'b01: begin
            backgrond = 12'hfff;
            wcolor1 = 12'h000;
        end
        2'b10: begin
            backgrond = 12'he7d;
            wcolor1 = 12'h8f0;
        end
        default: begin
            backgrond = 12'h000;
            wcolor1 = 12'hfff;
        end
    endcase
end

always@(*) begin
    case(num)
        4'd0: begin
            seg0 = wcolor1;
            seg1 = wcolor1;
            seg2 = wcolor1;
            seg3 = wcolor1;
            seg4 = wcolor1;
            seg5 = wcolor1;
            seg6 = backgrond;
            seg7 = wcolor1;
            seg8 = wcolor1;
        end
        4'd1: begin
            seg0 = backgrond;
            seg1 = wcolor1;
            seg2 = wcolor1;
            seg3 = backgrond;
            seg4 = backgrond;
            seg5 = backgrond;
            seg6 = backgrond;
            seg7 = wcolor1;
            seg8 = backgrond;
        end
        4'd2: begin
            seg0 = wcolor1;
            seg1 = wcolor1;
            seg2 = backgrond;
            seg3 = wcolor1;
            seg4 = wcolor1;
            seg5 = backgrond;
            seg6 = wcolor1;
            seg7 = wcolor1;
            seg8 = wcolor1;
        end
        4'd3: begin
            seg0 = wcolor1;
            seg1 = wcolor1;
            seg2 = wcolor1;
            seg3 = wcolor1;
            seg4 = backgrond;
            seg5 = backgrond;
            seg6 = wcolor1;
            seg7 = wcolor1;
            seg8 = backgrond;
        end
        4'd4: begin
            seg0 = backgrond;
            seg1 = wcolor1;
            seg2 = wcolor1;
            seg3 = backgrond;
            seg4 = backgrond;
            seg5 = wcolor1;
            seg6 = wcolor1;
            seg7 = wcolor1;
            seg8 = wcolor1;
        end
        4'd5: begin
            seg0 = wcolor1;
            seg1 = backgrond;
            seg2 = wcolor1;
            seg3 = wcolor1;
            seg4 = backgrond;
            seg5 = wcolor1;
            seg6 = wcolor1;
            seg7 = wcolor1;
            seg8 = wcolor1;
        end
        4'd6: begin
            seg0 = wcolor1;
            seg1 = backgrond;
            seg2 = wcolor1;
            seg3 = wcolor1;
            seg4 = wcolor1;
            seg5 = wcolor1;
            seg6 = wcolor1;
            seg7 = wcolor1;
            seg8 = wcolor1;
        end
        4'd7: begin
            seg0 = wcolor1;
            seg1 = wcolor1;
            seg2 = wcolor1;
            seg3 = backgrond;
            seg4 = backgrond;
            seg5 = backgrond;
            seg6 = backgrond;
            seg7 = wcolor1;
            seg8 = backgrond;
        end
        4'd8: begin
            seg0 = wcolor1;
            seg1 = wcolor1;
            seg2 = wcolor1;
            seg3 = wcolor1;
            seg4 = wcolor1;
            seg5 = wcolor1;
            seg6 = wcolor1;
            seg7 = wcolor1;
            seg8 = wcolor1;
        end
        4'd9: begin
            seg0 = wcolor1;
            seg1 = wcolor1;
            seg2 = wcolor1;
            seg3 = backgrond;
            seg4 = backgrond;
            seg5 = wcolor1;
            seg6 = wcolor1;
            seg7 = wcolor1;
            seg8 = wcolor1;
        end
        4'd10: begin
            seg0 = backgrond;
            seg1 = backgrond;
            seg2 = backgrond;
            seg3 = backgrond;
            seg4 = backgrond;
            seg5 = backgrond;
            seg6 = wcolor1;
            seg7 = wcolor1;
            seg8 = wcolor1;
        end
        default: begin
            seg0 = backgrond;
            seg1 = backgrond;
            seg2 = backgrond;
            seg3 = backgrond;
            seg4 = backgrond;
            seg5 = backgrond;
            seg6 = wcolor1;
            seg7 = wcolor1;
            seg8 = wcolor1;
        end
    endcase
end

endmodule