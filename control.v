module control(clk, SW7, BTN1, repeatRst,infail, insuccess, endOfShow, BombSwitch, random, showing, start, startInput, rst_n, rst_p);

input clk;
input SW7;		//总开关
input BTN1;		//游戏开始开关
input repeatRst;	//游戏结束后自动再次开始
input infail;		//在fail为1时关闭BombSwitch模块和20秒倒计时模块
input insuccess;	//在success为1时关闭BombSwitch模块和20秒倒计时模块
input endOfShow;	//结束5s密码显示

output reg BombSwitch;		//炸弹点阵模块的显示控制
output reg[4:0] random;		//产生随机数
output reg showing;			//密码显示模块的显示控制
output reg start;				//20s倒计时模块的显示控制
output reg startInput;		//密码输入验证模块的显示控制
output reg rst_p=0;
output reg rst_n=1;

reg[4:0] tt;
reg Rst=0;
reg endRst; 

always@(posedge clk)
begin
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


	if(SW7==1) begin
	
			//重启重置模块
			if(repeatRst==1) begin
				Rst=0;
				endRst=0;
			end
	
			
			
			
			
			if(infail==0) begin BombSwitch=1;		//总开关打开，显示炸弹示意图
							  if(endOfShow==1) startInput=1;		//如果5s展示密码结束，开始允许密码输入验证
							  end
			else begin 						   //拆弹失败时关闭炸弹示意图和20s倒计时和密码输入验证
				BombSwitch=0;
				start=0;
				startInput=0;
			end
			
			if(insuccess==1) begin			//拆弹成功时关闭炸弹示意图和20s倒计时和密码输入验证
				BombSwitch=0;
				start=0;
				startInput=0;
			end
			
			
			
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
			//关闭前重置
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
	end
	
	

end


endmodule 