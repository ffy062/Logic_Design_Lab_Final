`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/04 20:31:32
// Design Name: 
// Module Name: vga_letter2pixel
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

`define A 5'd0
`define B 5'd1
`define C 5'd2
`define D 5'd3
`define E 5'd4
`define F 5'd5
`define G 5'd6
`define H 5'd7
`define I 5'd8
`define J 5'd9
`define K 5'd10
`define L 5'd11
`define M 5'd12
`define N 5'd13
`define O 5'd14
`define P 5'd15
`define Q 5'd16
`define R 5'd17
`define S 5'd18
`define T 5'd19
`define U 5'd20
`define V 5'd21
`define W 5'd22
//`define X 5'd23
`define Y 5'd24
//`define Z 5'd25


// -----00-----
// --   --   --
// 5 10 14 11 1
// -   ----   -
// 8--6-16-7--9
// -   ----   -
// 4 12 15 13 2
// --   --   --
// -----03-----

module vga_letter2pixel(
    letter, theme,
    seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8, 
    seg9, sega, segb, segc, segd, sege, segf, segg
    );
input [4:0] letter;
input [1:0]theme;
output reg[11:0] seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8;
output reg[11:0] seg9, sega, segb, segc, segd, sege, segf, segg;

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
            wcolor1 = 12'hfff;
        end
        default: begin
            backgrond = 12'h000;
            wcolor1 = 12'hfff;
        end
    endcase
end

