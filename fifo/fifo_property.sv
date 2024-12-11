module fifo_property#(parameter WIDTH = 16,parameter DEPTH=16)
(input logic[WIDTH-1:0] pfifo_data_in,pfifo_data_out,
input logic prst_,pfifo_write,pfifo_read,pclk,pfifo_full,pfifo_empty,
input logic [$clog2(WIDTH)-1:0] pwr_ptr,prd_ptr,
input logic [$clog2(WIDTH):0] pcntr);

//names for the 5 properties to be checked
//creset:check if reset is implemented the right way
//cempty:check the empty signal
//cfull: check the full signal 
//nowritefull: dont write to memory when full
//noreadempty: dont read when memory empty

`ifdef creset
always_comb
if(!prst_) 
checkreset: assert final(pwr_ptr== 0 &&prd_ptr ==0 &&pfifo_empty==1&&pfifo_full==0&&pcntr==0)$display("Passed reset check");else $display($stime,,,"\t\t %m FAIL");
`endif
`ifdef cempty
	property pr2;
		@(posedge pclk) disable iff(!prst_) !pcntr|->pfifo_empty;
	endproperty
	checkempty: assert property (pr2)else $display($stime,,,"\t\t %m FAIL"); 
	cover property (pr2) $display($stime,,,"\t\tPassed the check for empty");
`endif
`ifdef cfull
	property pr3;
		@(posedge pclk) disable iff(!prst_) pcntr >= WIDTH|->pfifo_full;
	endproperty
	ccheckfull: assert property (pr3)else $display($stime,,,"\t\t %m FAIL"); 
	cover property (pr3) $display($stime,,,"\t\tPassed the check for full");
`endif
`ifdef nowritefull
	property pr4;
		@(posedge pclk) disable iff(!prst_) pfifo_full&&pfifo_write&&!pfifo_read|=> $stable(pwr_ptr);
	endproperty
	checknowritewhenfull: assert property (pr4)else $display($stime,,,"\t\t %m FAIL"); 
	cover property (pr4) $display($stime,,,"\t\tPassed the check for no write when full");
`endif
`ifdef noreadempty
	property pr5;
		@(posedge pclk) disable iff(!prst_) pfifo_empty&&pfifo_read&&!pfifo_write|=> $stable(prd_ptr);
	endproperty
	checknoreadwhenempty: assert property (pr5)else $display($stime,,,"\t\t %m FAIL"); 
	cover property (pr5) $display($stime,,,"\t\tPassed the check for no write when empty");
`endif

endmodule