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



`define rst 4'd0 
`define b_rst 4'd1
`define b_play 4'd2
`define stage1 4'd3
`define stage2 4'd4
`define stage3 4'd5
`define pmode 4'd6
`define win 4'd7
`define lose 4'd8
`define finish 4'd9

module vga_pixel_gen(
    h_cnt, v_cnt, valid, theme, 
    state, score0, score1, cnt0, cnt1,
    vgaRed, vgaGreen, vgaBlue
    );

    input [9:0] h_cnt, v_cnt;
    input valid;
    input [1:0] theme;
    input [3:0] state;
    input [3:0] score0, score1, cnt0, cnt1;
    output reg [3:0] vgaRed, vgaGreen, vgaBlue;

    wire [9:0] DRH0, DRH1, DRH2, DRH3, DV0, DV1, DV2, DV3, DV4, DV5;
    wire [9:0] DLH0, DLH1, DLH2, DLH3;
    wire [9:0] DCH0, DCH1, DCH2, DCH3, DCV0, DCV1, DCV2, DCV3, DCV4, DCV5;

    wire [9:0] S0H0, S0H1, S0H2, S0H3, S0V0, S0V1, S0V2, S0V3, S0V4, S0V5;
    wire [9:0] S1H0, S1H1, S1H2;
    wire [9:0] S2H0, S2H1, S2H2, S2H3;
    wire [9:0] S3H0, S3H1, S3H2, S3H3, S3H4, S3H2a, S3H2b, S3H2c, S3H2d;
    wire [9:0] S3H2e, S3V3a, S3V3b, S3V3c, S3V3d, S3VSd, S3V3e;
    wire [9:0] S3V3a1, S3V3b1, S3V3c1, S3V3d1, S3V3e1;
    wire [9:0] S4H0, S4H1, S4H2;

    wire [11:0] seg_sr [8:0];
    wire [11:0] seg_sl [8:0];
    wire [11:0] seg_cnt [8:0];
    wire [11:0] seg_lc [16:0];
    wire [11:0] seg_le [16:0];
    wire [11:0] seg_lo [16:0];
    wire [11:0] seg_lr [16:0];
    wire [11:0] seg_ls [16:0];
    reg [11:0] backgrond;
    
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

    assign DCH0 = 270; // count down digit
    assign DCH1 = 290; // height: 180 width: 100 bar width: 20
    assign DCH2 = 350;
    assign DCH3 = 370;
    assign DCV0 = 150;
    assign DCV1 = 170;
    assign DCV2 = 230;
    assign DCV3 = 250;
    assign DCV4 = 310;
    assign DCV5 = 330;

    assign S0H0 = 135; // score letter s
    assign S0H1 = 138; // height: 40 width: 20 bar width 3
    assign S0H2 = 152; 
    assign S0H3 = 155;
    assign S0V0 = 150;
    assign S0V1 = 153;
    assign S0V2 = 169;
    assign S0V3 = 172;
    assign S0V4 = 187;
    assign S0V5 = 190;
    
    assign S1H0 = 160; // score letter c
    assign S1H1 = 163; // height: 40 width: 20 bar width 3
    assign S1H2 = 180;

    assign S2H0 = 185; // score letter o
    assign S2H1 = 188; // height: 40 width: 20 bar width 3
    assign S2H2 = 202;
    assign S2H3 = 205;

    assign S3H0 = 210; // score letter r
    assign S3H1 = 213; // height: 40 width: 20 bar width 3
    assign S3H2 = 215;
    assign S3H2a = 217;
    assign S3H2b = 219;
    assign S3H2c = 221;
    assign S3H2d = 223;
    assign S3H2e = 225;
    assign S3H3 = 227;
    assign S3H4 = 230;
    assign S3V3a = 175;
    assign S3V3b = 178;
    assign S3V3c = 181;
    assign S3V3d = 184;
    assign S3V3e = 187;
    assign S3V3a1 = 176;
    assign S3V3b1 = 179;
    assign S3V3c1 = 182;
    assign S3V3d1 = 185;
    assign S3V3e1 = 186;
    

    assign S4H0 = 235; // score letter e
    assign S4H1 = 238; // height: 40 width: 20 bar width 3
    assign S4H2 = 255;


    // number to pixel color
    vga_num2pixel n2p_sr(
        .num(score0), .theme(theme),
        .seg0(seg_sr[0]),.seg1(seg_sr[1]), .seg2(seg_sr[2]),
        .seg3(seg_sr[3]), .seg4(seg_sr[4]), .seg5(seg_sr[5]), .seg6(seg_sr[6]),
        .seg7(seg_sr[7]), .seg8(seg_sr[8])
        );
     vga_num2pixel n2p_sl(
        .num(score1), .theme(theme),
        .seg0(seg_sl[0]), .seg1(seg_sl[1]), .seg2(seg_sl[2]),
        .seg3(seg_sl[3]), .seg4(seg_sl[4]), .seg5(seg_sl[5]), .seg6(seg_sl[6]),
        .seg7(seg_sl[7]), .seg8(seg_sl[8])
        );
     vga_num2pixel n2p_cnt(
        .num(cnt0), .theme(theme),
        .seg0(seg_cnt[0]),.seg1(seg_cnt[1]), .seg2(seg_cnt[2]),
        .seg3(seg_cnt[3]), .seg4(seg_cnt[4]), .seg5(seg_cnt[5]), .seg6(seg_cnt[6]),
        .seg7(seg_cnt[7]), .seg8(seg_cnt[8])
        );

    // letter to pixel color
    vga_letter2pixel l2p_ls(
        .letter(`S), .theme(theme),
        .seg0(seg_ls[0]), .seg1(seg_ls[1]), .seg2(seg_ls[2]), .seg3(seg_ls[3]),
        .seg4(seg_ls[4]), .seg5(seg_ls[5]), .seg6(seg_ls[6]), .seg7(seg_ls[7]),
        .seg8(seg_ls[8]), .seg9(seg_ls[9]), .sega(seg_ls[10]), .segb(seg_ls[11]),
        .segc(seg_ls[12]), .segd(seg_ls[13]), .sege(seg_ls[14]), 
        .segf(seg_ls[15]), .segg(seg_ls[16]) 
    );
    vga_letter2pixel l2p_lc(
        .letter(`C), .theme(theme),
        .seg0(seg_lc[0]), .seg1(seg_lc[1]), .seg2(seg_lc[2]), .seg3(seg_lc[3]),
        .seg4(seg_lc[4]), .seg5(seg_lc[5]), .seg6(seg_lc[6]), .seg7(seg_lc[7]),
        .seg8(seg_lc[8]), .seg9(seg_lc[9]), .sega(seg_lc[10]), .segb(seg_lc[11]),
        .segc(seg_lc[12]), .segd(seg_lc[13]), .sege(seg_lc[14]), 
        .segf(seg_lc[15]), .segg(seg_lc[16]) 
    );
    vga_letter2pixel l2p_lo(
        .letter(`O), .theme(theme),
        .seg0(seg_lo[0]), .seg1(seg_lo[1]), .seg2(seg_lo[2]), .seg3(seg_lo[3]),
        .seg4(seg_lo[4]), .seg5(seg_lo[5]), .seg6(seg_lo[6]), .seg7(seg_lo[7]),
        .seg8(seg_lo[8]), .seg9(seg_lo[9]), .sega(seg_lo[10]), .segb(seg_lo[11]),
        .segc(seg_lo[12]), .segd(seg_lo[13]), .sege(seg_lo[14]), 
        .segf(seg_lo[15]), .segg(seg_lo[16]) 
    );
    vga_letter2pixel l2p_lr(
        .letter(`R), .theme(theme),
        .seg0(seg_lr[0]), .seg1(seg_lr[1]), .seg2(seg_lr[2]), .seg3(seg_lr[3]),
        .seg4(seg_lr[4]), .seg5(seg_lr[5]), .seg6(seg_lr[6]), .seg7(seg_lr[7]),
        .seg8(seg_lr[8]), .seg9(seg_lr[9]), .sega(seg_lr[10]), .segb(seg_lr[11]),
        .segc(seg_lr[12]), .segd(seg_lr[13]), .sege(seg_lr[14]), 
        .segf(seg_lr[15]), .segg(seg_lr[16]) 
    );
    vga_letter2pixel l2p_le(
        .letter(`E), .theme(theme),
        .seg0(seg_le[0]), .seg1(seg_le[1]), .seg2(seg_le[2]), .seg3(seg_le[3]),
        .seg4(seg_le[4]), .seg5(seg_le[5]), .seg6(seg_le[6]), .seg7(seg_le[7]),
        .seg8(seg_le[8]), .seg9(seg_le[9]), .sega(seg_le[10]), .segb(seg_le[11]),
        .segc(seg_le[12]), .segd(seg_le[13]), .sege(seg_le[14]), 
        .segf(seg_le[15]), .segg(seg_le[16]) 
    );


    always@(*) begin
    case(theme)
        2'b00: begin
            backgrond = 12'h000;
        end
        2'b01: begin
            backgrond = 12'hfff;
        end
        default: begin
            backgrond = 12'h000;
        end
    endcase
    end


    always @(*) begin
        if(!valid)
            {vgaRed, vgaGreen, vgaBlue} = 12'h0;
        else begin
            case(state)
            `b_rst: begin
                {vgaRed, vgaGreen, vgaBlue} = 12'h0;
            end
            `b_play: begin
                if(h_cnt < DCH0) begin
                    {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
                else if(h_cnt < DCH1) begin
                    if(v_cnt < DCV0) begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                    else if(v_cnt < DCV2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt[5];
                    end
                    else if(v_cnt < DCV3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt[8];
                    end
                    else if(v_cnt < DCV5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt[4];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < DCH2) begin
                    if(v_cnt >= DCV0 && v_cnt < DCV1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt[0];
                    end
                    else if(v_cnt >= DCV2 && v_cnt < DCV3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt[6];
                    end
                    else if(v_cnt >= DCV4 && v_cnt < DCV5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt[3];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < DCH3) begin
                    if(v_cnt < DCV0) begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                    else if(v_cnt < DCV2) begin
                         {vgaRed, vgaGreen, vgaBlue} = seg_cnt[1];
                    end
                    else if(v_cnt < DCV3) begin
                         {vgaRed, vgaGreen, vgaBlue} = seg_cnt[7];
                    end
                    else if(v_cnt < DCV5) begin
                         {vgaRed, vgaGreen, vgaBlue} =seg_cnt[2];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else begin
                    {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
            end
            `stage1, `pmode: begin
                if(h_cnt < S0H0) begin
                    {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
                else if(h_cnt < S0H1) begin
                    if(v_cnt >= S0V0 && v_cnt < S0V3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ls[5];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < S0H2) begin
                    if(v_cnt >= S0V0 && v_cnt < S0V1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ls[0];
                    end
                    else if(v_cnt >= S0V2 && v_cnt < S0V3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ls[16];
                    end
                    else if(v_cnt >= S0V4 && v_cnt < S0V5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ls[3];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < S0H3)begin
                    if(v_cnt >= S0V2 && v_cnt < S0V5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ls[2];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < S1H0) begin
                    {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
                else if(h_cnt < S1H1) begin
                    if(v_cnt >= S0V0 && v_cnt < S0V5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lc[5];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < S1H2) begin
                    if(v_cnt >= S0V0 && v_cnt < S0V1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lc[0];
                    end
                    else if(v_cnt >= S0V4 && v_cnt < S0V5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lc[3];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < S2H0) begin
                    {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
                else if(h_cnt < S2H1) begin
                    if(v_cnt >= S0V0 && v_cnt < S0V5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lo[5];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < S2H2) begin
                     if(v_cnt >= S0V0 && v_cnt < S0V1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lo[0];
                    end
                    else if(v_cnt >= S0V4 && v_cnt < S0V5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lo[3];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < S2H3) begin
                    if(v_cnt >= S0V0 && v_cnt < S0V5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lo[1];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < S3H0) begin
                    {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
                else if(h_cnt < S3H1) begin
                    if(v_cnt >= S0V0 && v_cnt < S0V5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[5];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < S3H2) begin
                    if(v_cnt >= S0V0 && v_cnt < S0V1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[0];
                    end
                    else if(v_cnt >= S0V2 && v_cnt < S0V3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[16];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < S3H2a) begin
                    if(v_cnt >= S0V0 && v_cnt < S0V1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[0];
                    end
                    else if(v_cnt >= S0V2 && v_cnt < S0V3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[16];
                    end
                    else if(v_cnt >= S0V3 && v_cnt <= S3V3a) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[13];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < S3H2b) begin
                    if(v_cnt >= S0V0 && v_cnt < S0V1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[0];
                    end
                    else if(v_cnt >= S0V2 && v_cnt < S0V3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[16];
                    end
                    else if(v_cnt >= S3V3a && v_cnt <= S3V3b) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[13];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < S3H2c) begin
                    if(v_cnt >= S0V0 && v_cnt < S0V1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[0];
                    end
                    else if(v_cnt >= S0V2 && v_cnt < S0V3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[16];
                    end
                    else if(v_cnt >= S3V3b && v_cnt <= S3V3c) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[13];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < S3H2d) begin
                    if(v_cnt >= S0V0 && v_cnt < S0V1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[0];
                    end
                    else if(v_cnt >= S0V2 && v_cnt < S0V3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[16];
                    end
                    else if(v_cnt >= S3V3c && v_cnt <= S3V3d) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[13];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < S3H2e) begin
                    if(v_cnt >= S0V0 && v_cnt < S0V1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[0];
                    end
                    else if(v_cnt >= S0V2 && v_cnt < S0V3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[16];
                    end
                    else if(v_cnt >= S3V3d && v_cnt <= S3V3e) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[13];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < S3H3) begin
                    if(v_cnt >= S0V0 && v_cnt < S0V1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[0];
                    end
                    else if(v_cnt >= S0V2 && v_cnt < S0V3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[16];
                    end
                    else if(v_cnt >= S3V3e && v_cnt <= S0V5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[13];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < S3H4) begin
                    if(v_cnt >= S0V0 && v_cnt < S0V3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[1];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < S4H0) begin
                    {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
                else if(h_cnt < S4H1) begin
                    if(v_cnt >= S0V0 && v_cnt < S0V5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_le[5];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < S4H2) begin
                     if(v_cnt >= S0V0 && v_cnt < S0V1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_le[0];
                    end
                    else if(v_cnt >= S0V2 && v_cnt < S0V3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_le[16];
                    end
                    else if(v_cnt >= S0V4 && v_cnt < S0V5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_le[3];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < DLH0) begin
                /*case(score0)
                    4'd0: {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                    4'd1: {vgaRed, vgaGreen, vgaBlue} = 12'h00f;
                    4'd2: {vgaRed, vgaGreen, vgaBlue} = 12'h0f0;
                    4'd3: {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                    4'd4: {vgaRed, vgaGreen, vgaBlue} = 12'h0ff;
                    4'd5: {vgaRed, vgaGreen, vgaBlue} = 12'hf0f;
                    4'd6: {vgaRed, vgaGreen, vgaBlue} = 12'hff0;
                    default: {vgaRed, vgaGreen, vgaBlue} = backgrond;
                endcase*/
                {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
                else if(h_cnt < DLH1) begin
                    if(v_cnt >= DV0 && v_cnt < DV2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_sl[5];
                    end
                    else if(v_cnt >= DV2 && v_cnt < DV3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_sl[8];
                    end
                    else if(v_cnt >= DV3 && v_cnt < DV5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_sl[4];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
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
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < DLH3) begin
                    if(v_cnt >= DV0 && v_cnt < DV2) begin
                         {vgaRed, vgaGreen, vgaBlue} = seg_sl[1];
                    end
                    else if(v_cnt >= DV2 && v_cnt < DV3) begin
                         {vgaRed, vgaGreen, vgaBlue} = seg_sl[7];
                    end
                    else if(v_cnt >= DV3 && v_cnt < DV5) begin
                         {vgaRed, vgaGreen, vgaBlue} =seg_sl[2];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < DRH0) begin
                    {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
                else if(h_cnt < DRH1) begin
                    if(v_cnt >= DV0 && v_cnt < DV2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_sr[5];
                    end
                    else if(v_cnt >= DV2 && v_cnt < DV3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_sr[8];
                    end
                    else if(v_cnt >= DV3 && v_cnt < DV5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_sr[4];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
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
                         {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < DRH3) begin
                    if(v_cnt >= DV0 && v_cnt < DV2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_sr[1];
                    end
                    else if(v_cnt >= DV2 && v_cnt < DV3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_sr[7];
                    end
                    else if(v_cnt >= DV3 && v_cnt < DV5) begin
                        {vgaRed, vgaGreen, vgaBlue} =seg_sr[2];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else begin
                    {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
            end
            default: begin
                {vgaRed, vgaGreen, vgaBlue} = backgrond;
            end 
            endcase
        end 
    end

endmodule