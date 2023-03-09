module CntDown20(start, success, cat, seg, clk, rst, s1, s2);
input rst;			//复位信号,低电平有效
input clk;			//时钟信号
input start;		//控制开始倒计时
input success;	//如果拆弹成功控制停止倒计时
output reg[7:0] cat;	//控制选择DISP0/DISP1，低电平有效
output reg[7:0] seg;		//控制数码管，高电平有效

reg clk_1hz;		//时钟分频
reg scan;			//扫描信号
reg[15:0] tt;
output reg[3:0] s2;		//记录十位数大小
output reg[3:0] s1;		//记录个位数大小

always@(posedge clk, negedge rst)
begin


	if(rst==0) begin
						tt<=0;
						
				  end
				  
				  
	else if(start) begin
							if(tt==29) begin clk_1hz=~clk_1hz;
													tt=0;		
											end
							else tt=tt+1;
							
							
							
							if(scan==0) scan=1;
							else scan=0;
							
							
							
							case(scan)
							0:begin cat=8'b11111110;
										case(s1) 
										0: seg<=8'b00111111;
										1: seg<=8'b00000110;
										2: seg<=8'b01011011;
										3: seg<=8'b01001111;
										4: seg<=8'b01100110;
										5: seg<=8'b01101101;
										6: seg<=8'b01111101;
										7: seg<=8'b00000111;
										8: seg<=8'b01111111;
										9: seg<=8'b01101111;
										default: seg<=8'b00000000;
										endcase
								end
										
							1:begin cat=8'b11111101;
										case(s2) 
										0: seg<=8'b00111111;
										1: seg<=8'b00000110;
										2: seg<=8'b01011011;
										3: seg<=8'b01001111;
										4: seg<=8'b01100110;
										5: seg<=8'b01101101;
										6: seg<=8'b01111101;
										7: seg<=8'b00000111;
										8: seg<=8'b01111111;
										9: seg<=8'b01101111;
										default: seg<=8'b00000000;
										endcase
								end
							endcase
						end
						
end

always@(posedge clk_1hz, negedge rst)
begin
	if(rst==0) begin
				  s2<=2;
				  s1<=0;
				  end
				  
	else if(start==1) begin
	
								if(s1==0) begin if(s2>0) begin
																 s2=s2-1;
																 s1=9;
																 end
													 else begin
															s1=-1;
															s2=-1;
															end
												end
												else s1=s1-1;
							 end
							 
	else begin s1<=0;
				  s2<=0;
		  end
end

endmodule 