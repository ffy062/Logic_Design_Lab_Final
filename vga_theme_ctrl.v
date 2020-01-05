`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/04 18:47:18
// Design Name: 
// Module Name: vga_theme_ctrl
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


// 2'b00 dark 2'b01 bright 2'b10 costum

module vga_theme_ctrl(clk, rst, chg, theme);
input clk, rst, chg;
output reg [1:0] theme;

reg [1:0]n_theme;

always@(posedge clk) begin
    if(rst == 1'b1) 
        theme <= 2'b00;
    else
        theme <= n_theme;
end

always@(*) begin
    if(chg == 1'b1) begin
        n_theme = (theme == 2'b10)? 2'b00 : theme + 2'b01;
    end
    else begin
        n_theme = theme;
    end
end

endmodule
