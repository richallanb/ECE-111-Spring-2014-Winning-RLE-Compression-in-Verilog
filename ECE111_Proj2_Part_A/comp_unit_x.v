module comp_unit_x (input [31:0]din, input clk, input reset, input writing, input [7:0] l_run_val_i , input [7:0] l_run_len_i ,
output [15:0] curr_out, output reg [7:0] l_run_val_o, output reg[7:0] l_run_len_o,
output en_next, output has_last, output [3:0]offset_o, output reg [31:0] dout_next,
input enabled,  output zerofilled,
input wire [3:0] offset_i, input done_read
);

reg [7:0]run_len;
reg [7:0]curr_val;
//reg [7:0]last_run_len;
//reg [7:0]last_run_val;
reg [3:0]offset ;
//reg last_valid;

always @ (*)
begin
	curr_val = din[7:0];
	/* */
	case({(din[7:0]==din[15:8])&offset_i[2],(din[7:0]==din[23:16])&offset_i[1],(din[7:0]==din[31:24])&offset_i[0]})
		3'b111: begin 
					run_len = 4;
					offset = offset_i << 4;

				  end
		3'b110: begin
					run_len = 3;
					offset = offset_i << 3;

				  end
		3'b101: begin
					run_len = 2;
					offset = offset_i << 2;

				  end
		3'b100: begin
					run_len = 2;
					offset = offset_i << 2;

				  end
		default: begin
					 run_len = 1;
					 offset = offset_i << 1;
					end
	endcase
	dout_next = din >> run_len * 8;
	if (enabled & has_last)
	begin
		l_run_len_o = run_len;
		l_run_val_o = curr_val;
	end
	else
	begin
		l_run_len_o = l_run_len_i;
		l_run_val_o = l_run_val_i;
	end
end 

assign zerofilled = (curr_val == 8'b0) & done_read;
assign offset_o = offset;
assign en_next = (offset != 4'b0);
assign has_last = ~en_next;
/*
always @ (posedge clk)
	if (reset)
	begin
		last_run_len <= 0;
		last_run_val <= 0;
		last_valid <= 0;
	end
	else if (~writing)
	begin
		if ((curr_val == last_run_val) & last_valid)
		begin
			last_run_val <= l_run_val_i;
			last_run_len <= last_run_len + l_run_len_i;
		end
		else if (~last_valid)
		begin
			last_run_val <= l_run_val_i;
			last_run_len <= l_run_len_i;
		end
		if (~last_valid)
			last_valid <= 1;
		
	end
end
assign l_run_dout[15:0] = {last_run_val, last_run_len};
assign l_run_wo = (last_run_val != curr_val) & last_valid & ~writing
*/
assign curr_out[15:0] = {curr_val, run_len};


endmodule
