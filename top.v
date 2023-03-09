module top(clk, SW7, SW, BTN6, BTN1, LD, seg, cat, hang, red, gre, beep);

input clk;
input SW7;
input[6:0] SW;
input BTN6;
input BTN1;

output wire[6:0] LD;
output wire[7:0] seg;
output wire[7:0] cat;
output wire[7:0] hang;
output wire[7:0] red;
output wire[7:0] gre;
output wire beep;

wire repeatRst_FROM_cryingFace_TO_control;
wire repeatRst_FROM_laughingFace_TO_control;
wire repeatRst_TO_control;
assign repeatRst_TO_control = repeatRst_FROM_cryingFace_TO_control || repeatRst_FROM_laughingFace_TO_control;

wire[6:0] LD_FROM_pswInput_check;
wire[6:0] LD_FROM_Show_password;
assign LD = LD_FROM_pswInput_check | LD_FROM_Show_password;

wire[7:0] seg_FROM_CntDown20;
wire[7:0] seg_FROM_Shwo_password;
assign seg = seg_FROM_CntDown20 | seg_FROM_Shwo_password;

wire[7:0] cat_FROM_CntDown20;
wire[7:0] cat_FROM_Shwo_password;
assign cat = cat_FROM_CntDown20 | cat_FROM_Shwo_password;

wire[7:0] hang_FROM_laughingFace;
wire[7:0] hang_FROM_cryingFace;
wire[7:0] hang_FROM_zhadan_dianzhen;
assign hang = hang_FROM_laughingFace | hang_FROM_cryingFace | hang_FROM_zhadan_dianzhen;

wire[7:0] gre_FROM_laughingFace;
wire[7:0] gre_FROM_zhadan_dianzhen;
assign gre = gre_FROM_laughingFace | gre_FROM_zhadan_dianzhen;

wire[7:0] red_FROM_cryingFace;
wire[7:0] red_FROM_zhadan_dianzhen;
assign red = red_FROM_cryingFace | red_FROM_zhadan_dianzhen;

wire beep_FROM_cryingFace;
wire beep_FROM_laughingFace;
assign beep = beep_FROM_cryingFace || beep_FROM_laughingFace;

wire fail_FROM_zhadan_dianzhen_TO_control_cryingFace;
wire success_FROM_pswInput_check_TO_control_laughingFace;
wire endOfShow;
wire BombSwitch;
wire[4:0] random;
wire start;		//从control到zhadan_dianzhen和CntDown20
wire startInput;
wire rst_n;
wire rst_p;
wire[6:0] rand_num_FROM_random_password_TO_show_password_pswInpu_check;




control (//输入信号
			.clk(clk), 
			.SW7(SW7),
			.repeatRst(repeatRst_FROM_cryingFace_laughingFace_TO_control),
			.infail(fail_FROM_zhadan_dianzhen_TO_control_cryingFace),
			.BTN1(BTN1),
			.insuccess(success_FROM_pswInput_check_TO_control_laughingFace),
			.endOfShow(endOfShow),
			//输出信号
			.BombSwitch(BombSwitch),
			.random(random),
			.start(start),
			.startInput(startInput),
			.rst_n(rst_n),
			.rst_p(rst_p),
			.showing(showing)
			);
			
random_password(//输入信号
					.rst_n(rst_n),
					.clk(clk),
					.load(BTN1),
					.random(random),
					.seed(8'd11111111),
					//输出信号
					.rand_num(rand_num_FROM_random_password_TO_show_password_pswInpu_check)
					);
					
Show_password(//输入信号
				.rst(rst_p),
				.clk(clk),
				.psw(rand_num_FROM_random_password_TO_show_password_pswInpu_check),
				.showing(showing),
				//输出信号
				.LD(LD_FROM_Show_password),
				.seg(seg_FROM_Shwo_password),
				.cat(cat_FROM_Shwo_password),
				.endOfShow(endOfShow)
				);
				
CntDown20(//输入信号
			.rst(rst_n),
			.clk(clk),
			.start(start),
			//输出信号
			.cat(cat_FROM_CntDown20),
			.seg(seg_FROM_CntDown20)
			);
			
zhadan_dianzhen(//输入信号
					.clk(clk),
					.BombSwitch(BombSwitch),
					.start(start),
					.rst(rst_p),
					//输出信号
					.fail(fail_FROM_zhadan_dianzhen_TO_control_cryingFace),
					.hang(hang_FROM_zhadan_dianzhen),
					.red(red_FROM_zhadan_dianzhen),
					.gre(gre_FROM_zhadan_dianzhen)
					);
					
pswInput_check(//输入信号
					.clk(clk),
					.rst(rst_n),					
					.startInput(startInput),
					.SW(SW),
					.psw(rand_num_FROM_random_password_TO_show_password_pswInpu_check),
					.BTN6(BTN6),
					//输出信号
					.LD(LD_FROM_pswInput_check),
					.success(success_FROM_pswInput_check_TO_control_laughingFace)
					);
					
laughingFace(//输入信号
				.clk(clk),
				.rst_n(rst_n),
				.success(success_FROM_pswInput_check_TO_control_laughingFace),
				//输出信号
				.hang(hang_FROM_laughingFace),
				.gre(gre_FROM_laughingFace),
				.beep(beep_FROM_laughingFace),
				.repeatRst(repeatRst_FROM_laughingFace_TO_control)
				);
				
cryingFace(//输入信号
			.clk(clk),
			.rst_n(rst_n),
			.fail(fail_FROM_zhadan_dianzhen_TO_control_cryingFace),
			//输出信号
			.hang(hang_FROM_cryingFace),
			.red(red_FROM_cryingFace),
			.beep(beep_FROM_cryingFace),
			.repeatRst(repeatRst_FROM_cryingFace_TO_control)
			);


endmodule 