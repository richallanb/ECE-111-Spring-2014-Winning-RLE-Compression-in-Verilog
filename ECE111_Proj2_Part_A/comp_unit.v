module comp_unit (input [31:0]din, input clk, input reset, input writing, input [7:0] l_run_val_i , input [7:0] l_run_len_i ,
output [15:0] curr_out, output [15:0] l_run_dout, output l_run_wo, output reg [7:0] l_run_val_o, output reg [7:0] l_run_len_o,
output en_next, output has_last, output [3:0]offset_o, output reg [31:0] dout_next, input first_read_i,input start);

reg [7:0]run_len;
reg [7:0]curr_val;
reg [7:0]last_run_len;
reg [7:0]last_run_val;
wire [7:0]last_run_len_w;
wire [7:0]last_run_val_w;
reg [3:0]offset ;
reg first_read;
wire curr_comp;

initial begin
	first_read = 0;
	last_run_len = 0;
	last_run_val = 0;
	offset = 4'b1111;
end

always @ (*)
begin
	curr_val = din[7:0];
	/* */
	case({(din[7:0]==din[15:8]),(din[7:0]==din[23:16]),(din[7:0]==din[31:24])})
		3'b111: begin 
					run_len = 4;
					offset = 4'b0;

				  end
		3'b110: begin
					run_len = 3;
					offset = 4'b1000;

				  end
		3'b101: begin
					run_len = 2;
					offset = 4'b1100;

				  end
		3'b100: begin
					run_len = 2;
					offset = 4'b1100;

				  end
		default: begin
					 run_len = 1;
					 offset = 4'b1110;
					end
	endcase
	dout_next = din >> run_len * 8;
	if (has_last)
	begin
		l_run_len_o = run_len;
		l_run_val_o = curr_val;
	end
end 

assign offset_o = offset;
assign en_next = (offset != 4'b0)&~writing;
assign has_last = ~en_next|(curr_comp&first_read)&~writing;
assign i_has_last = ~en_next;
assign curr_comp = (curr_val == last_run_val);

reg [7:0] clk_lrunval;
reg [7:0] clk_lrunlen;

always @ (posedge clk)
begin
	if (reset)
	begin
		last_run_len <= 0;
		last_run_val <= 0;
		first_read <= 0;
	end
	
	else if(start) 
	begin
	if (~writing)
	begin
		clk_lrunval <= l_run_val_i;
		clk_lrunlen <= l_run_len_i;
	
		
		
		if(~first_read | ~i_has_last | ~curr_comp)
		begin
			last_run_val <= l_run_val_i;
			last_run_len <= l_run_len_i;
		end
		else if (curr_comp & i_has_last)
		begin
			last_run_len <= last_run_len + run_len;
		end
		//l_run_wo <= ~has_last&first_read;
			first_read<= first_read_i;
	end
	end
end

assign last_run_len_w = (curr_comp)?run_len+last_run_len:last_run_len;
assign curr_out[15:0] = {curr_val, run_len};
assign l_run_dout[15:0] = {last_run_val, last_run_len_w};
//assign l_run_wo = (last_run_val != l_run_val_i) & has_last & ~writing;
assign l_run_wo = first_read & ~writing &(~i_has_last | ~curr_comp);

endmodule
