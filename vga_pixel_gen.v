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
`define go 4'd10
`define wait_slave 4'd11
`define compete 4'd12


module vga_pixel_gen(
    h_cnt, v_cnt, valid, t_chg, ambiant, shine, clk, rst,  
    state, score0, score1, cnt0, cnt1,
    vgaRed, vgaGreen, vgaBlue
    );

    input [9:0] h_cnt, v_cnt;
    input valid, ambiant, shine, clk, t_chg, rst;
    input [3:0] state;
    input [3:0] score0, score1, cnt0, cnt1;
    output reg [3:0] vgaRed, vgaGreen, vgaBlue;

    wire [3:0] theme;
    wire max;
    reg [3:0] pass;
    
    assign max = (score0 == 9 && score1 == 9)? 1'b1 : 1'b0;

    always@(*) begin
        case(state)
            `stage1: pass = (score1 > 1 || (score1 == 1 && score0 >= 5))? theme + 3 : theme;
            `stage2: pass = (score1 >= 4 && score0 >= 0)? theme + 3 : theme;
            `stage3: pass = (score1 > 8 || (score1 == 8 && score0 >= 5))? theme + 3 : theme;
            default: pass = theme;
        endcase
    end

    wire [9:0] DRH0, DRH1, DRH2, DRH3, DV0, DV1, DV2, DV3, DV4, DV5;
    wire [9:0] DLH0, DLH1, DLH2, DLH3;
    wire [9:0] DCH0, DCH1, DCH2, DCH3, DCV0, DCV1, DCV2, DCV3, DCV4, DCV5;
    wire [9:0] DTH0, DTH1, DTH2, DTH3, DTV0, DTV1, DTV2, DTV3, DTV4, DTV5;
    wire [9:0] DDH0, DDH1, DDH2, DDH3;

    wire [9:0] S0H0, S0H1, S0H2, S0H3, S0V0, S0V1, S0V2, S0V3, S0V4, S0V5;
    wire [9:0] S1H0, S1H1, S1H2;
    wire [9:0] S2H0, S2H1, S2H2, S2H3;
    wire [9:0] S3H0, S3H1, S3H2, S3H3, S3H1a;
    wire [9:0] S4H0, S4H1, S4H2;

    wire [9:0] T0H0, T0H1, T0H2, T0H3, T0V0, T0V1, T0V2, T0V3, T0V4, T0V5;
    wire [9:0] T1H0, T1H1, T1H2, T1H3;
    wire [9:0] T2H0, T2H1, T2H2, T2H3, T2H1a, T2H1b, T2H1c, T2H1d, T2H1e, T2H1f;
    wire [9:0] T2H1g, T2H1h, T2H1i, T2H1j, T2H1k, T2V0a, T2V0b, T2V0c, T2V0d, T2V0e;  
    wire [9:0] T2Va1, T2Vb1, T2Vc1, T2Vd1, T2Ve1; 
    wire [9:0] T3H0, T3H1, T3H2;

    wire [9:0] B0H0, B0H1, B0H2, B0H3, B1H0, B1H1, B1H2, B1H3, B2H0, B2H1, B2H2, B2H3;
    wire [9:0] B3H0, B3H1, B3H2, B3H2a, B3H2b, B3H3, B0H2a, B6H2a;
    wire [9:0] B4H0, B4H1, B4H2, B5H0, B5H1, B5H2, B5H3, B6H0, B6H1, B6H2, B6H3;
    wire [9:0] B7H0, B7H1, B7H2, B7H3, B8H0, B8H1, B8H2, B9H0, B9H1, B9H2;
    wire [9:0] B0V0, B0V1, B0V2, B0V3, B0V4, B0V5;

    wire [9:0] P0H0, P0H1, P0H2, P0H3, P1H0, P1H1,P1H1a, P1H2, P1H3, P2H0, P2H1, P2H2;
    wire [9:0] P3H0, P3H1, P3H2, P3H3, P4H0, P4H1, P4H2, P4H3;
    wire [9:0] P5H0, P5H1, P5H2, P5H3, P6H0, P6H1, P6H2, P6H3, P7H0, P7H1, P7H2, P7H3;
    wire [9:0] P8H0, P8H1, P8H2, P8H3, P9H0, P9H1, P9H2, P9H3;
    wire [9:0] PaH0, PaH1, PaH2,PaH1a, PaH3, PbH0, PbH1, PbH2, PbH3;
    wire [9:0] P0V0, P0V1, P0V2, P0V3, P0V4, P0V5;  


    wire [9:0] Y0H0, Y0H1, Y0H2, Y0H3, Y1H0, Y1H1, Y1H2, Y1H3, Y2H0, Y2H1, Y2H2, Y2H3;
    wire [9:0] F0H0, F0H1, F0H2, F0H3, F1H0, F1H1, F1H2, F1H3, F2H0, F2H1, F2H2, F2H3;
    wire [9:0] F3H0, F3H1, F3H2, F3H3, F0V0, F0V1, F0V2, F0V3, F0V4, F0V5;

    wire [9:0] G0H0, G0H1,G0H1a, G0H2, G0H3, G1H0, G1H1, G1H2, G1H3;
    wire [9:0] G0V0, G0V1, G0V2, G0V3, G0V4, G0V5;
 
    wire [11:0] seg_sr [8:0];
    wire [11:0] seg_sl [8:0];
    wire [11:0] seg_cnt0 [8:0];
    wire [11:0] seg_cnt1 [8:0];
    wire [11:0] seg_la [15:0];
    wire [11:0] seg_las [15:0];
    wire [11:0] seg_laa [15:0];
    wire [11:0] seg_lb [15:0];
    wire [11:0] seg_lbs [15:0]; 
    wire [11:0] seg_lc [15:0];
    wire [11:0] seg_le [15:0];
    wire [11:0] seg_les [15:0];
    wire [11:0] seg_lea [15:0];
    wire [11:0] seg_lg [15:0];
    wire [11:0] seg_li [15:0];
    wire [11:0] seg_lk [15:0];
    wire [11:0] seg_lks [15:0];
    wire [11:0] seg_ll [15:0];
    wire [11:0] seg_lls [15:0];
    wire [11:0] seg_lm [15:0];
    wire [11:0] seg_lo [15:0];
    wire [11:0] seg_loa [15:0];
    wire [11:0] seg_lp [15:0];
    wire [11:0] seg_lpa [15:0];
    wire [11:0] seg_lr [15:0];
    wire [11:0] seg_lra [15:0];
    wire [11:0] seg_ls [15:0];
    wire [11:0] seg_lss [15:0];
    wire [11:0] seg_lsa [15:0];
    wire [11:0] seg_lt [15:0];
    wire [11:0] seg_lts [15:0];
    wire [11:0] seg_lta [15:0];
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
    assign S3H1a = 224;
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

    assign B0H0 = 130; // basketball letter b0
    assign B0H1 = 135; // height: 60 width: 30 bar width: 5
    assign B0H2 = 155;
    assign B0H3 = 160;
    assign B0H2a = 157;
    assign B0V0 = 170;
    assign B0V1 = 175;
    assign B0V2 = 197;
    assign B0V3 = 202;
    assign B0V4 = 225;
    assign B0V5 = 230;

    assign B1H0 = 168; // basketball letter a0
    assign B1H1 = 173; // height: 60 width: 30 bar width: 5
    assign B1H2 = 193;
    assign B1H3 = 198;

    assign B2H0 = 206; // basketball letter s0
    assign B2H1 = 211; // height: 60 width: 30 bar width: 5
    assign B2H2 = 231;
    assign B2H3 = 236;

    assign B3H0 = 244; // basketball letter k
    assign B3H1 = 249; // height: 60 width: 30 bar width: 5
    assign B3H2 = 269;
    assign B3H3 = 274;
    assign B3H2a = 262;
    assign B3H2b = 267;

    assign B4H0 = 282; // basketball letter e
    assign B4H1 = 287; // height: 60 width: 30 bar width: 5
    assign B4H2 = 312; 

    assign B5H0 = 320; // basketball letter t
    assign B5H1 = 332; // height: 60 width: 30 bar width: 6
    assign B5H2 = 338;
    assign B5H3 = 350;    

    assign B6H0 = 358; // basketball letter b1
    assign B6H1 = 363; // height: 60 width: 30 bar width: 5
    assign B6H2 = 382;
    assign B6H3 = 388;
    assign B6H2a = 384;

    assign B7H0 = 393; // basketball letter a1
    assign B7H1 = 398; // height: 60 width: 30 bar width: 5
    assign B7H2 = 418;
    assign B7H3 = 423; 

    assign B8H0 = 431; // basketball letter l0
    assign B8H1 = 436; // height: 60 width: 30 bar width: 5
    assign B8H2 = 461;

    assign B9H0 = 468; // basketball letter l1
    assign B9H1 = 473; // height: 60 width: 30 bar width: 5
    assign B9H2 = 498; 

    assign P0H0 = 155; // press letter p
    assign P0H1 = 158; // height: 40 width: 20 bar width: 3
    assign P0H2 = 172;
    assign P0H3 = 175;
    assign P0V0 = 360;
    assign P0V1 = 363;
    assign P0V2 = 378;
    assign P0V3 = 381;
    assign P0V4 = 397;
    assign P0V5 = 400;
    
    assign P1H0 = 180; // press letter r
    assign P1H1 = 183; // height: 40 width: 20 bar width: 3
    assign P1H1a = 194;
    assign P1H2 = 197;
    assign P1H3 = 200;
    
    assign P2H0 = 205; // press letter e
    assign P2H1 = 208; // height: 40 width: 20 bar width: 3
    assign P2H2 = 225;

    assign P3H0 = 230; // press letter s0
    assign P3H1 = 233; // height: 40 width: 20 bar width: 3
    assign P3H2 = 247;
    assign P3H3 = 250;

    assign P4H0 = 255; // press letter s1
    assign P4H1 = 258; // height: 40 width: 20 bar width: 3
    assign P4H2 = 272;
    assign P4H3 = 275;

    assign P5H0 = 295; // to letter t
    assign P5H1 = 303; // height: 40 width: 20 bar width: 3
    assign P5H2 = 307;
    assign P5H3 = 315;

    assign P6H0 = 320; // to letter o
    assign P6H1 = 323; // height: 40 width: 20 bar width: 3
    assign P6H2 = 337;
    assign P6H3 = 340;

    assign P7H0 = 360; // start letter s
    assign P7H1 = 363; // height: 40 width: 20 bar width: 3
    assign P7H2 = 377;
    assign P7H3 = 380;

    assign P8H0 = 385; // start letter t
    assign P8H1 = 393; // height: 40 width: 20 bar width: 3
    assign P8H2 = 397;
    assign P8H3 = 405;

    assign P9H0 = 410; // start letter a
    assign P9H1 = 413; // height: 40 width: 20 bar width: 3
    assign P9H2 = 427;
    assign P9H3 = 430;

    assign PaH0 = 435; // start letter r
    assign PaH1 = 438; // height: 40 width: 20 bar width: 3
    assign PaH1a = 449;
    assign PaH2 = 452;
    assign PaH3 = 455;

    assign PbH0 = 460; // start letter t
    assign PbH1 = 468; // height: 40 width: 20 bar width: 3
    assign PbH2 = 472;
    assign PbH3 = 480;

    assign Y0H0 = 155; //you letter y
    assign Y0H1 = 161; // height: 80 width: 40 bar width: 6
    assign Y0H2 = 189;
    assign Y0H3 = 195;
    
    assign Y1H0 = 205; //you letter o
    assign Y1H1 = 211; // height: 80 width: 40 bar width: 6
    assign Y1H2 = 239;
    assign Y1H3 = 245;

    assign Y2H0 = 255; //you letter u
    assign Y2H1 = 261; // height: 80 width: 40 bar width: 6
    assign Y2H2 = 289;
    assign Y2H3 = 295;

    assign F0H0 = 325; // pass letter p,  lose letter l
    assign F0H1 = 331; // height: 80 width: 40 bar width: 6
    assign F0H2 = 359;
    assign F0H3 = 365;
    assign F0V0 = 200;
    assign F0V1 = 206;
    assign F0V2 = 237;
    assign F0V3 = 243;
    assign F0V4 = 274;
    assign F0V5 = 280;

    assign F1H0 = 375; // pass letter a,  lose letter o
    assign F1H1 = 381; // height: 80 width: 40 bar width: 6
    assign F1H2 = 409;
    assign F1H3 = 415;
     
    assign F2H0 = 425; // pass letter s0,  lose letter s
    assign F2H1 = 431; // height: 80 width: 40 bar width: 6
    assign F2H2 = 459;
    assign F2H3 = 465;

    assign F3H0 = 475; // pass letter s1,  lose letter e
    assign F3H1 = 481; // height: 80 width: 40 bar width: 6
    assign F3H2 = 509;
    assign F3H3 = 515;

    assign G0H0 = 270; // go letter g
    assign G0H1 = 276; // height: 80 width: 40 bar width: 6
    assign G0H1a = 290;
    assign G0H2 = 304;
    assign G0H3 = 310;
    assign G0V0 = 250;
    assign G0V1 = 256;
    assign G0V2 = 287;
    assign G0V3 = 293;
    assign G0V4 = 324;
    assign G0V5 = 330;

    assign G1H0 = 330; // go letter o
    assign G1H1 = 336; // height: 80 width: 40 bar width: 6
    assign G1H2 = 364;
    assign G1H3 = 370;

    // theme control 
    vga_theme_ctrl theme_ctrl(.clk(clk), .rst(rst), .chg(t_chg), .theme(theme)); 
    
    always@(posedge clk) begin
    case(theme)
        4'd0: begin
            if(cnt0 <= 5 && cnt1 == 0 && shine == 1) begin
                    backgrond <= (backgrond == 12'h000)? 12'hf00 : 12'h000;
            end
            else begin
                backgrond = 12'h000;
            end
        end
        4'd1: begin
            if(cnt0 <= 5 && cnt1 == 0 && shine == 1) begin
                    backgrond <= (backgrond == 12'hfff)? 12'hf00 : 12'hfff;
            end
            else begin
                backgrond = 12'hfff;
            end
        end
        4'd2: begin
            if(cnt0 <= 5 && cnt1 == 0 && shine == 1) begin
                backgrond <= (backgrond == 12'he7d)? 12'hf00 : 12'he7d;
            end
            else begin
                backgrond = 12'he7d;
            end
        end
        default: begin
            backgrond = 12'h000;
        end
    endcase
    end

    // number to pixel color
    vga_num2pixel n2p_sr(
        .num(score0), .theme(pass), .max(max), 
        .seg0(seg_sr[0]),.seg1(seg_sr[1]), .seg2(seg_sr[2]),
        .seg3(seg_sr[3]), .seg4(seg_sr[4]), .seg5(seg_sr[5]), .seg6(seg_sr[6]),
        .seg7(seg_sr[7]), .seg8(seg_sr[8])
        );
     vga_num2pixel n2p_sl(
        .num(score1), .theme(pass), .max(max), 
        .seg0(seg_sl[0]), .seg1(seg_sl[1]), .seg2(seg_sl[2]),
        .seg3(seg_sl[3]), .seg4(seg_sl[4]), .seg5(seg_sl[5]), .seg6(seg_sl[6]),
        .seg7(seg_sl[7]), .seg8(seg_sl[8])
        );
     vga_num2pixel n2p_cnt0(
        .num(cnt0), .theme(theme), .max(1'b0), 
        .seg0(seg_cnt0[0]),.seg1(seg_cnt0[1]), .seg2(seg_cnt0[2]),
        .seg3(seg_cnt0[3]), .seg4(seg_cnt0[4]), .seg5(seg_cnt0[5]), .seg6(seg_cnt0[6]),
        .seg7(seg_cnt0[7]), .seg8(seg_cnt0[8])
        );
     vga_num2pixel n2p_cnt1(
        .num(cnt1), .theme(theme), .max(1'b0), 
        .seg0(seg_cnt1[0]),.seg1(seg_cnt1[1]), .seg2(seg_cnt1[2]),
        .seg3(seg_cnt1[3]), .seg4(seg_cnt1[4]), .seg5(seg_cnt1[5]), .seg6(seg_cnt1[6]),
        .seg7(seg_cnt1[7]), .seg8(seg_cnt1[8])
        );

    // letter to pixel color 
    vga_letter2pixel l2p_ls(
        .letter(`S), .theme(theme), .steady(1'b1), 
        .ambiant(1'b0), .shine(1'b0), .clk(clk | t_chg), .valid(valid),
        .seg0(seg_ls[0]), .seg1(seg_ls[1]), .seg2(seg_ls[2]), .seg3(seg_ls[3]),
        .seg4(seg_ls[4]), .seg5(seg_ls[5]), .seg6(seg_ls[6]), .seg7(seg_ls[7]),
        .seg8(seg_ls[8]), .seg9(seg_ls[9]), .sega(seg_ls[10]), .segb(seg_ls[11]),
        .segc(seg_ls[12]), .segd(seg_ls[13]), .sege(seg_ls[14]), .segf(seg_ls[15])
    );
    vga_letter2pixel l2p_lc(
        .letter(`C), .theme(theme), .steady(1'b1), 
        .ambiant(1'b0), .shine(1'b0), .clk(clk | t_chg), .valid(valid),
        .seg0(seg_lc[0]), .seg1(seg_lc[1]), .seg2(seg_lc[2]), .seg3(seg_lc[3]),
        .seg4(seg_lc[4]), .seg5(seg_lc[5]), .seg6(seg_lc[6]), .seg7(seg_lc[7]),
        .seg8(seg_lc[8]), .seg9(seg_lc[9]), .sega(seg_lc[10]), .segb(seg_lc[11]),
        .segc(seg_lc[12]), .segd(seg_lc[13]), .sege(seg_lc[14]), .segf(seg_lc[15])
    );
    vga_letter2pixel l2p_lo(
        .letter(`O), .theme(theme), .steady(1'b1), 
        .ambiant(1'b0), .shine(1'b0), .clk(clk | t_chg), .valid(valid),
        .seg0(seg_lo[0]), .seg1(seg_lo[1]), .seg2(seg_lo[2]), .seg3(seg_lo[3]),
        .seg4(seg_lo[4]), .seg5(seg_lo[5]), .seg6(seg_lo[6]), .seg7(seg_lo[7]),
        .seg8(seg_lo[8]), .seg9(seg_lo[9]), .sega(seg_lo[10]), .segb(seg_lo[11]),
        .segc(seg_lo[12]), .segd(seg_lo[13]), .sege(seg_lo[14]), .segf(seg_lo[15])
    );
    vga_letter2pixel l2p_lr(
        .letter(`R), .theme(theme), .steady(1'b1), 
        .ambiant(1'b0), .shine(1'b0), .clk(clk | t_chg), .valid(valid),
        .seg0(seg_lr[0]), .seg1(seg_lr[1]), .seg2(seg_lr[2]), .seg3(seg_lr[3]),
        .seg4(seg_lr[4]), .seg5(seg_lr[5]), .seg6(seg_lr[6]), .seg7(seg_lr[7]),
        .seg8(seg_lr[8]), .seg9(seg_lr[9]), .sega(seg_lr[10]), .segb(seg_lr[11]),
        .segc(seg_lr[12]), .segd(seg_lr[13]), .sege(seg_lr[14]), .segf(seg_lr[15])
    );
    vga_letter2pixel l2p_le(
        .letter(`E), .theme(theme), .steady(1'b1), 
        .ambiant(1'b0), .shine(1'b0), .clk(clk | t_chg), .valid(valid),
        .seg0(seg_le[0]), .seg1(seg_le[1]), .seg2(seg_le[2]), .seg3(seg_le[3]),
        .seg4(seg_le[4]), .seg5(seg_le[5]), .seg6(seg_le[6]), .seg7(seg_le[7]),
        .seg8(seg_le[8]), .seg9(seg_le[9]), .sega(seg_le[10]), .segb(seg_le[11]),
        .segc(seg_le[12]), .segd(seg_le[13]), .sege(seg_le[14]), .segf(seg_le[15])
    );
    vga_letter2pixel l2p_lt(
        .letter(`T), .theme(theme), .steady(1'b1), 
        .ambiant(1'b0), .shine(1'b0), .clk(clk | t_chg), .valid(valid),
        .seg0(seg_lt[0]), .seg1(seg_lt[1]), .seg2(seg_lt[2]), .seg3(seg_lt[3]),
        .seg4(seg_lt[4]), .seg5(seg_lt[5]), .seg6(seg_lt[6]), .seg7(seg_lt[7]),
        .seg8(seg_lt[8]), .seg9(seg_lt[9]), .sega(seg_lt[10]), .segb(seg_lt[11]),
        .segc(seg_lt[12]), .segd(seg_lt[13]), .sege(seg_lt[14]), .segf(seg_lt[15])
    );
    vga_letter2pixel l2p_li(
        .letter(`I), .theme(theme), .steady(1'b1), 
        .ambiant(1'b0), .shine(1'b0), .clk(clk | t_chg), .valid(valid),
        .seg0(seg_li[0]), .seg1(seg_li[1]), .seg2(seg_li[2]), .seg3(seg_li[3]),
        .seg4(seg_li[4]), .seg5(seg_li[5]), .seg6(seg_li[6]), .seg7(seg_li[7]),
        .seg8(seg_li[8]), .seg9(seg_li[9]), .sega(seg_li[10]), .segb(seg_li[11]),
        .segc(seg_li[12]), .segd(seg_li[13]), .sege(seg_li[14]), .segf(seg_li[15])
    );
    vga_letter2pixel l2p_lm(
        .letter(`M), .theme(theme), .steady(1'b1), 
        .ambiant(1'b0), .shine(1'b0), .clk(clk | t_chg),  .valid(valid),
        .seg0(seg_lm[0]), .seg1(seg_lm[1]), .seg2(seg_lm[2]), .seg3(seg_lm[3]),
        .seg4(seg_lm[4]), .seg5(seg_lm[5]), .seg6(seg_lm[6]), .seg7(seg_lm[7]),
        .seg8(seg_lm[8]), .seg9(seg_lm[9]), .sega(seg_lm[10]), .segb(seg_lm[11]),
        .segc(seg_lm[12]), .segd(seg_lm[13]), .sege(seg_lm[14]), .segf(seg_lm[15])
    );
    vga_letter2pixel l2p_lp(
        .letter(`P), .theme(theme), .steady(1'b1), 
        .ambiant(1'b0), .shine(1'b0), .clk(clk | t_chg),  .valid(valid),
        .seg0(seg_lp[0]), .seg1(seg_lp[1]), .seg2(seg_lp[2]), .seg3(seg_lp[3]),
        .seg4(seg_lp[4]), .seg5(seg_lp[5]), .seg6(seg_lp[6]), .seg7(seg_lp[7]),
        .seg8(seg_lp[8]), .seg9(seg_lp[9]), .sega(seg_lp[10]), .segb(seg_lp[11]),
        .segc(seg_lp[12]), .segd(seg_lp[13]), .sege(seg_lp[14]), .segf(seg_lp[15])
    );
    vga_letter2pixel l2p_ll(
        .letter(`L), .theme(theme), .steady(1'b1), 
        .ambiant(1'b0), .shine(1'b0), .clk(clk | t_chg),  .valid(valid),
        .seg0(seg_ll[0]), .seg1(seg_ll[1]), .seg2(seg_ll[2]), .seg3(seg_ll[3]),
        .seg4(seg_ll[4]), .seg5(seg_ll[5]), .seg6(seg_ll[6]), .seg7(seg_ll[7]),
        .seg8(seg_ll[8]), .seg9(seg_ll[9]), .sega(seg_ll[10]), .segb(seg_ll[11]),
        .segc(seg_ll[12]), .segd(seg_ll[13]), .sege(seg_ll[14]), .segf(seg_ll[15])
    );
    vga_letter2pixel l2p_la(
        .letter(`A), .theme(theme), .steady(1'b1), 
        .ambiant(1'b0), .shine(1'b0), .clk(clk | t_chg),  .valid(valid),
        .seg0(seg_la[0]), .seg1(seg_la[1]), .seg2(seg_la[2]), .seg3(seg_la[3]),
        .seg4(seg_la[4]), .seg5(seg_la[5]), .seg6(seg_la[6]), .seg7(seg_la[7]),
        .seg8(seg_la[8]), .seg9(seg_la[9]), .sega(seg_la[10]), .segb(seg_la[11]),
        .segc(seg_la[12]), .segd(seg_la[13]), .sege(seg_la[14]), .segf(seg_la[15])
    );
    vga_letter2pixel l2p_lg(
        .letter(`G), .theme(theme), .steady(1'b1), 
        .ambiant(1'b0), .shine(1'b0), .clk(clk | t_chg),  .valid(valid),
        .seg0(seg_lg[0]), .seg1(seg_lg[1]), .seg2(seg_lg[2]), .seg3(seg_lg[3]),
        .seg4(seg_lg[4]), .seg5(seg_lg[5]), .seg6(seg_lg[6]), .seg7(seg_lg[7]),
        .seg8(seg_lg[8]), .seg9(seg_lg[9]), .sega(seg_lg[10]), .segb(seg_lg[11]),
        .segc(seg_lg[12]), .segd(seg_lg[13]), .sege(seg_lg[14]), .segf(seg_lg[15])
    );

    // letter to pixel shine
    vga_letter2pixel l2p_lbs(
        .letter(`B), .theme(theme), .steady(1'b0), 
        .ambiant(1'b0), .shine(shine), .clk(clk | t_chg), .valid(valid),
        .seg0(seg_lbs[0]), .seg1(seg_lbs[1]), .seg2(seg_lbs[2]), .seg3(seg_lbs[3]),
        .seg4(seg_lbs[4]), .seg5(seg_lbs[5]), .seg6(seg_lbs[6]), .seg7(seg_lbs[7]),
        .seg8(seg_lbs[8]), .seg9(seg_lbs[9]), .sega(seg_lbs[10]), .segb(seg_lbs[11]),
        .segc(seg_lbs[12]), .segd(seg_lbs[13]), .sege(seg_lbs[14]), .segf(seg_lbs[15])
    );
    vga_letter2pixel l2p_las(
        .letter(`A), .theme(theme), .steady(1'b0),
        .ambiant(1'b0), .shine(shine), .clk(clk | t_chg), .valid(valid),
        .seg0(seg_las[0]), .seg1(seg_las[1]), .seg2(seg_las[2]), .seg3(seg_las[3]),
        .seg4(seg_las[4]), .seg5(seg_las[5]), .seg6(seg_las[6]), .seg7(seg_las[7]),
        .seg8(seg_las[8]), .seg9(seg_las[9]), .sega(seg_las[10]), .segb(seg_las[11]),
        .segc(seg_las[12]), .segd(seg_las[13]), .sege(seg_la[14]), .segf(seg_las[15])
    );
    vga_letter2pixel l2p_lss(
        .letter(`S), .theme(theme), .steady(1'b0), 
        .ambiant(1'b0), .shine(shine), .clk(clk | t_chg), .valid(valid),
        .seg0(seg_lss[0]), .seg1(seg_lss[1]), .seg2(seg_lss[2]), .seg3(seg_lss[3]),
        .seg4(seg_lss[4]), .seg5(seg_lss[5]), .seg6(seg_lss[6]), .seg7(seg_lss[7]),
        .seg8(seg_lss[8]), .seg9(seg_lss[9]), .sega(seg_lss[10]), .segb(seg_lss[11]),
        .segc(seg_lss[12]), .segd(seg_lss[13]), .sege(seg_lss[14]), .segf(seg_lss[15])
    );
     vga_letter2pixel l2p_lks(
        .letter(`K), .theme(theme), .steady(1'b0),
        .ambiant(1'b0), .shine(shine), .clk(clk | t_chg), .valid(valid),
        .seg0(seg_lks[0]), .seg1(seg_lks[1]), .seg2(seg_lks[2]), .seg3(seg_lks[3]),
        .seg4(seg_lks[4]), .seg5(seg_lks[5]), .seg6(seg_lks[6]), .seg7(seg_lks[7]),
        .seg8(seg_lks[8]), .seg9(seg_lks[9]), .sega(seg_lks[10]), .segb(seg_lks[11]),
        .segc(seg_lks[12]), .segd(seg_lks[13]), .sege(seg_lks[14]), .segf(seg_lks[15])
    );
    vga_letter2pixel l2p_les(
        .letter(`E), .theme(theme), .steady(1'b0),
        .ambiant(1'b0), .shine(shine), .clk(clk | t_chg), .valid(valid),
        .seg0(seg_les[0]), .seg1(seg_les[1]), .seg2(seg_les[2]), .seg3(seg_les[3]),
        .seg4(seg_les[4]), .seg5(seg_les[5]), .seg6(seg_les[6]), .seg7(seg_les[7]),
        .seg8(seg_les[8]), .seg9(seg_les[9]), .sega(seg_les[10]), .segb(seg_les[11]),
        .segc(seg_les[12]), .segd(seg_les[13]), .sege(seg_les[14]), .segf(seg_les[15])
    );
    vga_letter2pixel l2p_lts(
        .letter(`T), .theme(theme), .steady(1'b0),
        .ambiant(1'b0), .shine(shine), .clk(clk | t_chg), .valid(valid),
        .seg0(seg_lts[0]), .seg1(seg_lts[1]), .seg2(seg_lts[2]), .seg3(seg_lts[3]),
        .seg4(seg_lts[4]), .seg5(seg_lts[5]), .seg6(seg_lts[6]), .seg7(seg_lts[7]),
        .seg8(seg_lts[8]), .seg9(seg_lts[9]), .sega(seg_lts[10]), .segb(seg_lts[11]),
        .segc(seg_lts[12]), .segd(seg_lts[13]), .sege(seg_lts[14]), .segf(seg_lts[15])
    );
    vga_letter2pixel l2p_lls(
        .letter(`L), .theme(theme), .steady(1'b0),
        .ambiant(1'b0), .shine(shine), .clk(clk | t_chg), .valid(valid),
        .seg0(seg_lls[0]), .seg1(seg_lls[1]), .seg2(seg_lls[2]), .seg3(seg_lls[3]),
        .seg4(seg_lls[4]), .seg5(seg_lls[5]), .seg6(seg_lls[6]), .seg7(seg_lls[7]),
        .seg8(seg_lls[8]), .seg9(seg_lls[9]), .sega(seg_lls[10]), .segb(seg_lls[11]),
        .segc(seg_lls[12]), .segd(seg_lls[13]), .sege(seg_lls[14]), .segf(seg_lls[15])
    );

    // letter to pixel ambiant
    vga_letter2pixel l2p_lpa(
        .letter(`P), .theme(theme), .steady(1'b0),
        .ambiant(ambiant), .shine(1'b0), .clk(clk | t_chg), .valid(valid),
        .seg0(seg_lpa[0]), .seg1(seg_lpa[1]), .seg2(seg_lpa[2]), .seg3(seg_lpa[3]),
        .seg4(seg_lpa[4]), .seg5(seg_lpa[5]), .seg6(seg_lpa[6]), .seg7(seg_lpa[7]),
        .seg8(seg_lpa[8]), .seg9(seg_lpa[9]), .sega(seg_lpa[10]), .segb(seg_lpa[11]),
        .segc(seg_lpa[12]), .segd(seg_lpa[13]), .sege(seg_lpa[14]), .segf(seg_lpa[15])
    );
    vga_letter2pixel l2p_lra(
        .letter(`R), .theme(theme), .steady(1'b0),
        .ambiant(ambiant), .shine(1'b0), .clk(clk | t_chg), .valid(valid),
        .seg0(seg_lra[0]), .seg1(seg_lra[1]), .seg2(seg_lra[2]), .seg3(seg_lra[3]),
        .seg4(seg_lra[4]), .seg5(seg_lra[5]), .seg6(seg_lra[6]), .seg7(seg_lra[7]),
        .seg8(seg_lra[8]), .seg9(seg_lra[9]), .sega(seg_lra[10]), .segb(seg_lra[11]),
        .segc(seg_lra[12]), .segd(seg_lra[13]), .sege(seg_lra[14]), .segf(seg_lra[15])
    );
    vga_letter2pixel l2p_lea(
        .letter(`E), .theme(theme), .steady(1'b0),
        .ambiant(ambiant), .shine(1'b0), .clk(clk | t_chg), .valid(valid),
        .seg0(seg_lea[0]), .seg1(seg_lea[1]), .seg2(seg_lea[2]), .seg3(seg_lea[3]),
        .seg4(seg_lea[4]), .seg5(seg_lea[5]), .seg6(seg_lea[6]), .seg7(seg_lea[7]),
        .seg8(seg_lea[8]), .seg9(seg_lea[9]), .sega(seg_lea[10]), .segb(seg_lea[11]),
        .segc(seg_lea[12]), .segd(seg_lea[13]), .sege(seg_lea[14]), .segf(seg_lea[15])
    );
    vga_letter2pixel l2p_lsa(
        .letter(`S), .theme(theme), .steady(1'b0),
        .ambiant(ambiant), .shine(1'b0), .clk(clk | t_chg), .valid(valid),
        .seg0(seg_lsa[0]), .seg1(seg_lsa[1]), .seg2(seg_lsa[2]), .seg3(seg_lsa[3]),
        .seg4(seg_lsa[4]), .seg5(seg_lsa[5]), .seg6(seg_lsa[6]), .seg7(seg_lsa[7]),
        .seg8(seg_lsa[8]), .seg9(seg_lsa[9]), .sega(seg_lsa[10]), .segb(seg_lsa[11]),
        .segc(seg_lsa[12]), .segd(seg_lsa[13]), .sege(seg_lsa[14]), .segf(seg_lsa[15])
    );
    vga_letter2pixel l2p_lta(
        .letter(`T), .theme(theme), .steady(1'b0),
        .ambiant(ambiant), .shine(1'b0), .clk(clk | t_chg), .valid(valid),
        .seg0(seg_lta[0]), .seg1(seg_lta[1]), .seg2(seg_lta[2]), .seg3(seg_lta[3]),
        .seg4(seg_lta[4]), .seg5(seg_lta[5]), .seg6(seg_lta[6]), .seg7(seg_lta[7]),
        .seg8(seg_lta[8]), .seg9(seg_lta[9]), .sega(seg_lta[10]), .segb(seg_lta[11]),
        .segc(seg_lta[12]), .segd(seg_lta[13]), .sege(seg_lta[14]), .segf(seg_lta[15])
    );
    vga_letter2pixel l2p_loa(
        .letter(`O), .theme(theme), .steady(1'b0),
        .ambiant(ambiant), .shine(1'b0), .clk(clk | t_chg), .valid(valid),
        .seg0(seg_loa[0]), .seg1(seg_loa[1]), .seg2(seg_loa[2]), .seg3(seg_loa[3]),
        .seg4(seg_loa[4]), .seg5(seg_loa[5]), .seg6(seg_loa[6]), .seg7(seg_loa[7]),
        .seg8(seg_loa[8]), .seg9(seg_loa[9]), .sega(seg_loa[10]), .segb(seg_loa[11]),
        .segc(seg_loa[12]), .segd(seg_loa[13]), .sege(seg_loa[14]), .segf(seg_loa[15])
    );
    vga_letter2pixel l2p_laa(
        .letter(`A), .theme(theme), .steady(1'b0),
        .ambiant(ambiant), .shine(1'b0), .clk(clk | t_chg), .valid(valid),
        .seg0(seg_laa[0]), .seg1(seg_laa[1]), .seg2(seg_laa[2]), .seg3(seg_laa[3]),
        .seg4(seg_laa[4]), .seg5(seg_laa[5]), .seg6(seg_laa[6]), .seg7(seg_laa[7]),
        .seg8(seg_laa[8]), .seg9(seg_laa[9]), .sega(seg_laa[10]), .segb(seg_laa[11]),
        .segc(seg_laa[12]), .segd(seg_laa[13]), .sege(seg_laa[14]), .segf(seg_laa[15])
    );




    always @(*) begin
        if(!valid)
            {vgaRed, vgaGreen, vgaBlue} = 12'h0;
          else begin
            case(state)
            `rst: begin
                if(v_cnt < B0V0) begin
                    {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
                else if(v_cnt < B0V1)begin
                    if(h_cnt >= B0H0 && h_cnt < B0H2a) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lbs[0];
                    end
                    else if(h_cnt >= B1H0 && h_cnt < B1H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_las[0];
                    end
                    else if(h_cnt >= B2H0 && h_cnt < B2H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lss[0];
                    end
                    else if((h_cnt >= B3H0 && h_cnt < B3H1)||(h_cnt >= B3H2 && h_cnt < B3H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lks[5];
                    end
                    else if(h_cnt >= B4H0 && h_cnt < B4H2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_les[0];
                    end
                    else if(h_cnt >= B5H0 && h_cnt < B5H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lts[0];
                    end
                    else if(h_cnt >= B6H0 && h_cnt < B6H2a) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lbs[0];
                    end
                    else if(h_cnt >= B7H0 && h_cnt < B7H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_las[0];
                    end
                    else if(h_cnt >= B8H0 && h_cnt < B8H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lls[5];
                    end
                    else if(h_cnt >= B9H0 && h_cnt < B9H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lls[5];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(v_cnt < B0V2) begin
                    if((h_cnt >= B0H0 && h_cnt < B0H1)||(h_cnt >= B0H2 && h_cnt < B0H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lbs[1];
                    end
                    else if((h_cnt >= B1H0 && h_cnt < B1H1)||(h_cnt >= B1H2 && h_cnt < B1H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_las[1];
                    end
                    else if(h_cnt >= B2H0 && h_cnt < B2H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lss[5];
                    end
                    else if((h_cnt >= B3H0 && h_cnt < B3H1)||(h_cnt >= B3H2 && h_cnt < B3H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lks[4];
                    end
                    else if(h_cnt >= B4H0 && h_cnt < B4H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_les[5];
                    end
                    else if(h_cnt >= B5H1 && h_cnt < B5H2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lts[14];
                    end
                    else if((h_cnt >= B6H0 && h_cnt < B6H1)||(h_cnt >= B6H2 && h_cnt < B6H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lbs[1];
                    end
                    else if((h_cnt >= B7H0 && h_cnt < B7H1)||(h_cnt >= B7H2 && h_cnt < B7H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_las[1];
                    end
                    else if(h_cnt >= B8H0 && h_cnt < B8H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lls[4];
                    end
                    else if(h_cnt >= B9H0 && h_cnt < B9H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lls[4];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(v_cnt < B0V3) begin
                    if(h_cnt >= B0H0 && h_cnt < B0H2a) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lbs[3];
                    end
                    else if(h_cnt >= B1H0 && h_cnt < B1H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_las[15];
                    end
                    else if(h_cnt >= B2H0 && h_cnt < B2H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lss[15];
                    end
                    else if(h_cnt >= B3H0 && h_cnt < B3H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lks[15];
                    end
                    else if(h_cnt >= B4H0 && h_cnt < B4H2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_les[15];
                    end
                    else if(h_cnt >= B5H1 && h_cnt < B5H2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lts[15];
                    end
                    else if(h_cnt >= B6H0 && h_cnt < B6H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lbs[15];
                    end
                    else if(h_cnt >= B7H0 && h_cnt < B7H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_las[15];
                    end
                    else if(h_cnt >= B8H0 && h_cnt < B8H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lls[8];
                    end
                    else if(h_cnt >= B9H0 && h_cnt < B9H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lls[8];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(v_cnt < B0V4) begin
                    if((h_cnt >= B0H0 && h_cnt < B0H1)||(h_cnt >= B0H2 && h_cnt < B0H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lbs[2];
                    end
                    else if((h_cnt >= B1H0 && h_cnt < B1H1)||(h_cnt >= B1H2 && h_cnt < B1H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_las[2];
                    end
                    else if(h_cnt >= B2H2 && h_cnt < B2H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lss[2];
                    end
                    else if((h_cnt >= B3H0 && h_cnt < B3H1)||(h_cnt >= B3H2a && h_cnt < B3H2b)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lks[4];
                    end
                    else if(h_cnt >= B4H0 && h_cnt < B4H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_les[4];
                    end
                    else if(h_cnt >= B5H1 && h_cnt < B5H2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lts[14];
                    end
                    else if((h_cnt >= B6H0 && h_cnt < B6H1)||(h_cnt >= B6H2 && h_cnt < B6H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lbs[2];
                    end
                    else if((h_cnt >= B7H0 && h_cnt < B7H1)||(h_cnt >= B7H2 && h_cnt < B7H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_las[2];
                    end
                    else if(h_cnt >= B8H0 && h_cnt < B8H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lls[4];
                    end
                    else if(h_cnt >= B9H0 && h_cnt < B9H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lls[4];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(v_cnt < B0V5) begin
                    if(h_cnt >= B0H0 && h_cnt < B0H2a) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lbs[3];
                    end
                    else if((h_cnt >= B1H0 && h_cnt < B1H1)||(h_cnt >= B1H2 && h_cnt < B1H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_las[2];
                    end
                    else if(h_cnt >= B2H0 && h_cnt < B2H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lss[3];
                    end
                    else if((h_cnt >= B3H0 && h_cnt < B3H1)||(h_cnt >= B3H2a && h_cnt < B3H2b)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lks[4];
                    end
                    else if(h_cnt >= B4H0 && h_cnt < B4H2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_les[3];
                    end
                    else if(h_cnt >= B5H1 && h_cnt < B5H2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lts[14];
                    end
                    else if(h_cnt >= B6H0 && h_cnt < B6H2a) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lbs[3];
                    end
                    else if((h_cnt >= B7H0 && h_cnt < B7H1)||(h_cnt >= B7H2 && h_cnt < B7H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_las[2];
                    end
                    else if(h_cnt >= B8H0 && h_cnt < B8H2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lls[3];
                    end
                    else if(h_cnt >= B9H0 && h_cnt < B9H2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lls[3];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(v_cnt < P0V0) begin
                    {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
                else if(v_cnt < P0V1) begin
                    if(h_cnt >= P0H0 && h_cnt < P0H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lpa[0];
                    end
                    else if(h_cnt >= P1H0 && h_cnt < P1H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lra[0];
                    end
                    else if(h_cnt >= P2H0 && h_cnt < P2H2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lea[0];
                    end
                    else if(h_cnt >= P3H0 && h_cnt < P3H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lsa[0];
                    end
                    else if(h_cnt >= P4H0 && h_cnt < P4H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lsa[0];
                    end
                    else if(h_cnt >= P5H0 && h_cnt < P5H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lta[0];
                    end
                    else if(h_cnt >= P6H0 && h_cnt < P6H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_loa[0];
                    end
                    else if(h_cnt >= P7H0 && h_cnt < P7H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lsa[0];
                    end
                    else if(h_cnt >= P8H0 && h_cnt < P8H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lta[0];
                    end
                    else if(h_cnt >= P9H0 && h_cnt < P9H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_laa[0];
                    end
                    else if(h_cnt >= PaH0 && h_cnt < PaH3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lra[0];
                    end
                    else if(h_cnt >= PbH0 && h_cnt < PbH3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lta[0];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(v_cnt < P0V2) begin
                    if((h_cnt >= P0H0 && h_cnt < P0H1)||(h_cnt >= P0H2 && h_cnt < P0H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lpa[5];
                    end
                    else if((h_cnt >= P1H0 && h_cnt < P1H1)||(h_cnt >= P1H2 && h_cnt < P1H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lra[5];
                    end
                    else if(h_cnt >= P2H0 && h_cnt < P2H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lea[5];
                    end
                    else if(h_cnt >= P3H0 && h_cnt < P3H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lsa[5];
                    end
                    else if(h_cnt >= P4H0 && h_cnt < P4H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lsa[5];
                    end
                    else if(h_cnt >= P5H1 && h_cnt < P5H2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lta[0];
                    end
                    else if((h_cnt >= P6H0 && h_cnt < P6H1)||(h_cnt >= P6H2 && h_cnt < P6H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_loa[0];
                    end
                    else if(h_cnt >= P7H0 && h_cnt < P7H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lsa[0];
                    end
                    else if(h_cnt >= P8H1 && h_cnt < P8H2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lta[0];
                    end
                    else if((h_cnt >= P9H0 && h_cnt < P9H1)||(h_cnt >= P9H2 && h_cnt < P9H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_laa[0];
                    end
                    else if((h_cnt >= PaH0 && h_cnt < PaH1)||(h_cnt >= PaH2 && h_cnt < PaH3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lra[0];
                    end
                    else if(h_cnt >= PbH1 && h_cnt < PbH2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lta[0];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(v_cnt < P0V3) begin
                    if(h_cnt >= P0H0 && h_cnt < P0H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lpa[15];
                    end
                    else if(h_cnt >= P1H0 && h_cnt < P1H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lra[15];
                    end
                    else if(h_cnt >= P2H0 && h_cnt < P2H2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lea[15];
                    end
                    else if(h_cnt >= P3H0 && h_cnt < P3H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lsa[15];
                    end
                    else if(h_cnt >= P4H0 && h_cnt < P4H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lsa[15];
                    end
                    else if(h_cnt >= P5H1 && h_cnt < P5H2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lta[0];
                    end
                    else if((h_cnt >= P6H0 && h_cnt < P6H1)||(h_cnt >= P6H2 && h_cnt < P6H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_loa[0];
                    end
                    else if(h_cnt >= P7H0 && h_cnt < P7H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lsa[0];
                    end
                    else if(h_cnt >= P8H1 && h_cnt < P8H2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lta[0];
                    end
                    else if(h_cnt >= P9H0 && h_cnt < P9H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_laa[0];
                    end
                    else if(h_cnt >= PaH0 && h_cnt < PaH3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lra[0];
                    end
                    else if(h_cnt >= PbH1 && h_cnt < PbH2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lta[0];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(v_cnt < P0V4) begin
                    if(h_cnt >= P0H0 && h_cnt < P0H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lpa[4];
                    end
                    else if((h_cnt >= P1H0 && h_cnt < P1H1)||(h_cnt >= P1H1a && h_cnt < P1H2)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lra[4];
                    end
                    else if(h_cnt >= P2H0 && h_cnt < P2H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lea[4];
                    end
                    else if(h_cnt >= P3H2 && h_cnt < P3H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lsa[2];
                    end
                    else if(h_cnt >= P4H2 && h_cnt < P4H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lsa[2];
                    end
                    else if(h_cnt >= P5H1 && h_cnt < P5H2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lta[0];
                    end
                    else if((h_cnt >= P6H0 && h_cnt < P6H1)||(h_cnt >= P6H2 && h_cnt < P6H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_loa[0];
                    end
                    else if(h_cnt >= P7H2 && h_cnt < P7H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lsa[0];
                    end
                    else if(h_cnt >= P8H1 && h_cnt < P8H2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lta[0];
                    end
                    else if((h_cnt >= P9H0 && h_cnt < P9H1)||(h_cnt >= P9H2 && h_cnt < P9H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_laa[0];
                    end
                    else if((h_cnt >= PaH0 && h_cnt < PaH1)||(h_cnt >= PaH1a && h_cnt < PaH2)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lra[0];
                    end
                    else if(h_cnt >= PbH1 && h_cnt < PbH2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lta[0];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(v_cnt < P0V5) begin
                    if(h_cnt >= P0H0 && h_cnt < P0H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lpa[4];
                    end
                    else if((h_cnt >= P1H0 && h_cnt < P1H1)||(h_cnt >= P1H1a && h_cnt < P1H2)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lra[4];
                    end
                    else if(h_cnt >= P2H0 && h_cnt < P2H2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lea[3];
                    end
                    else if(h_cnt >= P3H0 && h_cnt < P3H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lsa[3];
                    end
                    else if(h_cnt >= P4H0 && h_cnt < P4H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lsa[3];
                    end
                    else if(h_cnt >= P5H1 && h_cnt < P5H2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lta[0];
                    end
                    else if(h_cnt >= P6H0 && h_cnt < P6H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_loa[0];
                    end
                    else if(h_cnt >= P7H0 && h_cnt < P7H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lsa[0];
                    end
                    else if(h_cnt >= P8H1 && h_cnt < P8H2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lta[0];
                    end
                    else if((h_cnt >= P9H0 && h_cnt < P9H1)||(h_cnt >= P9H2 && h_cnt < P9H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_laa[0];
                    end
                    else if((h_cnt >= PaH0 && h_cnt < PaH1)||(h_cnt >= PaH1a && h_cnt < PaH2)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lra[0];
                    end
                    else if(h_cnt >= PbH1 && h_cnt < PbH2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lta[0];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else begin
                    {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
                 
            end
            `b_rst: begin
                {vgaRed, vgaGreen, vgaBlue} = backgrond;
            end
            `b_play: begin
                if(v_cnt < DCV0) begin
                    {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
                else if(v_cnt < DCV1) begin
                    if(h_cnt >= DCH0 && h_cnt < DCH3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[0];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(v_cnt < DCV2) begin
                    if(h_cnt >= DCH0 && h_cnt < DCH1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[5];
                    end
                    else if(h_cnt >= DCH2 && h_cnt < DCH3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[1];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(v_cnt < DCV3) begin
                   if(h_cnt >= DCH0 && h_cnt < DCH1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[7];
                   end
                   else if(h_cnt >= DCH1 && h_cnt < DCH2) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[6];
                    end
                    else if(h_cnt >= DCH2 && h_cnt < DCH3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[8];
                   end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(v_cnt < DCV4) begin
                    if(h_cnt >= DCH0 && h_cnt < DCH1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[4];
                    end
                    else if(h_cnt >= DCH2 && h_cnt < DCH3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[2];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(v_cnt < DCV5) begin
                    if(h_cnt >= DCH0 && h_cnt < DCH3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[3];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else begin
                    {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
            end
            `stage1, `stage2, `stage3, `pmode: begin
                
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
                        {vgaRed, vgaGreen, vgaBlue} = seg_ls[15];
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
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[15];
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
                        {vgaRed, vgaGreen, vgaBlue} = seg_lr[15];
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
                        {vgaRed, vgaGreen, vgaBlue} = seg_le[15];
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
                        {vgaRed, vgaGreen, vgaBlue} = seg_sl[7];
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
                         {vgaRed, vgaGreen, vgaBlue} = seg_sl[8];
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
                        {vgaRed, vgaGreen, vgaBlue} = seg_sr[7];
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
                        {vgaRed, vgaGreen, vgaBlue} = seg_sr[8];
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
                        {vgaRed, vgaGreen, vgaBlue} = seg_lt[15];
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
                        {vgaRed, vgaGreen, vgaBlue} = seg_li[15];
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
                        {vgaRed, vgaGreen, vgaBlue} = seg_le[15];
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
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt1[7];
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
                         {vgaRed, vgaGreen, vgaBlue} = seg_cnt1[8];
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
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[7];
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
                        {vgaRed, vgaGreen, vgaBlue} = seg_cnt0[8];
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
            `win: begin
                if(v_cnt < F0V0) begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hfd0;
                end
                else if(v_cnt < F0V1) begin
                    if((h_cnt >= Y0H0 && h_cnt < Y0H1)||(h_cnt >= Y0H2 && h_cnt < Y0H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                    end
                    else if(h_cnt >= Y1H0 && h_cnt < Y1H3)begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                    end
                    else if((h_cnt >= Y2H0 && h_cnt < Y2H1)||(h_cnt >= Y2H2 && h_cnt < Y2H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                    end
                    else if(h_cnt >= F0H0 && h_cnt < F0H3)begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lp[0];
                    end
                    else if(h_cnt >= F1H0 && h_cnt < F1H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_la[0];
                    end
                    else if(h_cnt >= F2H0 && h_cnt < F2H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ls[0];
                    end
                    else if(h_cnt >= F3H0 && h_cnt < F3H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ls[0];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfd0;
                    end
                end
                else if(v_cnt < F0V2) begin
                    if((h_cnt >= Y0H0 && h_cnt < Y0H1)||(h_cnt >= Y0H2 && h_cnt < Y0H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                    end
                    else if((h_cnt >= Y1H0 && h_cnt < Y1H1)||(h_cnt >= Y1H2 && h_cnt < Y1H3))begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                    end
                    else if((h_cnt >= Y2H0 && h_cnt < Y2H1)||(h_cnt >= Y2H2 && h_cnt < Y2H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                    end
                    else if((h_cnt >= F0H0 && h_cnt < F0H1)||(h_cnt >= F0H2 && h_cnt <F0H3))begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lp[5];
                    end
                    else if((h_cnt >= F1H0 && h_cnt < F1H1)||(h_cnt >= F1H2 && h_cnt <F1H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_la[5];
                    end
                    else if(h_cnt >= F2H0 && h_cnt < F2H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ls[5];
                    end
                    else if(h_cnt >= F3H0 && h_cnt < F3H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ls[5];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfd0;
                    end
                end
                else if(v_cnt < F0V3) begin
                    if(h_cnt >= Y0H0 && h_cnt < Y0H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                    end
                    else if((h_cnt >= Y1H0 && h_cnt < Y1H1)||(h_cnt >= Y1H2 && h_cnt < Y1H3))begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                    end
                    else if((h_cnt >= Y2H0 && h_cnt < Y2H1)||(h_cnt >= Y2H2 && h_cnt < Y2H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                    end
                    else if(h_cnt >= F0H0 && h_cnt < F0H3)begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lp[0];
                    end
                    else if(h_cnt >= F1H0 && h_cnt < F1H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_la[0];
                    end
                    else if(h_cnt >= F2H0 && h_cnt < F2H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ls[0];
                    end
                    else if(h_cnt >= F3H0 && h_cnt < F3H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ls[0];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfd0;
                    end
                end
                else if(v_cnt < F0V4) begin
                    if(h_cnt >= Y0H2 && h_cnt < Y0H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                    end
                    else if((h_cnt >= Y1H0 && h_cnt < Y1H1)||(h_cnt >= Y1H2 && h_cnt < Y1H3))begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                    end
                    else if((h_cnt >= Y2H0 && h_cnt < Y2H1)||(h_cnt >= Y2H2 && h_cnt < Y2H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                    end
                    else if(h_cnt >= F0H0 && h_cnt < F0H1)begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lp[5];
                    end
                    else if((h_cnt >= F1H0 && h_cnt < F1H1)||(h_cnt >= F1H2 && h_cnt <F1H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_la[5];
                    end
                    else if(h_cnt >= F2H2 && h_cnt < F2H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ls[5];
                    end
                    else if(h_cnt >= F3H2 && h_cnt < F3H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ls[5];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfd0;
                    end
                end
                else if(v_cnt < F0V5) begin
                    if(h_cnt >= Y0H0 && h_cnt < Y0H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                    end
                    else if(h_cnt >= Y1H0 && h_cnt < Y1H3)begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                    end
                    else if(h_cnt >= Y2H0 && h_cnt < Y2H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                    end
                    else if(h_cnt >= F0H0 && h_cnt < F0H1)begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lp[5];
                    end
                    else if((h_cnt >= F1H0 && h_cnt < F1H1)||(h_cnt >= F1H2 && h_cnt <F1H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_la[5];
                    end
                    else if(h_cnt >= F2H0 && h_cnt < F2H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ls[5];
                    end
                    else if(h_cnt >= F3H0 && h_cnt < F3H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ls[5];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfd0;
                    end
                end
                else begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hfd0;
                end

            end
            `lose: begin
                if(v_cnt < F0V0) begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                end
                else if(v_cnt < F0V1) begin
                    if((h_cnt >= Y0H0 && h_cnt < Y0H1)||(h_cnt >= Y0H2 && h_cnt < Y0H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                    end
                    else if(h_cnt >= Y1H0 && h_cnt < Y1H3)begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                    end
                    else if((h_cnt >= Y2H0 && h_cnt < Y2H1)||(h_cnt >= Y2H2 && h_cnt < Y2H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                    end
                    else if(h_cnt >= F0H0 && h_cnt < F0H1)begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ll[5];
                    end
                    else if(h_cnt >= F1H0 && h_cnt < F1H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lo[0];
                    end
                    else if(h_cnt >= F2H0 && h_cnt < F2H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ls[0];
                    end
                    else if(h_cnt >= F3H0 && h_cnt < F3H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_le[0];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                    end
                end
                else if(v_cnt < F0V2) begin
                    if((h_cnt >= Y0H0 && h_cnt < Y0H1)||(h_cnt >= Y0H2 && h_cnt < Y0H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                    end
                    else if((h_cnt >= Y1H0 && h_cnt < Y1H1)||(h_cnt >= Y1H2 && h_cnt < Y1H3))begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                    end
                    else if((h_cnt >= Y2H0 && h_cnt < Y2H1)||(h_cnt >= Y2H2 && h_cnt < Y2H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                    end
                    else if(h_cnt >= F0H0 && h_cnt < F0H1)begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ll[5];
                    end
                    else if((h_cnt >= F1H0 && h_cnt < F1H1)||(h_cnt >= F1H2 && h_cnt <F1H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lo[5];
                    end
                    else if(h_cnt >= F2H0 && h_cnt < F2H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ls[5];
                    end
                    else if(h_cnt >= F3H0 && h_cnt < F3H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_le[5];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                    end
                end
                else if(v_cnt < F0V3) begin
                    if(h_cnt >= Y0H0 && h_cnt < Y0H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                    end
                    else if((h_cnt >= Y1H0 && h_cnt < Y1H1)||(h_cnt >= Y1H2 && h_cnt < Y1H3))begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                    end
                    else if((h_cnt >= Y2H0 && h_cnt < Y2H1)||(h_cnt >= Y2H2 && h_cnt < Y2H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                    end
                    else if(h_cnt >= F0H0 && h_cnt < F0H1)begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ll[5];
                    end
                    else if((h_cnt >= F1H0 && h_cnt < F1H1)||(h_cnt >= F1H2 && h_cnt <F1H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lo[0];
                    end
                    else if(h_cnt >= F2H0 && h_cnt < F2H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ls[0];
                    end
                    else if(h_cnt >= F3H0 && h_cnt < F3H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_le[0];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                    end
                end
                else if(v_cnt < F0V4) begin
                    if(h_cnt >= Y0H2 && h_cnt < Y0H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                    end
                    else if((h_cnt >= Y1H0 && h_cnt < Y1H1)||(h_cnt >= Y1H2 && h_cnt < Y1H3))begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                    end
                    else if((h_cnt >= Y2H0 && h_cnt < Y2H1)||(h_cnt >= Y2H2 && h_cnt < Y2H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                    end
                    else if(h_cnt >= F0H0 && h_cnt < F0H1)begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ll[4];
                    end
                    else if((h_cnt >= F1H0 && h_cnt < F1H1)||(h_cnt >= F1H2 && h_cnt <F1H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lo[5];
                    end
                    else if(h_cnt >= F2H2 && h_cnt < F2H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ls[2];
                    end
                    else if(h_cnt >= F3H0 && h_cnt < F3H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_le[4];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                    end
                end
                else if(v_cnt < F0V5) begin
                    if(h_cnt >= Y0H0 && h_cnt < Y0H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                    end
                    else if(h_cnt >= Y1H0 && h_cnt < Y1H3)begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                    end
                    else if(h_cnt >= Y2H0 && h_cnt < Y2H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                    end
                    else if(h_cnt >= F0H0 && h_cnt < F0H3)begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ll[3];
                    end
                    else if(h_cnt >= F1H0 && h_cnt < F1H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lo[3];
                    end
                    else if(h_cnt >= F2H0 && h_cnt < F2H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_ls[3];
                    end
                    else if(h_cnt >= F3H0 && h_cnt < F3H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_le[3];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                    end
                end
                else begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                end
            end
            `go: begin
                if(v_cnt < G0V0) begin
                    {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
                else if(v_cnt < G0V1) begin
                    if(h_cnt >= G0H0 && h_cnt < G0H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lg[0];
                    end
                    else if(h_cnt >= G1H0 && h_cnt < G1H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lo[0];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(v_cnt < G0V2) begin
                    if(h_cnt >= G0H0 && h_cnt < G0H1) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lg[0];
                    end
                    else if((h_cnt >= G1H0 && h_cnt < G1H1)||(h_cnt >= G1H2 && h_cnt < G1H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lo[0];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(v_cnt < G0V3) begin
                    if((h_cnt >= G0H0 && h_cnt < G0H1)||(h_cnt >= G0H1a && h_cnt < G0H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lg[0];
                    end
                    else if((h_cnt >= G1H0 && h_cnt < G1H1)||(h_cnt >= G1H2 && h_cnt < G1H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lo[0];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(v_cnt < G0V4) begin
                    if((h_cnt >= G0H0 && h_cnt < G0H1)||(h_cnt >= G0H2 && h_cnt < G0H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lg[0];
                    end
                    else if((h_cnt >= G1H0 && h_cnt < G1H1)||(h_cnt >= G1H2 && h_cnt < G1H3)) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lo[0];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else if(v_cnt < G0V5) begin
                    if(h_cnt >= G0H0 && h_cnt < G0H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lg[0];
                    end
                    else if(h_cnt >= G1H0 && h_cnt < G1H3) begin
                        {vgaRed, vgaGreen, vgaBlue} = seg_lo[0];
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = backgrond;
                    end
                end
                else begin
                    {vgaRed, vgaGreen, vgaBlue} = backgrond;
                end
            end
            `compete: begin
                {vgaRed, vgaGreen, vgaBlue} = backgrond;
            end
            `wait_slave: begin
                {vgaRed, vgaGreen, vgaBlue} = backgrond;
            end
            default: begin
                {vgaRed, vgaGreen, vgaBlue} = backgrond;
            end 
            endcase
        end 
    end

endmodule