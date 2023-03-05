module cryingFace(clk, hang, red);
input clk;
output reg[7:0] hang, red;
reg[2:0] s1;

always@(posedge clk)	//时钟上升沿触发
begin
    if(s1==7) s1=0;else s1=s1+1;
			case(s1)
			0:begin hang=8'b01111111;red=8'b10000001;end	//哭脸>^<
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


endmodule