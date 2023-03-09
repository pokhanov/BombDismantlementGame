module pswInput_check(startInput, rst, clk, SW, psw, BTN6, LD, success);
input clk;				//时钟信号
input rst;				//复位信号，低电平有效
input startInput;		//开始可以输入密码
input [6:0] SW;		//拨码开关输入的信号
input [6:0] psw;		//已经设定好的正确密码
input BTN6;				//按下BTN6确认验证密码
output reg[6:0] LD;	//使发光二极管模块显示输入的密码
output reg success;	//输出信号，表明拆弹成功


always@(posedge clk, negedge rst)
begin
	if(rst==0) begin
						success=0;
						LD<=7'b0000000;
				  end
				  
	else if(startInput==1) begin
									LD={LD[6:0], SW[6:0]};
									if(BTN6==1) begin
													if(SW[6:0]==psw[6:0]) success=1;
												end
							  end

end

endmodule