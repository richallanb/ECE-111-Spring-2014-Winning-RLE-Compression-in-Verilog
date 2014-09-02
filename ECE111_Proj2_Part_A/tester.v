module tester ();
reg	clk;
reg	reset;
wire	writing;
reg	[31:0] datain;
wire	CU1_lrunwo;
wire	CU1_haslast;
wire	CU2_haslast;
wire	CU3_haslast;
wire	CU4_haslast;
wire	[15:0] CU1_curr;
wire	[15:0] CU1_lrun;
wire	[15:0] CU2_curr;
wire	[15:0] CU3_curr;
wire	[15:0] CU4_curr;
wire [7:0] CU4_lrunlen;
wire [7:0] CU4_lrunval;
wire	[31:0] dataout;
wire	[31:0] dout_pipe;
reg [31:0] testmem [0:16383];
wire	port_A_clk;
wire	[15:0] port_A_addr;
wire	port_A_we;
reg [31:0] message_size;
reg [31:0] message_addr;
reg [31:0] portinput;
wire	firstread;
wire done_read;
wire done_write;

always begin
#5 clk = ~clk; // Toggle clock every 5 ticks
// this makes the clock cycle 10 ticks
end
integer i;
initial begin
/*testmem[0] = 32'h00000000;
testmem[1] = 32'h00000000;
testmem[2] = 32'h00000000;
testmem[3] = 32'h00000000;
testmem[4] = 32'h00000000;
testmem[5] = 32'h00000000;
testmem[6] = 32'h00000000;
testmem[7] = 32'h00000000;
testmem[8] = 32'h00000000;
testmem[9] = 32'h00000000;
testmem[10] = 32'h00000028;
testmem[11] = 32'h864d7f00;
testmem[0] = 32'h00000000;
testmem[1] = 32'h12345678;
testmem[2] = 32'h9ABCDEF0;
testmem[3] = 32'h00000000;
testmem[4] = 32'h00000000;
testmem[5] = 32'h0F005030;
testmem[6] = 32'h00000028;
testmem[7] = 32'h864d7f00;
testmem[8] = 32'h82367002;
testmem[9] = 32'h04564530;
testmem[10] = 32'h45645722;
testmem[11] = 32'hAB56C352;
testmem[12] = 32'h00555322;*/
testmem[0] = 32'h0a0c0b0a;
testmem[1] = 32'h0b0a0c0b;
testmem[2] = 32'h0c0b0a0c;
testmem[3] = 32'h0a0c0b0a;
testmem[4] = 32'h0b0a0c0b;
testmem[5] = 32'h0c0b0a0c;
testmem[6] = 32'h0a0c0b0a;
testmem[7] = 32'h0b0a0c0b;
testmem[8] = 32'h0c0b0a0c;
testmem[9] = 32'h000c0b0a;

i = 0;
clk = 1;
reset = 1;
message_size = 40;
message_addr = 0;
#20 reset = 0;

/*for (i=0;i<7;i=i+1) begin
	
	#20 datain = testmem[i];
	if (writing)
		#10;
end*/

end

assign port_A_clk = clk;
assign port_A_we = writing;
always @(posedge port_A_clk)
begin
	if (port_A_addr % 4 == 0)
	begin
		if (port_A_we == 1'b1) 	// write
			portinput = dataout; //testmem[port_A_addr >> 2] = datain;
		else		// read
			datain = testmem[port_A_addr >> 2];
	end
	else
		$display("Error: memory reference not word aligned!\n");
end
 


block blkv(.clk(clk),
	.reset(reset),
	.datain(datain),
	.writing(writing),
	.CU1_lrunwo(CU1_lrunwo),
	.CU1_haslast(CU1_haslast),
	.CU2_haslast(CU2_haslast),
	.CU3_haslast(CU3_haslast),
	.CU4_haslast(CU4_haslast),
	.CU1_curr(CU1_curr),
	.CU1_lrun(CU1_lrun),
	.CU2_curr(CU2_curr),
	.CU3_curr(CU3_curr),
	.CU4_curr(CU4_curr),
	.dataout(dataout),
	.port_A_addr(port_A_addr),
	.message_addr(message_addr),
	.message_size(message_size),
	.dout_pipe(dout_pipe),
	.firstread(firstread),
	.done_read(done_read),
	.done_write(done_write));
	
endmodule