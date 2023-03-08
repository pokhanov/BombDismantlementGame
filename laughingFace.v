module laughingFace(success, clk, hang, gre, beep);
input success;
input clk;
output reg[7:0] hang, gre;
output reg beep;
reg[2:0] s1;
reg[15:0] tt;

always@(posedge clk)	//时钟上升沿触发
begin
	if(success==1) begin
		
		if(tt==10) begin beep=~beep;
							  tt=0;
					  end
		else tt=tt+1;

    if(s1==7) s1=0;else s1=s1+1;
			case(s1)
			0:begin hang=8'b01111111;gre=8'b00000000;end	//笑脸
			1:begin hang=8'b10111111;gre=8'b01100110;end
			2:begin hang=8'b11011111;gre=8'b01100110;end
			3:begin hang=8'b11101111;gre=8'b01100110;end
			4:begin hang=8'b11110111;gre=8'b00000000;end	
			5:begin hang=8'b11111011;gre=8'b01000010;end
			6:begin hang=8'b11111101;gre=8'b00100100;end
			7:begin hang=8'b11111110;gre=8'b00011000;end
			default:hang=8'b11111111;
			endcase;
			
	end
	
	else begin hang=8'b11111111;
				  gre =8'b00000000;
		  end
			
end


endmodule