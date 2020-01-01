
// clock and counter


//count for one second
module counter(clk, start, stop, out);
input clk, start, stop;
output out;
parameter n = 99999999;
reg [31:0] cnt;
wire [31:0]next_cnt;
// 32'd99999999 1sec

always@(posedge clk) begin
    if(start == 1'b1) begin
        cnt <= n;
    end
    else begin
        cnt <= (stop == 1'b0)? next_cnt : cnt;
    end
end
assign next_cnt = (cnt == 32'd0)? 32'd0 : cnt - 32'd1;
assign out = (cnt == 32'd0)? 1'b1 : 1'b0; 

endmodule


// press for 2 second
module long_press(clk, press, out);
input clk, press;
output out;
parameter n = 199999999;
reg [31:0] cnt;
// 32'd199999999 2sec

always@(posedge clk) begin
    if(press == 1'b1) begin
        cnt <= (cnt == 32'd0)? 32'd0 : cnt - 1;
    end
    else begin
        cnt <= n;
    end
end

assign out = (cnt == 32'd0)? 1'b1 : 1'b0; 

endmodule



module clock1Hz(clk, rst, nclk);
input clk, rst;
output nclk;
reg [30:0] cnt;
wire [30:0]next_cnt;
// 31'd99999999

always@(posedge clk) begin
    if(rst == 1'b1) begin
        cnt <= 31'd0;
    end
    else begin
        cnt <= next_cnt;
    end
end
assign next_cnt = (cnt == 31'd99999999)? 31'd0 : cnt + 31'd1;
assign nclk = (cnt > 31'd49999999)? 1'b1 : 1'b0; 

endmodule


// clock for debounce
module clock100Hz(clk, rst, nclk);
input clk, rst;
output nclk;
reg [20:0] cnt;
wire [20:0] next_cnt;
// 21'd999999

always@(posedge clk) begin
    if(rst == 1'b1) begin
        cnt <= 21'd0;
    end
    else begin
        cnt <= next_cnt;
    end
end
assign next_cnt = (cnt == 21'd999999)? 21'd0 : cnt + 21'd1;
assign nclk = (cnt > 21'd499999)? 1'b1 : 1'b0;

endmodule


// clock for seven segment
module clk_7seg(clk, rst, nclk);
input clk, rst;
output nclk;
reg [17:0] cnt;
wire [17:0] next_cnt;
// 
always@(posedge clk) begin
    if(rst == 1'b1) begin
        cnt <= 18'd0;
    end
    else begin
        cnt <= next_cnt;
    end
end
assign next_cnt = cnt + 18'd1;
assign nclk = cnt[17];

endmodule


// clock for VGA 
//resolution: 640*480
// count for 500*525*60(fps) = 25M (pixel/sec)
module clock_25MHz(clk, rst, nclk);
input clk, rst;
output nclk;

reg [1:0] num;
wire [1:0] n_num;

always@(posedge clk) begin
    if(rst == 1'b1) begin
        num <= 0;
    end
    else begin
        num <= n_num;
    end
end

assign n_num = num + 1'b1;
assign nclk = num[1];

endmodule
