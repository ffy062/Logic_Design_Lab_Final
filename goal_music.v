module goal_music(beatnum, tone);
input [7:0] beatnum;
output reg [31:0] tone;
always@(*) begin
    case(beatnum)
        8'd0 : tone = 32'd523;
        8'd1 : tone = 32'd523;
        8'd2 : tone = 32'd523 << 1;
        8'd3 : tone = 32'd523 << 1;
        default: tone = 32'd0;
    endcase
end

endmodule