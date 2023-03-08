module Show_password(LD, rst, showing, endOfShow, clk, psw, seg, cat);
input [6:0] psw;
input showing;
input rst;
input clk;
output reg[6:0] LD;
output reg[7:0] seg;
output reg endOfShow;
output reg cat = 8'b11111110;		//5秒倒计时，因为是个位数所以只用得到DISP0


reg clk_1hz;	
reg[15:0] tt;
reg[4:0] s2;

always@(posedge clk)
begin
	if(rst==1) begin
					tt=0;
					LD=7'b0000000;
				  end 
				  
	else if(showing)
	begin
	
	
		if(tt==109) begin tt=0;
								clk_1hz=~clk_1hz;	
						end 												
		else tt=tt+1;
		
		
		
	if(s2<5)
		begin
		     LD = {LD [6:0], psw[6:0]};
						 
			 case(5-s2)
				0: seg<=8'b00111111;
				1: seg<=8'b00000110;
				2: seg<=8'b01011011;
				3: seg<=8'b01001111;
				4: seg<=8'b01100110;
				5: seg<=8'b01101101;
				default: seg <=8'b00000000;
			endcase
			
		
		end
	else begin LD=7'b0000000;
				  seg <=8'b00000000;
		  end
	end
	
end

always@(posedge clk_1hz or posedge rst)
begin
	if(rst) begin s2=0;
					  endOfShow=0;
			  end
	else if(s2==4)
		begin
			endOfShow=1;
			s2=s2+1;
		end
   else s2=s2+1;
end

endmodule
