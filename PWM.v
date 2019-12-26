`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/26 13:21:30
// Design Name: 
// Module Name: PWM
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


module PWM_gen(clk, rst, freq, duty, pwm);
input clk, rst;
input [31:0]freq;
input [9:0] duty;
output reg pwm;

wire [31:0] cnt_max = 32'd100_000_000 / freq;
wire [31:0] cnt_duty = cnt_max * duty / 1024;
reg [31:0] cnt, n_cnt;

always@(posedge clk) begin
    if(rst) begin
        cnt <= 0;
        pwm <= 1'b0;
    end
    else begin
        if(cnt < cnt_max) begin
            cnt <= cnt + 1;
            if(cnt < cnt_duty) begin
                pwm <= 1'b1;
            end
            else begin
                pwm <= 1'b0;
            end
        end
        else begin
            cnt <= 0;
            pwm <= 0;
        end
    end
end

endmodule
