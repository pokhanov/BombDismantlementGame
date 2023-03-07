module Show_password(LD, rst, showing, endOfShow, clk, psw);
input [6:0] psw;
input showing;
input rst;
input clk;
output reg[6:0] LD;
output reg endOfShow;

reg[15:0] tt;

always@(posedge clk)
begin
	if(rst==1) begin
					tt=0;
					LD=7'b0000000;
				  end 
	else if(showing)
		if(tt==499)
		begin
			LD=7'b0000000;
			endOfShow=1;
		end
		else begin
			LD = {LD [6:0], psw[6:0]};
			endOfShow=0;
			tt = tt+1;
		end
	else LD=7'b0000000;
end

endmodule
