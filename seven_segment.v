// seven segment and display

module s_segment(clk, rst, a0, a1, a2, a3, out, an);
input clk, rst;
input [3:0] a0, a1, a2, a3;
output reg [3:0] out;
output reg [3:0] an;
wire [3:0] next_an;

always@(posedge clk) begin
    if(rst == 1'b1) begin
        an <= 4'b1110;
    end
    else begin
        an <= next_an;
    end
end

assign next_an = {an[2:0], an[3]};

always@(*) begin
    case(an)
        4'b1110: out = a0;
        4'b1101: out = a1;
        4'b1011: out = a2;
        4'b0111: out = a3;
        default: out = 4'd8; 
    endcase
end

endmodule 

module sevensegment(num, D_ss);
input [3:0] num;
output reg[6:0] D_ss;

always@(*) begin
    case (num)
        4'd0: D_ss = 7'b1000000; // 0
        4'd1: D_ss = 7'b1111001; // 1
        4'd2: D_ss = 7'b0100100; // 2
        4'd3: D_ss = 7'b0110000; // 3
        4'd4: D_ss = 7'b0011001; // 4 
        4'd5: D_ss = 7'b0010010; // 5
        4'd6: D_ss = 7'b0000010; // 6
        4'd7: D_ss = 7'b1111000; // 7
        4'd8: D_ss = 7'b0000000; // 8
        4'd9: D_ss = 7'b0010000; // 9
        4'd10: D_ss = 7'b0111111; // -
        4'd11: D_ss = 7'b1111111; // empty
        default: D_ss = 7'b0000000; // 8
    endcase
end

endmodule



