module updowncounter_tb();
	logic sys_rst_,sys_ld_cnt,sys_updn_cnt,sys_count_enb,sys_clk;
	logic [15:0] sys_data_in,sys_data_out;
	updowncounter updowncountertest(.rst_(sys_rst_),.ld_cnt(sys_ld_cnt),.updn_cnt(sys_updn_cnt),.count_enb(sys_count_enb),.clk(sys_clk),.data_in(sys_data_in),.data_out(sys_data_out));
	bind updowncounter updowncounter_property updowncounterbound(rst_,ld_cnt,updn_cnt,count_enb,clk,data_in,data_out);
	initial begin
		sys_clk = 0;
		forever
         	#10 sys_clk = ~sys_clk;
	end
	initial begin 
		sys_rst_ = 0;
		#10 
		sys_rst_ = 1;
		sys_data_in = 16'hABCD;
		sys_ld_cnt  = 0;
		#10
		sys_ld_cnt  =1;
		sys_count_enb =1;
		sys_updn_cnt =1;
		#100
		sys_updn_cnt = 0;
		#100
		sys_count_enb = 0;
		#100
		sys_count_enb = 1;
		#100 
		sys_rst_ = 0;
		#5
		sys_rst_ = 1;
		sys_updn_cnt =1;
		#500
		sys_updn_cnt = 0;
		#500
		sys_updn_cnt = 1;
		#100		
		sys_count_enb = 0;
		#100		
		sys_count_enb = 1;
		#100
		sys_data_in = 16'h0010;
		sys_ld_cnt  = 0;
		#10
		sys_ld_cnt  =1;
		sys_count_enb =1;
		sys_updn_cnt =1;
		#100
		sys_rst_ = 0;
		#10
		sys_rst_ = 1;
		$stop;
	end
endmodule