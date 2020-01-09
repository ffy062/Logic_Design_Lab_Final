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
// 7--6--8
// -     -
// 4     2
// ---3---

module vga_num2pixel(
    num, theme, max, 
    seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8
    );
input [3:0] num;
input [3:0] theme;
input max;
output reg [11:0] seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8;

reg [11:0] backgrond, wcolor1;

always@(*) begin
    if(max == 1) begin
        case(theme)
        0: begin
            backgrond = 12'h000;
        end
        1: begin
            backgrond = 12'hfff;
        end
        2: begin
            backgrond = 12'he7d;
        end
        default: begin
            backgrond = 12'h000;
        end
        endcase
        wcolor1 = 12'hfe8;
    end
    else begin
        case(theme)
        0: begin
            backgrond = 12'h000;
            wcolor1 = 12'hfff;
        end
        1: begin
            backgrond = 12'hfff;
            wcolor1 = 12'h000;
        end
        2: begin
            backgrond = 12'he7d;
            wcolor1 = 12'h8f0;
        end
        3: begin
            backgrond = 12'h000;
            wcolor1 = 12'h8f0;
        end
        4: begin
            backgrond = 12'hfff;
            wcolor1 = 12'h0d5;
        end
        5: begin
            backgrond = 12'he7d;
            wcolor1 = 12'h37f;
        end
        default: begin
            backgrond = 12'h000;
            wcolor1 = 12'hfff;
        end
        endcase
    end
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
            seg7 = backgrond;
            seg8 = wcolor1;
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
            seg8 = wcolor1;
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
            seg7 = backgrond;
            seg8 = wcolor1;
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
        4'd11: begin
            seg0 = backgrond;
            seg1 = backgrond;
            seg2 = backgrond;
            seg3 = backgrond;
            seg4 = backgrond;
            seg5 = backgrond;
            seg6 = backgrond;
            seg7 = backgrond;
            seg8 = backgrond;
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