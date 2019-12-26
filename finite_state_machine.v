// finite state machine and score scounter

`define rst 3'd0 
`define b_rst 3'd1
`define b_play 3'd2
`define play 3'd3
`define finish 3'd4 


module score_counter(clk, goal, dis_score, score0, score1);
input clk, goal, dis_score;
output reg [3:0] score0, score1;
reg [3:0] next_score0, next_score1;

always@(posedge clk) begin
    if(dis_score == 1'b0) begin
        score0 <= 4'd0;
        score1 <= 4'd0;
    end
    else begin
        score0 <= next_score0;
        score1 <= next_score1;
    end
end

always @ (*) begin
    if(goal == 1'b1) begin
        next_score0 = (score0 == 4'd9)? 4'd0 : score0 + 4'd1;
        next_score1 = (score0 == 4'd9)? score1 + 4'd1 : score1;
    end
    else begin
        next_score0 = score0;
        next_score1 = score1;
    end
end

endmodule



module fsm(clk, rst, start, goal, stop, dig0, dig1, dig2, dig3);
input clk, rst, start, goal, stop;
output reg [3:0] dig0, dig1, dig2, dig3;
reg [2:0] state, n_state;
reg [3:0] cnt_d0, cnt_d1, n_cnt_d0, n_cnt_d1;
wire [3:0] score0, score1;
wire en_cnt, dis_score, en_goal;
reg cnt_start, sp;

always@ (posedge clk) begin
    state <= n_state;
end

always@ (posedge clk) begin
    cnt_d0 <= n_cnt_d0;
    cnt_d1 <= n_cnt_d1;
end

always@(*) begin
    if(rst == 1'b1) begin
        n_state = `b_rst;
    end
    else begin
        case(state)
            `rst: n_state = (start == 1'b1)? `b_play : `rst;
            `b_rst: n_state = (cnt_d0 == 4'd0)? `rst : `b_rst;
            `b_play: n_state = (cnt_d0 == 4'd5)? `play : `b_play;
            `play: n_state = (cnt_d1 == 4'd0 && cnt_d0 == 4'd0)? `finish : `play;
            `finish: n_state = (start == 1'b1)? `b_play : `finish;
            default: n_state = `rst;
        endcase
    end
end

always@(posedge clk) begin
    if(rst == 1'b1) begin
        sp <= 1'b0;
    end
    else begin
        sp <= (stop == 1'b1 && state == `play)? ~sp : sp;
    end
end
assign dis_score = (state == `play || state == `finish)? 1'b1 : 1'b0;
assign en_goal = (state == `play && goal == 1'b1 && sp == 1'b0)? 1'b1 : 1'b0;

counter one_sec(.clk(clk), .start(cnt_start), .stop(sp), .out(en_cnt));
score_counter sc(.clk(clk), .goal(en_goal), .dis_score(dis_score), .score0(score0), .score1(score1));

always@(*) begin
    if(rst == 1'b1) begin
        n_cnt_d0 = 4'd1;
        n_cnt_d1 = 4'd0;
        cnt_start = 1'b1;
    end
    else begin
        if(start == 1'b1 && state != `play) begin
            n_cnt_d0 = 4'd3;
            n_cnt_d1 = 4'd0;
            cnt_start = 1'b1;
        end
        else begin
            if(en_cnt == 1'b1) begin
                if(cnt_d0 == 4'd1 && state == `b_play) begin
                    n_cnt_d0 = 4'd5;
                    n_cnt_d1 = 4'd1;
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
        `play: begin
                dig0 = score0;
                dig1 = score1;
                dig2 = cnt_d0;
                dig3 = cnt_d1;
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

