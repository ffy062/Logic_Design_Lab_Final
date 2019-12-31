module playctrl #(parameter BEATLEAGTH = 4) (clk, play, loop, rst, ibeat);
input clk, rst, loop, play;
output reg [7:0] ibeat;


always @(posedge clk, posedge rst, posedge play) begin
	if (rst)
		ibeat <= BEATLEAGTH;
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