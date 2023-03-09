module zhadan_dianzhen(rst, start, BombSwitch, clk, hang, red, gre, fail);
input start;	//引线开始缩短信号	
input BombSwitch;		//总开关，为0时不显示图像，为1时显示。	
input clk;		//时钟频率。因为电脑无法进行太长时间的仿真，所以仿真时周期调得较小
output reg[7:0]hang,	//行扫描信号
					red,  //控制红色发光二极管列
					gre;  //控制绿色发光二极管列
output reg fail=0;		//输出信号，表示拆弹失败

input rst;		//复位信号

reg[2:0] s1;	//s1取值0~7，在一个图像中实现动态扫描

reg clk_1hz;	//引信熄灭一格的时钟频率
reg[15:0] tt;
reg[4:0] s2;	//s2取值0~4，表示引信当前熄灭了几行



always@(posedge clk, posedge rst)			//时钟上升沿触发
begin
if(rst==1)
	 begin s1=0;
	 gre=8'b00000000;
	 red=8'b00000000;
	 hang=8'b11111111;
	 tt=0;
	 end
else if(BombSwitch==1)				//在BombSwitch为1的情况下才显示
begin
	
	 
	
	 
    if(tt==49) begin tt=0;
							  if(start==1)clk_1hz=~clk_1hz;		//在start==1的情况下才改变s2开始熄灭引信
					  end 												//定义clk_1hz，clk2500次上升沿信号后引信熄灭一格
	 else tt=tt+1;
	 
    if(s1==7) s1=0;else s1=s1+1;
    
        case(s2)
        0:begin
			case(s1)
			0:begin hang=8'b01111111;red=8'b00011000;gre=8'b00011000;end	//0~3行引信部分，绿色和红色同时亮，显示为黄
			1:begin hang=8'b10111111;red=8'b00011000;gre=8'b00011000;end
			2:begin hang=8'b11011111;red=8'b00011000;gre=8'b00011000;end
			3:begin hang=8'b11101111;red=8'b00011000;gre=8'b00011000;end
			4:begin hang=8'b11110111;red=8'b00011000;gre=8'b00000000;end	//4~7行炸弹部分，显示为红
			5:begin hang=8'b11111011;red=8'b00100100;gre=8'b00000000;end
			6:begin hang=8'b11111101;red=8'b00100100;gre=8'b00000000;end
			7:begin hang=8'b11111110;red=8'b00011000;gre=8'b00000000;end
			default:hang=8'b11111111;
			endcase;
        end
        1:begin
        case(s1)
        0:begin hang=8'b01111111;red=8'b00000000;gre=8'b00000000;end		//引信熄灭一行
        1:begin hang=8'b10111111;red=8'b00011000;gre=8'b00011000;end
        2:begin hang=8'b11011111;red=8'b00011000;gre=8'b00011000;end
        3:begin hang=8'b11101111;red=8'b00011000;gre=8'b00011000;end
        4:begin hang=8'b11110111;red=8'b00011000;gre=8'b00000000;end
        5:begin hang=8'b11111011;red=8'b00100100;gre=8'b00000000;end
        6:begin hang=8'b11111101;red=8'b00100100;gre=8'b00000000;end
        7:begin hang=8'b11111110;red=8'b00011000;gre=8'b00000000;end
        default:hang=8'b11111111;
        endcase;
        end
        2:begin
        case(s1)
        0:begin hang=8'b01111111;red=8'b00000000;gre=8'b00000000;end
        1:begin hang=8'b10111111;red=8'b00000000;gre=8'b00000000;end
        2:begin hang=8'b11011111;red=8'b00011000;gre=8'b00011000;end
        3:begin hang=8'b11101111;red=8'b00011000;gre=8'b00011000;end
        4:begin hang=8'b11110111;red=8'b00011000;gre=8'b00000000;end
        5:begin hang=8'b11111011;red=8'b00100100;gre=8'b00000000;end
        6:begin hang=8'b11111101;red=8'b00100100;gre=8'b00000000;end
        7:begin hang=8'b11111110;red=8'b00011000;gre=8'b00000000;end
        default:hang=8'b11111111;
        endcase;
        end
        3:begin
        case(s1)
         0:begin hang=8'b01111111;red=8'b00000000;gre=8'b00000000;end
        1:begin hang=8'b10111111;red=8'b00000000;gre=8'b00000000;end
        2:begin hang=8'b11011111;red=8'b00000000;gre=8'b00000000;end
        3:begin hang=8'b11101111;red=8'b00011000;gre=8'b00011000;end
        4:begin hang=8'b11110111;red=8'b00011000;gre=8'b00000000;end
        5:begin hang=8'b11111011;red=8'b00100100;gre=8'b00000000;end
        6:begin hang=8'b11111101;red=8'b00100100;gre=8'b00000000;end
        7:begin hang=8'b11111110;red=8'b00011000;gre=8'b00000000;end
        default:hang=8'b11111111;
        endcase;
        end
        4:begin
        case(s1)
         0:begin hang=8'b01111111;red=8'b00000000;gre=8'b00000000;end		//引信全部熄灭
        1:begin hang=8'b10111111;red=8'b00000000;gre=8'b00000000;end
        2:begin hang=8'b11011111;red=8'b00000000;gre=8'b00000000;end
        3:begin hang=8'b11101111;red=8'b00000000;gre=8'b00000000;end
        4:begin hang=8'b11110111;red=8'b00011000;gre=8'b00000000;end
        5:begin hang=8'b11111011;red=8'b00100100;gre=8'b00000000;end
        6:begin hang=8'b11111101;red=8'b00100100;gre=8'b00000000;end
        7:begin hang=8'b11111110;red=8'b00011000;gre=8'b00000000;end
        default:hang=8'b11111111;
        endcase;
        end
        
        default:hang=8'b11111111;
        endcase;
        
	
	end

	end

always@(posedge clk_1hz or posedge rst)
begin
	if(rst) begin s2=0;
					  fail=0;
			  end
   else if(s2==4) begin	s2=0;
								if(start==1)fail = 1;
						end
   else s2=s2+1;
end
	

endmodule