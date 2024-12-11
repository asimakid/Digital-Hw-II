module fifo_tb();
 
parameter WIDTH=16;
parameter LENGTH =16;
logic[WIDTH-1:0] tfifo_data_in,tfifo_data_out;
logic trst_,tfifo_write,tfifo_read,tclk,tfifo_full,tfifo_empty;
//the three internal valriable of the instansiated module
fifo fifotest(tfifo_data_in,trst_,tfifo_write,tfifo_read,tclk,tfifo_data_out,tfifo_full,tfifo_empty);
bind fifotest fifo_property fifobineded(fifo_data_in,fifo_data_out,rst_,fifo_write,fifo_read,clk,fifo_full,fifo_empty,wr_ptr,rd_ptr,cntr);

initial begin 
	tclk =0;	
	forever 
	#10 tclk = ~tclk;
end
initial begin
	trst_ =0;        
	tfifo_read = 0;
	tfifo_write =0;
	#5
	trst_ =1;
	tfifo_write =1;
	tfifo_data_in = 10;
	#20
	tfifo_data_in = 11;
	#20
	tfifo_data_in = 12;
	#20
	tfifo_data_in = 13;
	#20
	tfifo_data_in = 14;
	#20
	tfifo_data_in = 15;
	#20
	tfifo_data_in = 16;
	#20
	tfifo_data_in = 17;
	#20
	tfifo_data_in = 18;
	#20
	tfifo_data_in = 19;
	#20
	tfifo_data_in = 20;
	#20
	tfifo_data_in = 21;
	#20
	tfifo_data_in = 22;
	#20
	tfifo_data_in = 1;
	#20
	tfifo_data_in = 2;
	#20
	tfifo_data_in = 3;
	#20
	tfifo_data_in = 4;
	#20
	tfifo_data_in = 5;
	#20
	tfifo_data_in = 10;
	#20
	tfifo_data_in = 10;
	#20
	tfifo_data_in = 10;
	#20
	tfifo_data_in = 1;
	#20
	tfifo_data_in = 6;
	#20
	tfifo_data_in = 10;
	#20
	tfifo_data_in = 10;
	#20
	tfifo_data_in = 10;
	#20
	tfifo_read=1;
	tfifo_write=0;
	#100
	trst_=0;
	#10
	trst_=1;
	#50
	tfifo_read =0;
	tfifo_write =1;
	#200
	tfifo_read =1;
	tfifo_write =0;
	#20
	trst_=0;
	#10
	trst_=1;
	#400
	tfifo_write=1;
	tfifo_read =0;
	#400
	tfifo_read=1;
	tfifo_write=0;	
	#20
	$stop;
end


endmodule
