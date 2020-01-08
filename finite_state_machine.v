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
`define go 4'd10
`define wait_slave 4'd11
`define compete 4'd12



module fsm(
    clk, 
    rst, start, stop, pmode, back,
    goal, sound, 
    s_start, s_goal, 
    dig0, dig1, dig2, dig3, c_state,
    digs0, digs1, 
    pmod1, pmod2, pmod4
    );

input clk;
input rst, start, stop, pmode, back;
input goal, sound;
input s_start, s_goal;
output reg [3:0] dig0, dig1, dig2, dig3;
output [3:0] digs0, digs1;
output reg [3:0] c_state;
output pmod1, pmod2, pmod4;

reg [3:0] state, n_state;
reg [3:0] cnt_d0, cnt_d1, n_cnt_d0, n_cnt_d1;
wire [3:0] score0, score1, scores0, scores1;
wire en_cnt, en_goal, cnt_play, s_rst;
wire en_sgoal, dis_sscore;
reg cnt_start, sp;
reg [2:0] stage, n_stage;


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

// DFF of stage
always@ (posedge clk) begin
    stage <= n_stage;
end



//always block to control stage

always@(*) begin
    case(state)
        `rst, `lose: begin
            n_stage = (start == 1'b1)? 3'd1 : 3'd0;
        end
        `stage1: begin
            n_stage = (score1 > 1 || (score1 == 1 && score0 >= 5))? 3'd2 : 3'd1;
        end
        `stage2: begin
            n_stage = (score1 >= 4 && score0 >= 0)? 3'd3 : 3'd2;
        end
        `stage3: begin
            n_stage = (score1 > 8 || (score1 == 8 && score0 >= 5))? 3'd4 : 3'd3;
        end
        `wait_slave: begin
            n_stage = 5;
        end
        default: begin
            n_stage = stage;
        end
    endcase
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
                        if(stop == 1'b1) begin
                            n_state = `wait_slave;
                        end
                        else begin
                            n_state = `rst;
                        end
                    end
                end
            end
            `b_rst: n_state = (cnt_d0 == 4'd0)? `rst : `b_rst;
            `b_play: n_state = (cnt_d0 == 4'd0)? `go : `b_play;
            `go: begin
                if(cnt_d1 != 0) begin
                    if(stage == 1) begin
                        n_state = `stage1;
                    end
                    else if(stage == 2) begin
                        n_state = `stage2;
                    end
                    else if(stage == 3) begin
                        n_state = `stage3;
                    end
                    else if(stage == 5) begin
                        n_state = `compete;
                    end
                    else begin
                        n_state = `rst;
                    end
                end
                else begin
                    n_state = `go;
                end
            end
            `stage1: begin
                if(cnt_d1 == 4'd0 && cnt_d0 == 4'd0) begin
                    if(stage == 2) begin
                        n_state = `win;
                    end
                    else begin
                        n_state = `lose;
                    end
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
            `stage2: begin
                if(cnt_d1 == 4'd0 && cnt_d0 == 4'd0) begin
                    if(stage == 3) begin
                        n_state = `win;
                    end
                    else begin
                        n_state = `lose;
                    end
                end
                else begin
                    if(back == 1'b1) begin
                        n_state = `rst;
                    end
                    else begin
                        n_state = `stage2;
                    end
                end
            end
            `stage3: begin
                if(cnt_d1 == 4'd0 && cnt_d0 == 4'd0) begin
                    if(stage == 4) begin
                        n_state = `win;
                    end
                    else begin
                        n_state = `lose;
                    end
                end
                else begin
                    if(back == 1'b1) begin
                        n_state = `rst;
                    end
                    else begin
                        n_state = `stage3;
                    end
                end
            end
            `pmode: n_state = (back == 1'b1)? `rst : `pmode;
            `win: begin
                if(start == 1'b1) begin
                    n_state = `b_play;
                end
                else begin
                    if(back == 1'b1) begin
                        n_state = `rst;
                    end
                    else begin
                        n_state = `win;
                    end
                end
            end
            `lose: begin
                if(start == 1'b1 || back == 1'b1) begin
                    n_state = `rst;
                end
                else begin
                    n_state = `lose;
                end
            end
            `wait_slave: begin
                if(s_start == 1'b0) begin
                    n_state = `b_play;
                end
                else begin
                    if(back == 1'b1) begin
                        n_state = `rst;
                    end
                    else begin
                        n_state = `wait_slave;
                    end
                end
            end
            `compete: begin
                n_state = `compete;
                if(back == 1'b1) begin
                    n_state = `rst;
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
assign dis_score = (state == `rst || state == `b_rst)? 1'b0 : 1'b1;
assign en_goal = ((state == `stage1 || state == `stage2 || state == `stage3 || state == `compete
        || state == `pmode) && goal == 1'b1 && sp == 1'b0)? 1'b1 : 1'b0;
assign cnt_play = (cnt_start == 1'b1 && n_state == `b_play && sound == 1)? 1'b1 : 1'b0;
assign s_rst = (state == `pmode && start == 1'b1)? 1'b1 : 1'b0;
assign en_sgoal = ((state == `compete) && s_goal == 1'b1)? 1'b1 : 1'b0;
assign dis_sscore = (state == `compete)? 1'b1 : 1'b0;

// module for 1 sec counter, currnet score to seven segment, audio top module
counter one_sec(.clk(clk), .start(cnt_start), .stop(sp), .out(en_cnt));
score_and_display sad(
    .clk(clk), .goal(en_goal), .rst(s_rst),
    .dis_score(dis_score), .score0(score0), .score1(score1)
    );

score_and_display s_sad(
    .clk(clk), .goal(en_sgoal), .rst(1'b0),
    .dis_score(dis_sscore), .score0(scores0), .score1(scores1)
    );
audio_top audio(
    .clk(clk), .rst(rst), .goal((en_goal||en_sgoal) & sound), 
    .cnt(cnt_play), .pmod_1(pmod1), .pmod_2(pmod2), .pmod_4(pmod4)
    );


// always block for count down signal
always@(*) begin
    if(rst == 1'b1) begin
        n_cnt_d0 = 4'd1;
        n_cnt_d1 = 4'd0;
        cnt_start = 1'b1;
    end
    else begin
        if(start == 1'b1 && state == `rst) begin
            n_cnt_d0 = 4'd3;
            n_cnt_d1 = 4'd0;
            cnt_start = 1'b1;
        end
        else if(state == `win || state == `wait_slave) begin
            n_cnt_d0 = 3;
            n_cnt_d1 = 0;
            cnt_start = 1;
        end
        else begin
            if(en_cnt == 1'b1) begin
                cnt_start = 1'b1;
                if(state == `stage1 ||state == `stage2 || state == `stage3
                    || state == `b_play || state == `b_rst) begin
                    n_cnt_d0 = (cnt_d0 == 4'd0)? 4'd9 : cnt_d0 - 1;
                    n_cnt_d1 = (cnt_d0 == 4'd0)? cnt_d1 - 1 : cnt_d1;
                end
                else begin
                        if(state == `go) begin
                            if(cnt_d0 == 9) begin
                                if(stage == 1) begin
                                    n_cnt_d0 = 5;
                                    n_cnt_d1 = 3;
                                end
                                else if(stage == 2) begin
                                    n_cnt_d0 = 5;
                                    n_cnt_d1 = 2;
                                end
                                else if(stage == 3) begin
                                    n_cnt_d0 = 0;
                                    n_cnt_d1 = 2;
                                end
                                else if(stage == 5) begin
                                    n_cnt_d0 = 0;
                                    n_cnt_d1 = 3;
                                end
                                else begin
                                    n_cnt_d0 = 0;
                                    n_cnt_d1 = 0;
                                end
                            end
                            else begin
                                n_cnt_d0 = (cnt_d0 == 4'd0)? 4'd9 : cnt_d0 - 1;
                                n_cnt_d1 = cnt_d1;
                            end
                        end
                        else begin
                            n_cnt_d0 = 0;
                            n_cnt_d1 = 0;
                        end
                end
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
        `b_play, `go: begin
                dig0 = 4'd11;
                dig1 = 4'd11;
                dig2 = cnt_d0;
                dig3 = 4'd11;
        end
        `stage1, `stage2, `stage3: begin
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
        `win, `lose: begin
            dig0 = {1'b0, stage};
            dig1 = 4'd11;
            dig2 = 4'd11;
            dig3 = 4'd11;
        end
        `finish: begin
                dig0 = score0;
                dig1 = score1;
                dig2 = 4'd10;
                dig3 = 4'd10;
        end
        `compete: begin
            dig0 = score0;
            dig1 = score1;
            dig2 = scores0;
            dig3 = scores1;
        end
        default: begin
            dig0 = 4'd0;
            dig1 = 4'd0;
            dig2 = 4'd10;
            dig3 = 4'd10;
        end
    endcase
end
assign digs0 = scores0;
assign digs1 = scores1;


endmodule

