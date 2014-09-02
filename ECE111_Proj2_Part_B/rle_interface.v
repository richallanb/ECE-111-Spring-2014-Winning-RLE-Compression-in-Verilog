module rle (
	clk, 		
	nreset, 	
	start,
	message_addr,	
	message_size, 	
	rle_addr, 	
	rle_size, 	
	done, 		
	port_A_clk,
        port_A_data_in,
        port_A_data_out,
        port_A_addr,
        port_A_we
	);

input	clk;
input	nreset;
// Initializes the RLE module

input	start;
// Tells RLE to start compressing the given frame

input 	[31:0] message_addr;
// Starting address of the plaintext frame
// i.e., specifies from where RLE must read the plaintext frame

input	[31:0] message_size;
// Length of the plain text in bytes

input	[31:0] rle_addr;
// Starting address of the ciphertext frame
// i.e., specifies where RLE must write the ciphertext frame

input   [31:0] port_A_data_out;
// read data from the dpsram (plaintext)

output  [31:0] port_A_data_in;
// write data to the dpsram (ciphertext)

output  [15:0] port_A_addr;
// address of dpsram being read/written

output  port_A_clk;
// clock to dpsram (drive this with the input clk)

output port_A_we;
// read/write selector for dpsram

output	[31:0] rle_size;
// Length of the compressed text in bytes

output	done; // done is a signal to indicate that encryption of the frame is complete

reg [1:0] state;
parameter starting = 2'd0,
			 reading = 2'd1,
			 writing = 2'd2,
			 working = 2'd3;
	// 0 = starting
	// 1 = reading
	// 2 = writing
	// 3 = working
reg [31:0] butter;
reg [31:0] datain;
reg butter_offset;
reg [7:0] lastval;
reg [7:0] lastrun;
reg [15:0] read_offset;
reg [15:0] write_offset;
reg [15:0] rlesz;
reg first_read;
reg butter_full;
reg input_empty;
reg [1:0] input_offset;
wire doneread;
reg donewrite;
always @ (posedge clk)
begin
	if (~nreset | (state == 0) | start) begin
		state <= 1;
		butter = 0;
		butter_offset = 0;
		lastval = 0;
		lastrun = 0;
		read_offset = 0;
		write_offset = 0;
		first_read = 0;
		input_offset = 0;
		rlesz = 0;
		butter_full = 0;
		input_empty = 0;
		//doneread =0;
		//$display ("reset/start state");
	end
	else if((state == 1) & nreset)
	begin
		read_offset <= read_offset + 4;
		/*if (read_offset == message_size+4)
			doneread <= 1;*/
		if (~butter_full)
			state <= 3;
		else
			state <= 2;
		input_empty <= 0;
		datain <= port_A_data_out;
		donewrite <= 0;
		//$display ("read state.. %d .. %h .. doneread %d", port_A_addr, port_A_data_out, doneread);
	end
	else if ((state == 2) & nreset & ~donewrite)
	begin
		//$display ("write state .. %h ... sz %d .. inputoff .. %d", butter, rlesz, input_offset);
		write_offset <= write_offset + 4;
		butter <= 0;
		butter_full <= 0;
		butter_offset <= 0;
		if (doneread & input_empty) begin
			donewrite <= 1;
		end
		else
			begin
			if (input_empty)
				state <= 1;
			else
				state <= 3;
			end
		
	end
	else if ((state == 3) & nreset)
	begin
		//$display ("work state..  %h%h .. current %h .. inputoff %d .. done %d", lastval, lastrun, datain[7:0], input_offset, doneread);
		if (~first_read) begin
			lastrun <= lastrun + 1;
			lastval <= datain[7:0];
			first_read <= 1;
		end
		else
		begin
			if (doneread & (input_offset == 3) & (datain[7:0] != 0)) begin
				butter <= ({datain[7:0], 8'd1, lastval, lastrun});
				state <= 2;
				rlesz <= rlesz + 4;
				input_offset <= 0;
			end
			else if ((datain[7:0] != lastval)) begin
				//$display ("writing buffer .. %h%h .. off %d", lastval, lastrun, butter_offset);
				lastrun <= 1;
				lastval <= datain[7:0];
				if (butter_offset) begin
					//if (~doneread & (lastval == 0)) begin
					butter <= butter | ({lastval, lastrun} << 16);
					state <= 2;
					rlesz <= rlesz + 2;
					butter_full <= 1;
					//end
				end
				else
				begin
					butter_offset <= 1;
					butter[15:0] <= {lastval, lastrun};
					rlesz <= rlesz + 2;
				end
			end
			else if ((datain[7:0] == lastval)) begin
				lastrun <= lastrun + 1;
			end
			
			
			
		end
		
		if (input_offset != 2'd3) begin
			input_offset <= input_offset + 1;
			datain <= (datain >> 8);
				
		end
		else begin
			input_empty <= 1;
			if (~doneread) begin
				input_offset <= 0;
				state <= 1;
			end
			else if (butter_offset & doneread) begin
				input_offset <= 0;
				state <= 2;
			end
		end
		
	end
end
/*
always @ (*)
begin
	if (state == 1) begin
		port_A_addr = message_addr + read_offset;
		port_A_we = 0;
	end
	else if (state == 2)
	begin
		port_A_we = 1;
		port_A_addr = rle_addr + write_offset;
	end
end
*/
assign port_A_we = (state == 2)?1:0;
assign port_A_addr = (state==2)?rle_addr + write_offset:message_addr + read_offset;
assign done = doneread & donewrite;
assign doneread = (read_offset >= message_size);
assign port_A_data_in = butter;
assign port_A_clk = clk;
assign rle_size = rlesz;

endmodule
