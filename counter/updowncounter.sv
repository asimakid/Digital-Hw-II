module updowncounter(rst_,ld_cnt,updn_cnt,count_enb,clk,data_in,data_out);
	input logic rst_,ld_cnt,updn_cnt,count_enb,clk;
	input logic [15:0] data_in;
	output logic [15:0] data_out;
 	always_ff @(posedge clk,negedge rst_)begin 
		if(!rst_) 
			data_out <= 16'b0;
		else begin 
			if(!ld_cnt)
				data_out <= data_in;
			else if (count_enb)
				if (updn_cnt)
					data_out <= data_out +1;
				else
					data_out <= data_out -1;
		end				
			//no need for else since it will maintain its content
	end
endmodule