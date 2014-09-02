module pipe_read (input	[31:0] message_addr,
// Starting address of the plaintext frame
// i.e., specifies from where RLE must read the plaintext frame

input	[31:0] message_size,
// Length of the plain text in bytes

input   [31:0] port_A_data_out,
// read data from the dpsram (plaintext)

output [15:0] port_A_addr,
// address of dpsram being read/written

// clock to dpsram (drive this with the input clk)

output  port_A_we,
// read/write selector for dpsram

output reg firstread,
input clk,
input reset,
output [31:0] dout,
output reg done_read,
input writing,
input start,
output started);
wire done_read_i;

reg [31:0] curr_addr_off;
initial begin
curr_addr_off =0;
firstread = 0;
done_read = 0;
end

always @ (posedge clk)
begin
	if (reset)
	begin
		curr_addr_off <= 0;
		firstread <= 0;
		done_read <= 0;
	end
	else if (~writing & ~done_read_i & started)
	begin
			curr_addr_off <= curr_addr_off + 4;
			if (curr_addr_off == 0)
				firstread <= 1;
	end
	done_read <= done_read_i;

end
assign dout = port_A_data_out;
assign done_read_i = ((curr_addr_off) >= message_size);
assign port_A_addr = message_addr + curr_addr_off;
assign started = (start | started);
endmodule