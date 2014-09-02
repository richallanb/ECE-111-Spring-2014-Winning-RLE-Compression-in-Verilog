module pipe_write(
input clk,
input reset,
input CU1_haslast,
input CU2_haslast,
input CU3_haslast,
input CU4_haslast,
input CU2_en,
input CU3_en,
input CU4_en,
input lrun_wo,
input [15:0] lrun,
input [15:0] CU1_curr,
input [15:0] CU2_curr,
input [15:0] CU3_curr,
input [15:0] CU4_curr,
input done_read,
input first_read,
output [31:0] dout,
output writing,
output done_write,
output [31:0] rle_size,
// Length of the compressed text in bytes
input	[31:0] rle_addr,
// Starting address of the ciphertext frame
// i.e., specifies where RLE must write the ciphertext frame
output [15:0] port_A_addr,
// address of dpsram being read/written
input CU2_zero,
input CU3_zero,
input CU4_zero,
input started
);

reg [79:0] butter;
reg signed [7:0] sz;
reg [31:0] total_sz;
reg writeout;
reg i_done_read;

assign a = ~CU1_haslast;
assign b = CU2_en & ~CU2_haslast & ~CU2_zero;
assign c = CU3_en & ~CU3_haslast & ~CU3_zero;
assign d = CU4_en & done_read & ~CU4_zero;
assign port_A_addr = total_sz + rle_addr;

initial begin
	sz = 0;
	butter = 0;
	writeout = 0;
	i_done_read = 0;
end
assign dout = butter[31:0];
//assign writing = (sz > 31)|done_read;
assign writing = (((sz > 31) & ~reset & first_read & started)|i_done_read) & ~done_write;
assign done_write = (i_done_read & (sz < 1));
assign rle_size = total_sz;
/*reg [7:0] offset;

always @ (*)
begin
	offset = (a+b+c+d) << 5;
end*/

always @ (posedge clk)
begin

	if (reset)
	begin
		sz = 0;
		butter = 0;
		i_done_read = 0;
		total_sz = 0;
	end
	
	else if (first_read & started)
	begin
		
		//$display("A: %d, B: %d, C: %d, SZ: %d", a, b, c, sz);
		
		if (writing)
		begin
			butter <= butter >> 32;
			if (sz <32)
				total_sz <= total_sz + 2;
			else
				total_sz <= total_sz + 4;
			sz <= sz - 32;
		end
		else if (~done_write)
		begin
		
			i_done_read <= done_read;
				
			if (lrun_wo|done_read)
			begin
					//$display("memwritein with lrun %x", lrun);
					 
					case ({d,c,b,a})
						4'b1111: begin
							butter <= butter | ({CU4_curr, CU3_curr, CU2_curr, CU1_curr, lrun} << sz);
							sz <= sz + 80;
							end
						4'b1110: begin
							butter <= butter | ({CU4_curr, CU3_curr, CU2_curr, lrun} << sz);
							sz <= sz + 64;
							end
						4'b0111: begin
							butter <= butter | ({CU3_curr, CU2_curr, CU1_curr, lrun} << sz);
							sz <= sz + 64;
							end
						4'b0011: begin
							butter <= butter | ({CU2_curr, CU1_curr, lrun} << sz);
							sz <= sz + 48;
							end
						4'b0110: begin
							butter <= butter | ({CU3_curr, CU2_curr, lrun} << sz);
							sz <= sz + 48;
							end
						4'b0001: begin
							butter <= butter | ({CU1_curr,lrun} << sz);
							sz <= sz + 32;
							end
						default:	begin
							butter <= butter | (lrun << sz);
							sz <= sz + 16;
						end
					endcase	
			end
			
			else if (~lrun_wo)
			begin
			
				//$display("memwritein w/o lrun %x", CU1_curr);
				
				case ({d,c,b,a})
					4'b1111: begin
						butter <= butter | ({CU4_curr, CU3_curr, CU2_curr, CU1_curr} << sz);
						sz <= sz + 64;
						end
					4'b0111: begin
						butter <= butter | ({CU3_curr, CU2_curr, CU1_curr} << sz);
						sz <= sz + 48;
						end
					4'b0011: begin
						butter <= butter | ({CU2_curr, CU1_curr} << sz);
						sz <= sz + 32;
						end
					4'b0001: begin
						butter <= butter | (CU1_curr << sz);
						sz <= sz + 16;
						end
				endcase	
			end
		end
	end
	
end



endmodule