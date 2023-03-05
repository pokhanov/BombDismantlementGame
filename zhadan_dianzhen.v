module zhadan_dianzhen(clk,hang,red,gre);
input clk;		//动态扫描的时钟频率
output reg[7:0]hang,red,gre;
reg[2:0] s1;	//s1取值0~7，在一个图像中实现动态扫描

reg clk_1hz;	//引信熄灭一格的时钟频率
reg[15:0] tt;
reg[3:0] s2;	//s2取值0~4，表示引信当前熄灭了几行

always@(posedge clk)	//时钟上升沿触发
begin
    if(tt==2499) begin tt=0;clk_1hz=~clk_1hz;end else tt=tt+1;
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
        0:begin hang=8'b01111111;red=8'b00000000;gre=8'b00000000;end	//引信熄灭一行
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

always@(posedge clk_1hz)
begin
   if(s2==4) s2=0;		//循环，写完爆炸图样后在此处更改
   else s2=s2+1;
end
endmodule