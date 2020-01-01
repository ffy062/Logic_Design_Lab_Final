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


module vga_num2pixel(num, vga_seg);
input num;
output reg [11:0] vga_seg [6:0];

integer i;

always@(*) begin
    case(num)
        4'd0: begin
            vga_seg[0] = 12'hfff;
            vga_seg[1] = 12'hfff;
            vga_seg[2] = 12'hfff;
            vga_seg[3] = 12'hfff;
            vga_seg[4] = 12'hfff;
            vga_seg[5] = 12'hfff;
            vga_seg[6] = 12'h000;
        end
        4'd1: begin
            vga_seg[0] = 12'h000;
            vga_seg[1] = 12'hfff;
            vga_seg[2] = 12'hfff;
            vga_seg[3] = 12'h000;
            vga_seg[4] = 12'h000;
            vga_seg[5] = 12'h000;
            vga_seg[6] = 12'h000;
        end
        4'd2: begin
            vga_seg[0] = 12'hfff;
            vga_seg[1] = 12'hfff;
            vga_seg[2] = 12'h000;
            vga_seg[3] = 12'hfff;
            vga_seg[4] = 12'hfff;
            vga_seg[5] = 12'h000;
            vga_seg[6] = 12'hfff;
        end
        4'd3: begin
            vga_seg[0] = 12'hfff;
            vga_seg[1] = 12'hfff;
            vga_seg[2] = 12'hfff;
            vga_seg[3] = 12'hfff;
            vga_seg[4] = 12'h000;
            vga_seg[5] = 12'h000;
            vga_seg[6] = 12'hfff;
        end
        4'd4: begin
            vga_seg[0] = 12'h000;
            vga_seg[1] = 12'hfff;
            vga_seg[2] = 12'hfff;
            vga_seg[3] = 12'h000;
            vga_seg[4] = 12'h000;
            vga_seg[5] = 12'hfff;
            vga_seg[6] = 12'hfff;
        end
        4'd5: begin
            vga_seg[0] = 12'hfff;
            vga_seg[1] = 12'h000;
            vga_seg[2] = 12'hfff;
            vga_seg[3] = 12'hfff;
            vga_seg[4] = 12'h000;
            vga_seg[5] = 12'hfff;
            vga_seg[6] = 12'hfff;
        end
        4'd6: begin
            vga_seg[0] = 12'hfff;
            vga_seg[1] = 12'h000;
            vga_seg[2] = 12'hfff;
            vga_seg[3] = 12'hfff;
            vga_seg[4] = 12'hfff;
            vga_seg[5] = 12'hfff;
            vga_seg[6] = 12'hfff;
        end
        4'd7: begin
            vga_seg[0] = 12'hfff;
            vga_seg[1] = 12'hfff;
            vga_seg[2] = 12'hfff;
            vga_seg[3] = 12'h000;
            vga_seg[4] = 12'h000;
            vga_seg[5] = 12'h000;
            vga_seg[6] = 12'h000;
        end
        4'd8: begin
            vga_seg[0] = 12'hfff;
            vga_seg[1] = 12'hfff;
            vga_seg[2] = 12'hfff;
            vga_seg[3] = 12'hfff;
            vga_seg[4] = 12'hfff;
            vga_seg[5] = 12'hfff;
            vga_seg[6] = 12'hfff;
        end
        4'd9: begin
            vga_seg[0] = 12'hfff;
            vga_seg[1] = 12'hfff;
            vga_seg[2] = 12'hfff;
            vga_seg[3] = 12'h000;
            vga_seg[4] = 12'h000;
            vga_seg[5] = 12'hfff;
            vga_seg[6] = 12'hfff;
        end
        4'd10: begin
            vga_seg[0] = 12'h000;
            vga_seg[1] = 12'h000;
            vga_seg[2] = 12'h000;
            vga_seg[3] = 12'h000;
            vga_seg[4] = 12'h000;
            vga_seg[5] = 12'h000;
            vga_seg[6] = 12'hfff;
        end
        default: begin
           for(i = 0; i < 6; i = i + 1) begin
                vga_seg[i] = 12'h000;
           end
        end
    endcase
end

endmodule
