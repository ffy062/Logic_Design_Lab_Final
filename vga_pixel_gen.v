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

    wire [9:0] DRH0, DRH1, DRH2, DRH3, DV0, DV1, DV2, DV3, DV4, DV5;
    wire [9:0] DLH0, DLH1, DLH2, DLH3;
    wire [11:0] seg_sr [8:0];
    wire [11:0] seg_sl [8:0];
    
    assign DRH0 = 340; // right score digit 
    assign DRH1 = 350; // height: 90 width: 50 bar width: 10
    assign DRH2 = 380;
    assign DRH3 = 390;
    assign DV0 = 190;
    assign DV1 = 200;
    assign DV2 = 230;
    assign DV3 = 240;
    assign DV4 = 270;
    assign DV5 = 280;

    assign DLH0 = 340 - 65; // left score digit 
    assign DLH1 = 350 - 65; // height: 90 width: 50 bar width: 10
    assign DLH2 = 380 - 65;
    assign DLH3 = 390 - 65;

    vga_num2pixel n2p_sr(
        .num(score0), .seg0(seg_sr[0]),.seg1(seg_sr[1]), .seg2(seg_sr[2]),
        .seg3(seg_sr[3]), .seg4(seg_sr[4]), .seg5(seg_sr[5]), .seg6(seg_sr[6]),
        .seg7(seg_sr[7]), .seg8(seg_sr[8])
        );
     vga_num2pixel n2p_sl(
        .num(score1), .seg0(seg_sl[0]),.seg1(seg_sl[1]), .seg2(seg_sl[2]),
        .seg3(seg_sl[3]), .seg4(seg_sl[4]), .seg5(seg_sl[5]), .seg6(seg_sl[6]),
        .seg7(seg_sl[7]), .seg8(seg_sl[8])
        );


    always @(*) begin
        if(!valid)
            {vgaRed, vgaGreen, vgaBlue} = 12'h0;
        else begin
            if(h_cnt < DLH0) begin
                /*case(score0)
                    4'd0: {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                    4'd1: {vgaRed, vgaGreen, vgaBlue} = 12'h00f;
                    4'd2: {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
                    4'd3: {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                    4'd4: {vgaRed, vgaGreen, vgaBlue} = 12'h0ff;
                    4'd5: {vgaRed, vgaGreen, vgaBlue} = 12'hf0f;
                    4'd6: {vgaRed, vgaGreen, vgaBlue} = 12'hff0;
                    default: {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                endcase*/
                {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt < DLH1) begin
                if(v_cnt < DV0) begin
                     {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                end
                else if(v_cnt < DV2) begin
                     {vgaRed, vgaGreen, vgaBlue} = seg_sl[5];
                end
                else if(v_cnt < DV3) begin
                     {vgaRed, vgaGreen, vgaBlue} = seg_sl[8];
                end
                else if(v_cnt < DV5) begin
                     {vgaRed, vgaGreen, vgaBlue} = seg_sl[4];
                end
                else begin
                     {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                end
            end
            else if(h_cnt < DLH2) begin
                if(v_cnt >= DV0 && v_cnt < DV1) begin
                     {vgaRed, vgaGreen, vgaBlue} = seg_sl[0];
                end
                else if(v_cnt >= DV2 && v_cnt < DV3) begin
                     {vgaRed, vgaGreen, vgaBlue} = seg_sl[6];
                end
                else if(v_cnt >= DV4 && v_cnt < DV5) begin
                     {vgaRed, vgaGreen, vgaBlue} = seg_sl[3];
                end
                else begin
                     {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                end
            end
            else if(h_cnt < DLH3) begin
                if(v_cnt < DV0) begin
                     {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                end
                else if(v_cnt < DV2) begin
                     {vgaRed, vgaGreen, vgaBlue} = seg_sl[1];
                end
                else if(v_cnt < DV3) begin
                    {vgaRed, vgaGreen, vgaBlue} = seg_sl[7];
                end
                else if(v_cnt < DV5) begin
                     {vgaRed, vgaGreen, vgaBlue} =seg_sl[2];
                end
                else begin
                     {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                end
            end
            else if(h_cnt < DRH0) begin
                {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            else if(h_cnt < DRH1) begin
                if(v_cnt < DV0) begin
                     {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                end
                else if(v_cnt < DV2) begin
                     {vgaRed, vgaGreen, vgaBlue} = seg_sr[5];
                end
                else if(v_cnt < DV3) begin
                     {vgaRed, vgaGreen, vgaBlue} = seg_sr[8];
                end
                else if(v_cnt < DV5) begin
                     {vgaRed, vgaGreen, vgaBlue} = seg_sr[4];
                end
                else begin
                     {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                end
            end
            else if(h_cnt < DRH2) begin
                if(v_cnt >= DV0 && v_cnt < DV1) begin
                     {vgaRed, vgaGreen, vgaBlue} = seg_sr[0];
                end
                else if(v_cnt >= DV2 && v_cnt < DV3) begin
                     {vgaRed, vgaGreen, vgaBlue} = seg_sr[6];
                end
                else if(v_cnt >= DV4 && v_cnt < DV5) begin
                     {vgaRed, vgaGreen, vgaBlue} = seg_sr[3];
                end
                else begin
                     {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                end
            end
            else if(h_cnt < DRH3) begin
                if(v_cnt < DV0) begin
                     {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                end
                else if(v_cnt < DV2) begin
                     {vgaRed, vgaGreen, vgaBlue} = seg_sr[1];
                end
                else if(v_cnt < DV3) begin
                    {vgaRed, vgaGreen, vgaBlue} = seg_sr[7];
                end
                else if(v_cnt < DV5) begin
                     {vgaRed, vgaGreen, vgaBlue} =seg_sr[2];
                end
                else begin
                     {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                end
            end
            else begin
                {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
        end 
    end

endmodule