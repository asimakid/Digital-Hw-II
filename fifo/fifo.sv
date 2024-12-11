module fifo #(parameter WIDTH = 16,parameter DEPTH=16)
(input logic[WIDTH-1:0] fifo_data_in,input logic rst_,fifo_write,fifo_read,clk,
output logic[WIDTH-1:0] fifo_data_out,output logic fifo_full,fifo_empty);

//internal variable to model the mmemory matrix
logic [WIDTH-1:0] memory [0:DEPTH-1];
//pointers size will be the log2 of memory elements
logic [$clog2(WIDTH)-1:0] wr_ptr,rd_ptr;
logic [$clog2(WIDTH):0] cntr;
always_comb begin 
	fifo_empty = cntr ==0;
	fifo_full = cntr == DEPTH;
end
always_ff@(posedge clk,negedge rst_) begin
	if(!rst_)begin
		//zero the cntr will change the full and empty
		cntr <= 0;
		wr_ptr <= 0;
		rd_ptr <= 0;
		fifo_data_out <= 0;
		memory <= '{WIDTH{0}};
	end
	else begin
		//fifof can only read and write at each time
		if(fifo_read&&!fifo_empty) begin 
			fifo_data_out <= memory[rd_ptr];
			cntr <= cntr -1;
			rd_ptr <= rd_ptr+1;
		end 
		else if(fifo_write&&!fifo_full) begin
			memory[wr_ptr] <=fifo_data_in;
			cntr <= cntr +1;
			wr_ptr <= wr_ptr+1;
		end
	end
end

endmodule
