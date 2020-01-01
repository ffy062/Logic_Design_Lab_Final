`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/01 13:27:07
// Design Name: 
// Module Name: vga_pixel_gen
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


module vga_pixel_gen(
    h_cnt, v_cnt, valid, vsync, hsync,
    score0, score1,
    vgaRed, vgaGreen, vgaBlue
    );

    input [9:0] h_cnt, v_cnt;
    input valid, vsync, hsync;
    input [3:0] score0, score1;
    output reg [3:0] vgaRed, vgaGreen, vgaBlue;

    wire [9:0] DH1, DH5, DV1, DV3, DRV, DRH;
    wire [11:0] vga_seg [6:0];

    assign DH1 = 10;
    assign DH3 = 30;
    assign DV1 = 10;
    assign DV3 = 30;
    assign DRV = 190;
    assign DRH = 340;

    vga_num2pixel n2p_r(.num(score0), .vga_seg(vga_seg));
    
    always @(*) begin
        if(!valid)
            {vgaRed, vgaGreen, vgaBlue} = 12'h0;
        else begin
            if(v_cnt < DRV) begin
                case(score0)
                    4'd0: {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                    4'd1: {vgaRed, vgaGreen, vgaBlue} = 12'h00f;
                    4'd2: {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
                    4'd3: {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                    4'd4: {vgaRed, vgaGreen, vgaBlue} = 12'h0ff;
                    4'd5: {vgaRed, vgaGreen, vgaBlue} = 12'hf0f;
                    4'd6: {vgaRed, vgaGreen, vgaBlue} = 12'hff0;
                    default: {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                endcase
            end
            else if(v_cnt < DRV + DV1) begin
                if(h_cnt > DRH && h_cnt < DRH + DH1) begin
                    {vgaRed, vgaGreen, vgaBlue} = vga_seg[5]; // for right digit
                end
                else if(h_cnt > DRH + DH3 + DH1 && h_cnt < DRH + DH5) begin
                    {vgaRed, vgaGreen, vgaBlue} = vga_seg[1]; // for right digit
                end
                else begin
                    {vgaRed, vgaGreen, vgaBlue} = vga_seg[0];
                end
            end
            else if(v_cnt < DRV + DV1 + DV3) begin
                if(h_cnt > DRH && h_cnt < DRH + DH1) begin
                    {vgaRed, vgaGreen, vgaBlue} = vga_seg[5]; // for right digit
                end
                else if(h_cnt > DRH + DH3 + DH1 && h_cnt < DRH + DH5) begin
                    {vgaRed, vgaGreen, vgaBlue} = vga_seg[1]; // for right digit
                end
                else begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                end
            end
            else if(v_cnt < DRV + 2*DV1 + DV3) begin
                 if(h_cnt > DRH && h_cnt < DRH + DH1) begin
                    {vgaRed, vgaGreen, vgaBlue} = vga_seg[4]; // for right digit
                end
                else if(h_cnt > DRH + DH3 + DH1 && h_cnt < DRH + DH5) begin
                    {vgaRed, vgaGreen, vgaBlue} = vga_seg[2]; // for right digit
                end
                else begin
                    {vgaRed, vgaGreen, vgaBlue} = vga_seg[6];
                end
            end
            else if(v_cnt < DRV + 2*DV1 + 2*DV1 + 2*DV3) begin
                if(h_cnt > DRH && h_cnt < DRH+DH1) begin
                    {vgaRed, vgaGreen, vgaBlue} = vga_seg[4]; // for right digit
                end
                else if(h_cnt > DRH + DH3 + DH1 && h_cnt < DRH + DH5) begin
                    {vgaRed, vgaGreen, vgaBlue} = vga_seg[2]; // for right digit
                end
                else begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                end
            end
            else if(v_cnt < DRV + 3*DV1 + 2*DV3) begin
                if(h_cnt > DRH && h_cnt < DRH+DH1) begin
                    {vgaRed, vgaGreen, vgaBlue} = vga_seg[5]; // for right digit
                end
                else if(h_cnt > DRH + DH3 + DH1 && h_cnt < DRH + DH5) begin
                    {vgaRed, vgaGreen, vgaBlue} = vga_seg[1]; // for right digit
                end
                else begin
                    {vgaRed, vgaGreen, vgaBlue} = vga_seg[3];
                end
            end
            else begin
                {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
        end 
    end

endmodule