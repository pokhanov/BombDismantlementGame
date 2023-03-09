module random_password(
    input               rst_n,    //低电平有效复位信号
    input               clk,      //时钟信号
    input               load,  
	 input 		[4:0]		random,	 //每次输入不同的五位数
    input      [7:0]    seed,     
    output reg [7:0]    rand_num  //输出的随机数

);
reg [7:0]		cnt2;

		//控制随机结束时间，使随机数的值固定


always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
		begin
        rand_num    <=8'b0;
		  cnt2		  <=1'd0;
		end
    else if(load)
			begin
				rand_num <=seed;  
			end
    else if(cnt2<2499)
        begin
            rand_num[0] <= rand_num[7];
            rand_num[1] <= rand_num[0];
            rand_num[2] <= rand_num[1];
            rand_num[3] <= rand_num[2];
            rand_num[4] <= rand_num[3]^rand_num[7];
            rand_num[5] <= rand_num[4]^rand_num[7];
            rand_num[6] <= rand_num[5]^rand_num[7];
            rand_num[7] <= rand_num[6];
				if(rand_num[0]==1)cnt2 <= cnt2+random+2;
        end
end
endmodule