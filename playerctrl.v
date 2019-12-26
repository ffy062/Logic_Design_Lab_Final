module playctrl (clk, play, loop, rst, ibeat);
input clk, rst, loop, rst;
output reg [7:0] beat;
parameter BEATLEAGTH = 4;

always @(posedge clk, posedge rst) begin
	if (rst)
		ibeat <= 4;
	else begin
        if(play == 1'b1) begin
            ibeat <= 0;
        end
        else begin
            if(ibeat < BEATLEAGTH) 
                ibeat <= ibeat + 1;
            else   
                ibeat <= (loop == 1'b1)? 0 : ibeat;
        end
    end
end

endmodule