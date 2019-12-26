// debounce and onepause

module debounce(clk, in, in_d);
input clk, in;
output in_d;
reg [6-1:0] DFF;

always@(posedge clk) begin
    DFF[5:1] <= DFF[4:0];
    DFF[0] <= in;
end
assign in_d = (DFF == 6'b111111)? 1'b1 : 1'b0;

endmodule

module one_pause(clk, in_d, in_o);
input clk, in_d;
output reg in_o;
reg in_delay;

always@(posedge clk) begin
    in_o <= (!in_delay) & in_d;
    in_delay <= in_d;
end

endmodule