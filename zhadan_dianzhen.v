module zhadan_dianzhen(clk,hang,red,gre);
input clk;		//��̬ɨ���ʱ��Ƶ��
output reg[7:0]hang,red,gre;
reg[2:0] s1;	//s1ȡֵ0~7����һ��ͼ����ʵ�ֶ�̬ɨ��

reg clk_1hz;	//����Ϩ��һ���ʱ��Ƶ��
reg[15:0] tt;
reg[3:0] s2;	//s2ȡֵ0~4����ʾ���ŵ�ǰϨ���˼���

always@(posedge clk)	//ʱ�������ش���
begin
    if(tt==2499) begin tt=0;clk_1hz=~clk_1hz;end else tt=tt+1;
    if(s1==7) s1=0;else s1=s1+1;
    
        case(s2)
        0:begin
			case(s1)
			0:begin hang=8'b01111111;red=8'b00011000;gre=8'b00011000;end	//0~3�����Ų��֣���ɫ�ͺ�ɫͬʱ������ʾΪ��
			1:begin hang=8'b10111111;red=8'b00011000;gre=8'b00011000;end
			2:begin hang=8'b11011111;red=8'b00011000;gre=8'b00011000;end
			3:begin hang=8'b11101111;red=8'b00011000;gre=8'b00011000;end
			4:begin hang=8'b11110111;red=8'b00011000;gre=8'b00000000;end	//4~7��ը�����֣���ʾΪ��
			5:begin hang=8'b11111011;red=8'b00100100;gre=8'b00000000;end
			6:begin hang=8'b11111101;red=8'b00100100;gre=8'b00000000;end
			7:begin hang=8'b11111110;red=8'b00011000;gre=8'b00000000;end
			default:hang=8'b11111111;
			endcase;
        end
        1:begin
        case(s1)
        0:begin hang=8'b01111111;red=8'b00000000;gre=8'b00000000;end	//����Ϩ��һ��
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
         0:begin hang=8'b01111111;red=8'b00000000;gre=8'b00000000;end		//����ȫ��Ϩ��
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
   if(s2==4) s2=0;		//ѭ����д�걬ըͼ�����ڴ˴�����
   else s2=s2+1;
end
endmodule