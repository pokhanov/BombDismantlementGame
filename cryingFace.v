module cryingFace(rst_n ,clk, fail, hang, red, beep,repeatRst);
input rst_n;
input clk;
input fail;		//控制该模块开始运行
output reg[7:0] hang, red;
output reg beep;		//输出给蜂鸣器发出较低沉声音的频率信号
output reg repeatRst;
reg[2:0] s1;
reg [5:0] tt;
reg [24:0] endtime;

always@(posedge clk or negedge rst_n)	//时钟上升沿触发
begin

	if(rst_n==0) begin
	endtime<=0;
	tt<=0;
	s1<=0;
	repeatRst<=0;
	hang=8'b11111111;
	red=8'b00000000;
	end

	
	else if(fail==1) begin
	
	
	if(endtime==500) begin			//记得改回2499,显示五秒
	repeatRst=1;		//被置1后，整个游戏重置，fail会回到0，哭脸点阵自动消失
	end
	else endtime=endtime+1;
	
	if(tt==10) begin		//记得改回1000
						beep=~beep;
						tt=0;
						
					 end
	 else tt=tt+1;
	
    if(s1==7) s1=0;else s1=s1+1;		//显示哭脸>^<
			case(s1)
			0:begin hang=8'b01111111;red=8'b10000001;end	
			1:begin hang=8'b10111111;red=8'b01000010;end
			2:begin hang=8'b11011111;red=8'b00100100;end
			3:begin hang=8'b11101111;red=8'b01000010;end
			4:begin hang=8'b11110111;red=8'b10000001;end	
			5:begin hang=8'b11111011;red=8'b00011000;end
			6:begin hang=8'b11111101;red=8'b00100100;end
			7:begin hang=8'b11111110;red=8'b01000010;end
			default:hang=8'b11111111;
			endcase; 
			
	end	

end


endmodule