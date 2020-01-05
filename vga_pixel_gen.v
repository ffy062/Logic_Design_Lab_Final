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
    wire [9:0] DTH0, DTH1, DTH2, DTH3, DTV0, DTV1, DTV2, DTV3, DTV4, DTV5;
    wire [9:0] DDH0, DDH1, DDH2, DDH3;

    wire [9:0] S0H0, S0H1, S0H2, S0H3, S0V0, S0V1, S0V2, S0V3, S0V4, S0V5;
    wire [9:0] S1H0, S1H1, S1H2;
    wire [9:0] S2H0, S2H1, S2H2, S2H3;
    wire [9:0] S3H0, S3H1, S3H2, S3H3, S3H1a, S3H1b;
    wire [9:0] S4H0, S4H1, S4H2;

    wire [9:0] T0H0, T0H1, T0H2, T0H3, T0V0, T0V1, T0V2, T0V3, T0V4, T0V5;
    wire [9:0] T1H0, T1H1, T1H2, T1H3;
    wire [9:0] T2H0, T2H1, T2H2, T2H3, T2H1a, T2H1b, T2H1c, T2H1d, T2H1e, T2H1f;
    wire [9:0] T2H1g, T2H1h, T2H1i, T2H1j, T2H1k, T2V0a, T2V0b, T2V0c, T2V0d, T2V0e;  
    wire [9:0] T2Va1, T2Vb1, T2Vc1, T2Vd1, T2Ve1; 
    wire [9:0] T3H0, T3H1, T3H2;

    wire [11:0] seg_sr [8:0];
    wire [11:0] seg_sl [8:0];
    wire [11:0] seg_cnt0 [8:0];
    wire [11:0] seg_cnt1 [8:0]; 
    wire [11:0] seg_lc [16:0];
    wire [11:0] seg_le [16:0];
    wire [11:0] seg_li [16:0];
    wire [11:0] seg_lm [16:0];
    wire [11:0] seg_lo [16:0];
    wire [11:0] seg_lr [16:0];
    wire [11:0] seg_ls [16:0];
    wire [11:0] seg_lt [16:0];
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

    assign DTH0 = 570; // right time digit 
    assign DTH1 = 576; // height: 60 width: 30 bar width: 6
    assign DTH2 = 594;
    assign DTH3 = 600;
    assign DTV0 = 340;
    assign DTV1 = 346;
    assign DTV2 = 364;
    assign DTV3 = 370;
    assign DTV4 = 394;
    assign DTV5 = 400;

    assign DDH0 = 570 - 40; // left time digit 
    assign DDH1 = 576 - 40; // height: 60 width: 30 bar width: 6
    assign DDH2 = 594 - 40;
    assign DDH3 = 600 - 40;

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
    assign S3H1a = 225;
    assign S3H1b = 226;
    assign S3H2 = 227;
    assign S3H3 = 230;
    

    assign S4H0 = 235; // score letter e
    assign S4H1 = 238; // height: 40 width: 20 bar width 3
    assign S4H2 = 255;
    

    assign T0H0 = 423; // time letter t
    assign T0H1 = 432; // height: 40 width: 21 bar width 3
    assign T0H2 = 435; 
    assign T0H3 = 444;
    assign T0V0 = 360;
    assign T0V1 = 363;
    assign T0V2 = 378;
    assign T0V3 = 381;
    assign T0V4 = 397;
    assign T0V5 = 400;
    
    assign T1H0 = 449; // time letter i
    assign T1H1 = 458; // height: 40 width: 21 bar width 3
    assign T1H2 = 461;
    assign T1H3 = 470;

    assign T2H0 = 476; // score letter m
    assign T2H1 = 479; // height: 40 width: 18 bar width 3
    assign T2H2 = 491;
    assign T2H3 = 494;
    assign T2H1a = 480;
    assign T2H1b = 481;
    assign T2H1c = 482;
    assign T2H1d = 483;
    assign T2H1e = 484;
    assign T2H1f = 485;
    assign T2H1g = 486;
    assign T2H1h = 487;
    assign T2H1i = 488;
    assign T2H1j = 489;
    assign T2H1k = 490;
    assign T2V0a = 363;
    assign T2Va1 = 364;
    assign T2V0b = 366;
    assign T2Vb1 = 367;
    assign T2V0c = 369;
    assign T2Vc1 = 370;
    assign T2v0d = 372;
    assign T2Vd1 = 373;
    assign T2V0e = 375;
    assign T2Ve1 = 376;

    assign T3H0 = 500; // time letter e
    assign T3H1 = 503; // height: 40 width: 20 bar width 3
    assign T3H2 = 520;



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
     vga_num2pixel n2p_cnt0(
        .num(cnt0), .theme(theme),
        .seg0(seg_cnt0[0]),.seg1(seg_cnt0[1]), .seg2(seg_cnt0[2]),
        .seg3(seg_cnt0[3]), .seg4(seg_cnt0[4]), .seg5(seg_cnt0[5]), .seg6(seg_cnt0[6]),
        .seg7(seg_cnt0[7]), .seg8(seg_cnt0[8])
        );
     vga_num2pixel n2p_cnt1(
        .num(cnt1), .theme(theme),
        .seg0(seg_cnt1[0]),.seg1(seg_cnt1[1]), .seg2(seg_cnt1[2]),
        .seg3(seg_cnt1[3]), .seg4(seg_cnt1[4]), .seg5(seg_cnt1[5]), .seg6(seg_cnt1[6]),
        .seg7(seg_cnt1[7]), .seg8(seg_cnt1[8])
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
    vga_letter2pixel l2p_lt(
        .letter(`T), .theme(theme),
        .seg0(seg_lt[0]), .seg1(seg_lt[1]), .seg2(seg_lt[2]), .seg3(seg_lt[3]),
        .seg4(seg_lt[4]), .seg5(seg_lt[5]), .seg6(seg_lt[6]), .seg7(seg_lt[7]),
        .seg8(seg_lt[8]), .seg9(seg_lt[9]), .sega(seg_lt[10]), .segb(seg_lt[11]),
        .segc(seg_lt[12]), .segd(seg_lt[13]), .sege(seg_lt[14]), 
        .segf(seg_lt[15]), .segg(seg_lt[16]) 
    );
    vga_letter2pixel l2p_li(
        .letter(`I), .theme(theme),
        .seg0(seg_li[0]), .seg1(seg_li[1]), .seg2(seg_li[2]), .seg3(seg_li[3]),
        .seg4(seg_li[4]), .seg5(seg_li[5]), .seg6(seg_li[6]), .seg7(seg_li[7]),
        .seg8(seg_li[8]), .seg9(seg_li[9]), .sega(seg_li[10]), .segb(seg_li[11]),
        .segc(seg_li[12]), .segd(seg_li[13]), .sege(seg_li[14]), 
        .segf(seg_li[15]), .segg(seg_li[16]) 
    );
    vga_letter2pixel l2p_lm(
        .letter(`M), .theme(theme),
        .seg0(seg_lm[0]), .seg1(seg_lm[1]), .seg2(seg_lm[2]), .seg3(seg_lm[3]),
        .seg4(seg_lm[4]), .seg5(seg_lm[5]), .seg6(seg_lm[6]), .seg7(seg_lm[7]),
        .seg8(seg_lm[8]), .seg9(seg_lm[9]), .sega(seg_lm[10]), .segb(seg_lm[11]),
        .segc(seg_lm[12]), .segd(seg_lm[13]), .sege(seg_lm[14]), 
        .segf(seg_lm[15]), .segg(seg_lm[16]) 
    );


    always@(*) begin
    case(theme)
        2'b00: begin
            backgrond = 12'h000;
        end
        2'b01: begin
            backgrond = 12'hfff;
        end
        2'b10: begin
            backgrond = 12'he7d;
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
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[5];
                    end
                    else if(v_cnt < DCV3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[8];
                    end
                    else if(v_cnt < DCV5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[4];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < DCH2) begin
                    if(v_cnt >= DCV0 && v_cnt < DCV1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[0];
                    end
                    else if(v_cnt >= DCV2 && v_cnt < DCV3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[6];
                    end
                    else if(v_cnt >= DCV4 && v_cnt < DCV5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[3];
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
                         {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[1];
                    end
                    else if(v_cnt < DCV3) begin
                         {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[7];
                    end
                    else if(v_cnt < DCV5) begin
                         {vgaRed, vgaGreen, vgaBlue} =seg_cnt0[2];
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
                
                // word score start here

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
                else if(h_cnt < S3H1a) begin
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
                else if(h_cnt < S3H2) begin
                    if(v_cnt >= S0V0 && v_cnt < S0V1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[0];
                    end
                    else if(v_cnt >= S0V2 && v_cnt < S0V5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[16];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < S3H3) begin
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

                // word score end here 
                // score digit*2 start here
        
                else if(h_cnt < DLH0) begin
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

                // score digit*2 end here
                // word time start here

                else if(h_cnt < T0H0) begin
                    {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
                else if(h_cnt < T0H1) begin
                    if(v_cnt >= T0V0 && v_cnt < T0V1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lt[0];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < T0H2) begin
                    if(v_cnt >= T0V0 && v_cnt < T0V5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lt[16];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < T0H3)begin
                    if(v_cnt >= T0V0 && v_cnt < T0V1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lt[0];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < T1H0) begin
                    {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
                else if(h_cnt < T1H1) begin
                    if(v_cnt >= T0V0 && v_cnt < T0V1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_li[0];
                    end
                    else if(v_cnt >= T0V4 && v_cnt < T0V5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_li[0];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < T1H2) begin
                    if(v_cnt >= T0V0 && v_cnt < T0V5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_li[16];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < T1H3) begin
                    if(v_cnt >= T0V0 && v_cnt < T0V1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_li[0];
                    end
                    else if(v_cnt >= T0V4 && v_cnt < T0V5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_li[0];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < T2H0) begin
                    {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
                else if(h_cnt < T2H1) begin
                    if(v_cnt >= T0V0 && v_cnt < T0V5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lm[5];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < T2H1a) begin
                    if(v_cnt >= T0V0 && v_cnt <= T2V0a) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lm[10];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end 
                end
                else if(h_cnt < T2H1b) begin
                    if(v_cnt >= T2V0a && v_cnt <= T2Va1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lm[10];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < T2H1c) begin
                    if(v_cnt >= T2Va1 && v_cnt <= T2V0b) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lm[10];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end 
                end
                else if(h_cnt < T2H1d) begin
                    if(v_cnt >= T2V0b && v_cnt <= T2Vb1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lm[10];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < T2H1e) begin
                    if(v_cnt >= T2Vb1 && v_cnt <= T2V0c) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lm[10];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end 
                end
                else if(h_cnt < T2H1f) begin
                    if(v_cnt >= T2Vb1 && v_cnt <= T2V0c) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lm[10];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < T2H1g) begin
                    if(v_cnt >= T2Vb1 && v_cnt <= T2V0c) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lm[10];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end 
                end
                else if(h_cnt < T2H1h) begin
                    if(v_cnt >= T2V0b && v_cnt <= T2Vb1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lm[10];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < T2H1i) begin
                    if(v_cnt >= T2Va1 && v_cnt <= T2V0b) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lm[10];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end 
                end
                else if(h_cnt < T2H1j) begin
                    if(v_cnt >= T2V0a && v_cnt <= T2Va1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lm[10];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < T2H1k) begin
                    if(v_cnt >= T0V0 && v_cnt <= T2V0a) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lm[10];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < T2H2) begin
                    if(v_cnt >= T0V0 && v_cnt <= T2V0a) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lm[10];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < T2H3) begin
                    if(v_cnt >= T0V0 && v_cnt < T0V5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lm[1];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < T3H0) begin
                    {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
                else if(h_cnt < T3H1) begin
                    if(v_cnt >= T0V0 && v_cnt < T0V5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_le[5];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < T3H2) begin
                    if(v_cnt >= T0V0 && v_cnt < T0V1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_le[0];
                    end
                    else if(v_cnt >= T0V2 && v_cnt < T0V3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_le[16];
                    end
                    else if(v_cnt >= T0V4 && v_cnt < T0V5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_le[3];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end

                // word time end here
                // time digit*2 start here

                else if(h_cnt < DDH0) begin
                {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
                else if(h_cnt < DDH1) begin
                    if(v_cnt >= DTV0 && v_cnt < DTV2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt1[5];
                    end
                    else if(v_cnt >= DTV2 && v_cnt < DTV3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt1[8];
                    end
                    else if(v_cnt >= DTV3 && v_cnt < DTV5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt1[4];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < DDH2) begin
                    if(v_cnt >= DTV0 && v_cnt < DTV1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt1[0];
                    end
                    else if(v_cnt >= DTV2 && v_cnt < DTV3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt1[6];
                    end
                    else if(v_cnt >= DTV4 && v_cnt < DTV5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt1[3];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < DDH3) begin
                    if(v_cnt >= DTV0 && v_cnt < DTV2) begin
                         {vgaRed, vgaGreen, vgaBlue} = seg_cnt1[1];
                    end
                    else if(v_cnt >= DTV2 && v_cnt < DTV3) begin
                         {vgaRed, vgaGreen, vgaBlue} = seg_cnt1[7];
                    end
                    else if(v_cnt >= DTV3 && v_cnt < DTV5) begin
                         {vgaRed, vgaGreen, vgaBlue} =seg_cnt1[2];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < DTH0) begin
                    {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
                else if(h_cnt < DTH1) begin
                    if(v_cnt >= DTV0 && v_cnt < DTV2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[5];
                    end
                    else if(v_cnt >= DTV2 && v_cnt < DTV3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[8];
                    end
                    else if(v_cnt >= DTV3 && v_cnt < DTV5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[4];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < DTH2) begin
                    if(v_cnt >= DTV0 && v_cnt < DTV1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[0];
                    end
                    else if(v_cnt >= DTV2 && v_cnt < DTV3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[6];
                    end
                    else if(v_cnt >= DTV4 && v_cnt < DTV5) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[3];
                    end
                    else begin
                         {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(h_cnt < DTH3) begin
                    if(v_cnt >= DTV0 && v_cnt < DTV2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[1];
                    end
                    else if(v_cnt >= DTV2 && v_cnt < DTV3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[7];
                    end
                    else if(v_cnt >= DTV3 && v_cnt < DTV5) begin
                        {vgaRed, vgaGreen, vgaBlue} =seg_cnt0[2];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end

                // time digit*2 end here

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