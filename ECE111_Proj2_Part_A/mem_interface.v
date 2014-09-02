module mem_interface (output  port_A_clk,
// clock to dpsram (drive this with the input clk)

output  port_A_we,
// read/write selector for dpsram
input done_read,
input new_data_read,
input done_write,
input new_data_write,
output done,
input clk);

assign port_A_clk = clk ^ new_data_read ^ new_data_write;
assign port_A_we = ~new_data_read&new_data_write;
always @ (clk)
begin
end

endmodule