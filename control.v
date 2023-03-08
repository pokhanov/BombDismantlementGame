module control(clk, SW7, BTN1, repeatRst, BombSwitch, random, showing, start, startInput, fail, success);

input clk;
input SW7;		//总开关
input BTN1;		//游戏开始开关
input repeatRst;	//游戏结束后自动再次开始

output reg BombSwitch;		//炸弹点阵模块的显示控制
output reg[4:0] random;		//产生随机数
output reg showing;			//密码显示模块的显示控制
output reg start;				//20s倒计时模块的显示控制
output reg startInput;		//密码输入验证模块的显示控制
output reg fail;				//哭脸模块的显示控制
output reg success;			//笑脸模块的显示控制

reg[4:0] tt;
reg rst_p;
reg rst_n;
reg Rst;
reg endRst; 

always@(posedge clk)
begin


	if(SW7==1) begin
	
			if(repeatRst==1) begin
				Rst=0;
				endRst=0;
			end
	
			//重置模块rst
			if(Rst==0) begin 
				rst_p=1;
				rst_n=0;
				Rst=1;
			end
			else begin
				rst_p=0;
				rst_n=1;
			end
			
			
			BombSwitch=1;		//总开关打开，显示炸弹示意图
			if(BTN1==1) begin
				if(tt==5'b11111)tt=0;
				else begin
					tt=tt+1;
					random={random[4:0], tt[4:0]};
					showing=1;
				end
			end
	end
	else begin		//总开关关闭，关掉所有显示模块
			//先重置一下！
		if(endRst==0) begin 
				rst_p=1;
				rst_n=0;
				endRst=1;
		end
		else begin
				rst_p=0;
				rst_n=1;
		end
			
		BombSwitch=0;
		showing=0;
		start=0;
		startInput=0;
		fail=0;
		success=0;
	end
	
	

end


endmodule 