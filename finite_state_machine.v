// finite state machine and score scounter

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



module fsm(
    clk, 
    rst, start, stop, pmode, back,
    goal, 
    dig0, dig1, dig2, dig3, c_state,
    pmod1, pmod2, pmod4
    );

input clk;
input rst, start, stop, pmode, back;
input goal;
output reg [3:0] dig0, dig1, dig2, dig3;
output reg [3:0] c_state;
output pmod1, pmod2, pmod4;

reg [3:0] state, n_state;
reg [3:0] cnt_d0, cnt_d1, n_cnt_d0, n_cnt_d1;
wire [3:0] score0, score1;
wire en_cnt, en_goal, cnt_play;
reg cnt_start, sp;


// DFF of state
always@ (posedge clk) begin
    state <= n_state;
    c_state <= state;
end


// DFF of output number
always@ (posedge clk) begin
    cnt_d0 <= n_cnt_d0;
    cnt_d1 <= n_cnt_d1;
end


// always block to control state
always@(*) begin
    if(rst == 1'b1) begin
        n_state = `b_rst;
    end
    else begin
        case(state)
            `rst: begin
                if(start == 1'b1) begin
                    n_state = `b_play;
                end
                else begin
                    if(pmode == 1'b1) begin
                        n_state = `pmode;
                    end
                    else begin
                        n_state = `rst;
                    end
                end
            end
            `b_rst: n_state = (cnt_d0 == 4'd0)? `rst : `b_rst;
            `b_play: n_state = (cnt_d0 == 4'd5)? `stage1 : `b_play;
            `stage1: begin
                if(cnt_d1 == 4'd0 && cnt_d0 == 4'd0) begin
                    n_state = `finish;
                end
                else begin
                    if(back == 1'b1) begin
                        n_state = `rst;
                    end
                    else begin
                        n_state = `stage1;
                    end
                end
            end
            `pmode: n_state = (back == 1'b1)? `rst : `pmode;
            `finish: begin
                if(start == 1'b1) begin
                    n_state = `b_play;
                end
                else begin
                    if(back == 1'b1) begin
                        n_state = `rst;
                    end
                    else begin
                        n_state = `finish;
                    end
                end
            end
            default: n_state = `rst;
        endcase
    end
end

// always block to control game play/ pause
always@(posedge clk) begin
    if(rst == 1'b1) begin
        sp <= 1'b0;
    end
    else begin
        sp <= (stop == 1'b1 && state == `stage1)? ~sp : sp;
    end
end


// signal for score display, valid goal, play count down sound
assign dis_score = (state == `stage1 || state == `finish || state == `pmode)? 1'b1 : 1'b0;
assign en_goal = ((state == `stage1 || state == `pmode) && goal == 1'b1
            && sp == 1'b0)? 1'b1 : 1'b0;
assign cnt_play = (cnt_start == 1'b1 && n_state == `b_play)? 1'b1 : 1'b0;

// module for 1 sec counter, currnet score to seven segment, audio top module
counter one_sec(.clk(clk), .start(cnt_start), .stop(sp), .out(en_cnt));
score_and_display sad(.clk(clk), .goal(en_goal), .dis_score(dis_score), .score0(score0), .score1(score1));
audio_top audio(.clk(clk), .rst(rst), .goal(en_goal), .cnt(cnt_play), .pmod_1(pmod1), .pmod_2(pmod2), .pmod_4(pmod4));


// always block for count down signal
always@(*) begin
    if(rst == 1'b1) begin
        n_cnt_d0 = 4'd1;
        n_cnt_d1 = 4'd0;
        cnt_start = 1'b1;
    end
    else begin
        if(start == 1'b1 && state != `stage1) begin
            n_cnt_d0 = 4'd3;
            n_cnt_d1 = 4'd0;
            cnt_start = 1'b1;
        end
        else begin
            if(en_cnt == 1'b1) begin
                if(cnt_d0 == 4'd1 && state == `b_play) begin
                    n_cnt_d0 = 4'd5;
                    n_cnt_d1 = 4'd3;
                end
                else begin
                    n_cnt_d0 = (cnt_d0 == 4'd0)? 4'd9 : cnt_d0 - 1;
                    n_cnt_d1 = (cnt_d0 == 4'd0)? cnt_d1 - 1 : cnt_d1;
                end
                cnt_start = 1'b1;
            end
            else begin
                n_cnt_d0 = cnt_d0;
                n_cnt_d1 = cnt_d1;
                cnt_start = 1'b0;    
            end
        end
    end
end


// always block to determine signal to display on seven segmnet
always@(*) begin
    case(state)
        `rst: begin
            dig0 = 4'd10;
            dig1 = 4'd10;
            dig2 = 4'd10;
            dig3 = 4'd10;
        end
        `b_rst: begin
                dig0 = 4'd8;
                dig1 = 4'd8;
                dig2 = 4'd8;
                dig3 = 4'd8;
        end
        `b_play: begin
                dig0 = 4'd11;
                dig1 = 4'd11;
                dig2 = cnt_d0;
                dig3 = 4'd11;
        end
        `stage1: begin
                dig0 = score0;
                dig1 = score1;
                dig2 = cnt_d0;
                dig3 = cnt_d1;
        end
        `pmode: begin
                dig0 = score0;
                dig1 = score1;
                dig2 = 4'd0;
                dig3 = 4'd0;
        end
        `finish: begin
                dig0 = score0;
                dig1 = score1;
                dig2 = 4'd10;
                dig3 = 4'd10;
        end
        default: begin
            dig0 = 4'd0;
            dig1 = 4'd0;
            dig2 = 4'd10;
            dig3 = 4'd10;
        end
    endcase
end


endmodule