always@(*) begin
    case(letter)
        `A: begin
            seg0 = wcolor1;
            seg1 = wcolor1;
            seg2 = wcolor1;
            seg3 = backgrond;
            seg4 = backgrond;
            seg5 = wcolor1;
            seg6 = wcolor1;
            seg7 = wcolor1;
            seg8 = wcolor1;
            seg9 = wcolor1;
            sega = backgrond;
            segb = backgrond;
            segc = backgrond;
            segd = backgrond;
            sege = wcolor1;
            segf = backgrond;
            segg = wcolor1;
        end
        `B: begin
            seg0 = wcolor1;
            seg1 = wcolor1;
            seg2 = wcolor1;
            seg3 = wcolor1;
            seg4 = wcolor1;
            seg5 = wcolor1;
            seg6 = wcolor1;
            seg7 = wcolor1;
            seg8 = wcolor1;
            seg9 = wcolor1;
            sega = backgrond;
            segb = backgrond;
            segc = backgrond;
            segd = backgrond;
            sege = backgrond;
            segf = backgrond;
            segg = backgrond;
        end
        `C: begin
            seg0 = wcolor1;
            seg1 = backgrond;
            seg2 = backgrond;
            seg3 = wcolor1;
            seg4 = wcolor1;
            seg5 = wcolor1;
            seg6 = backgrond;
            seg7 = backgrond;
            seg8 = wcolor1;
            seg9 = backgrond;
            sega = backgrond;
            segb = backgrond;
            segc = backgrond;
            segd = backgrond;
            sege = backgrond;
            segf = backgrond;
            segg = backgrond;
        end
        `E: begin
            seg0 = wcolor1;
            seg1 = backgrond;
            seg2 = backgrond;
            seg3 = wcolor1;
            seg4 = wcolor1;
            seg5 = wcolor1;
            seg6 = wcolor1;
            seg7 = wcolor1;
            seg8 = wcolor1;
            seg9 = backgrond;
            sega = backgrond;
            segb = backgrond;
            segc = backgrond;
            segd = backgrond;
            sege = backgrond;
            segf = backgrond;
            segg = wcolor1;
        end
        `G: begin
            seg0 = wcolor1;
            seg1 = backgrond;
            seg2 = wcolor1;
            seg3 = wcolor1;
            seg4 = wcolor1;
            seg5 = wcolor1;
            seg6 = backgrond;
            seg7 = wcolor1;
            seg8 = wcolor1;
            seg9 = backgrond;
            sega = backgrond;
            segb = backgrond;
            segc = backgrond;
            segd = backgrond;
            sege = backgrond;
            segf = backgrond;
            segg = wcolor1;
        end
        `I: begin
            seg0 = wcolor1;
            seg1 = backgrond;
            seg2 = backgrond;
            seg3 = wcolor1;
            seg4 = backgrond;
            seg5 = backgrond;
            seg6 = backgrond;
            seg7 = backgrond;
            seg8 = wcolor1;
            seg9 = wcolor1;
            sega = backgrond;
            segb = backgrond;
            segc = backgrond;
            segd = backgrond;
            sege = backgrond;
            segf = backgrond;
            segg = wcolor1;
        end
        `K: begin
            seg0 = backgrond;
            seg1 = backgrond;
            seg2 = backgrond;
            seg3 = backgrond;
            seg4 = wcolor1;
            seg5 = wcolor1;
            seg6 = backgrond;
            seg7 = backgrond;
            seg8 = backgrond;
            seg9 = backgrond;
            sega = backgrond;
            segb = wcolor1;
            segc = backgrond;
            segd = wcolor1;
            sege = backgrond;
            segf = backgrond;
            segg = wcolor1;
        end
        `L: begin
            seg0 = backgrond;
            seg1 = backgrond;
            seg2 = backgrond;
            seg3 = wcolor1;
            seg4 = wcolor1;
            seg5 = wcolor1;
            seg6 = backgrond;
            seg7 = backgrond;
            seg8 = wcolor1;
            seg9 = backgrond;
            sega = backgrond;
            segb = backgrond;
            segc = backgrond;
            segd = backgrond;
            sege = backgrond;
            segf = backgrond;
            segg = backgrond;
        end
        `M: begin
            seg0 = backgrond;
            seg1 = wcolor1;
            seg2 = wcolor1;
            seg3 = backgrond;
            seg4 = wcolor1;
            seg5 = wcolor1;
            seg6 = backgrond;
            seg7 = backgrond;
            seg8 = wcolor1;
            seg9 = wcolor1;
            sega = wcolor1;
            segb = wcolor1;
            segc = backgrond;
            segd = backgrond;
            sege = backgrond;
            segf = backgrond;
            segg = wcolor1;
        end
        `O: begin
            seg0 = wcolor1;
            seg1 = wcolor1;
            seg2 = wcolor1;
            seg3 = wcolor1;
            seg4 = wcolor1;
            seg5 = wcolor1;
            seg6 = backgrond;
            seg7 = backgrond;
            seg8 = wcolor1;
            seg9 = wcolor1;
            sega = backgrond;
            segb = backgrond;
            segc = backgrond;
            segd = backgrond;
            sege = backgrond;
            segf = backgrond;
            segg = backgrond;
        end
        `R: begin
            seg0 = wcolor1;
            seg1 = wcolor1;
            seg2 = backgrond;
            seg3 = backgrond;
            seg4 = backgrond;
            seg5 = wcolor1;
            seg6 = wcolor1;
            seg7 = wcolor1;
            seg8 = wcolor1;
            seg9 = wcolor1;
            sega = backgrond;
            segb = backgrond;
            segc = backgrond;
            segd = wcolor1;
            sege = backgrond;
            segf = backgrond;
            segg = wcolor1;
        end
        `S: begin
            seg0 = wcolor1;
            seg1 = backgrond;
            seg2 = wcolor1;
            seg3 = wcolor1;
            seg4 = backgrond;
            seg5 = wcolor1;
            seg6 = wcolor1;
            seg7 = wcolor1;
            seg8 = wcolor1;
            seg9 = wcolor1;
            sega = backgrond;
            segb = backgrond;
            segc = backgrond;
            segd = backgrond;
            sege = backgrond;
            segf = backgrond;
            segg = wcolor1;
        end
        `T: begin
            seg0 = wcolor1;
            seg1 = backgrond;
            seg2 = backgrond;
            seg3 = backgrond;
            seg4 = backgrond;
            seg5 = backgrond;
            seg6 = backgrond;
            seg7 = backgrond;
            seg8 = backgrond;
            seg9 = backgrond;
            sega = backgrond;
            segb = backgrond;
            segc = backgrond;
            segd = backgrond;
            sege = wcolor1;
            segf = wcolor1;
            segg = wcolor1;
        end
        default: begin
            seg0 = backgrond;
            seg1 = backgrond;
            seg2 = backgrond;
            seg3 = backgrond;
            seg4 = backgrond;
            seg5 = backgrond;
            seg6 = backgrond;
            seg7 = backgrond;
            seg8 = backgrond;
            seg9 = backgrond;
            sega = backgrond;
            segb = backgrond;
            segc = backgrond;
            segd = backgrond;
            sege = backgrond;
            segf = backgrond;
            segg = backgrond;
        end
    endcase
end

endmodule
