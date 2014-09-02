
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

output  port_A_we;
// read/write selector for dpsram

output	[31:0] rle_size;
// Length of the compressed text in bytes

output	done; // done is a signal to indicate that encryption of the frame is complete

wire doneread;
wire donewrite;
wire writing;
wire i_reset;
wire [15:0] port_A_addr_read;
wire [15:0] port_A_addr_write;
assign port_A_clk = clk;
assign done = doneread & donewrite;
assign port_A_we = writing;
assign port_A_addr = writing?port_A_addr_write:port_A_addr_read;
assign i_reset = ~nreset | start;


block blkv (.clk(clk),
	.reset(i_reset),
	.datain(port_A_data_out),
	.writing(writing),
	.done_read(doneread),
	.done_write(donewrite),
	.port_A_addr_read(port_A_addr_read),
	.port_A_addr_write(port_A_addr_write),
	.message_addr(message_addr),
	.message_size(message_size),
	.rle_size(rle_size),
	.rle_addr(rle_addr),
	.start(start),
	.dataout(port_A_data_in));
	


endmodule