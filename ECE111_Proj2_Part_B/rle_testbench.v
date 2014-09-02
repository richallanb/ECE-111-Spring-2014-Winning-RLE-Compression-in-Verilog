module rle_testbench(); 

reg 	clk; 
reg 	nreset; 
reg 	[31:0] message_addr; 
reg 	[31:0] rle_addr; 
reg 	[31:0] message_size; 
reg 	[31:0] start;
reg   [31:0] port_A_data_out;
reg 	[31:0] dpsram[0:16383];

integer k; 
integer ii;
integer iii;
integer out1;
integer count;

wire	[31:0] rle_size; 
wire	port_A_clk;
wire	[31:0] port_A_data_in;
wire	[15:0] port_A_addr;
wire	port_A_we;
wire	done; 



rle rle_inst (
.clk		(clk),
.nreset		(nreset), 
.start	(start[0]),
.message_addr	(message_addr), 
.message_size	(message_size), 
.rle_addr	(rle_addr), 
.rle_size	(rle_size),
.done		(done), 
.port_A_clk	(port_A_clk),
.port_A_data_in	(port_A_data_in),
.port_A_data_out(port_A_data_out),
.port_A_addr	(port_A_addr),
.port_A_we	(port_A_we)
);



// CLOCK GENERATOR

always
begin
	#10; 
	clk = 1'b1; 
	#10
	clk = 1'b0; 
end

// MAIN TESTBENCH 

initial
begin

// RESET RLE PROCESSOR

	@(posedge clk) nreset = 0; 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);
	nreset = 1; 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);

// READ 100 BYTES FROM FILE  
// MAKE SURE TO ENTER THE FULL LOCATION OF THE PLAINTEXT.DAT FILE ON YOUR PC
// EX: C:/USERS/STUDENT/DOCUMENTS/PLAINTEXT.DAT
	$readmemh("plaintext.dat", dpsram);

// DISPLAY PLAINTEXT OF FRAME # 1 (48 BYTES)

	$display("-----------\n"); 
	$display("Plaintext 1\n"); 
	$display("-----------\n"); 
	for (k = 0; k < 12; k = k + 1)
	begin
		$display("%x\n", dpsram[k]); 
	end
			
// SET INPUTS TO RLE PROCESSOR

	message_addr = 32'h0;	
   message_size = 32'd48; 
   rle_addr = 32'hC8; 
	start = 1'b1;
	ii=1;
	iii=1; 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);
	start = 1'b0; 

// WAIT TILL ENTIRE FRAME IS COMPRESSED, THEN DISPLAY COMPRESSED TEXT

	wait (done == 1); 
 $display("1st latency %d!\n",ii); // show first delay
 out1=out1+ii;
 ii=0;
// SOME IDLE CYCLES BEFORE NEXT FRAME 

	for (k = 0; k < 10; k = k + 1) @(posedge clk);
	
// DISPLAY AND CHECK RLE_SIZE FOR CORRECTNESS
	$display("-----------\n"); 
	if( rle_size == 12)
		$display("Correct rle_size: %d\n", rle_size);
	else
		$display("Incorrect rle_size: %d, SHOULD BE: 12\n", rle_size);

// DISPLAY COMPRESSED TEXT OF FRAME # 1 (48 BYTES)

	$display("-----------\n"); 
	$display("Compressed text 1\n"); 
	$display("-----------\n");
	if( rle_size%4 > 0 )
		count = 50+(rle_size/4)+1;
	else
		count = 50+(rle_size/4);
	for (k = 50; k < count; k = k + 1)
	begin
		$display("%x\n", dpsram[k]); 
	end


// DISPLAY PLAINTEXT OF FRAME # 2 (51 BYTES)

	$display("-----------\n"); 
        $display("Plaintext 2\n");
	$display("-----------\n"); 
        for (k = 12; k < 25; k = k + 1)
        begin
                $display("%x\n", dpsram[k]);
        end
		$display("Note, most significant byte (00) of last word should not be encrypted\n"); 

// SET INPUTS TO RLE PROCESSOR

        message_addr = 32'h30;
        message_size = 32'd51;
        rle_addr = 32'h012C;
        start = 1'b1;
        ii=1;
		  iii=1;
        for (k = 0; k < 2; k = k + 1) @(posedge clk);
        start = 1'b0;

// WAIT TILL ENTIRE FRAME IS COMPRESSED, THEN DISPLAY COMPRESSED TEXT

        wait (done == 1);
out1=out1+ii;

// DISPLAY AND CHECK RLE_SIZE FOR CORRECTNESS
	$display("-----------\n"); 
	if( rle_size == 76)
		$display("Correct rle_size: %d\n", rle_size);
	else
		$display("Incorrect rle_size: %d, SHOULD BE: 76\n", rle_size);
		
// DISPLAY COMPRESSED TEXT OF FRAME # 2 (51 BYTES)

	$display("-----------\n"); 
        $display("Compressed text 2\n"); 
	$display("-----------\n"); 
	if( rle_size%4 > 0 )
		count = 75+(rle_size/4)+1;
	else
		count = 75+(rle_size/4);
	for (k = 75; k < count; k = k + 1)
	begin
		$display("%x\n", dpsram[k]); 
	end
  $display("2st latency %d!\n",ii); // show second delay
	$display("--Total Latency: %d",out1);         
	$stop;
end


// DPSRAM MODEL - (changed on 04/18/03)
// Note (IMPORTANT): 
// 1. The Encryption Block can access the DPSRAM only word-by-word 
//    (and not individual bytes). 

// 2. The timing diagrams for reading and writing memory are given
//    on Project1 webpage. Please refer to them.

always @(posedge port_A_clk)
begin
	if (port_A_addr % 4 == 0)
	begin
		if (port_A_we == 1'b1) 	// write
			dpsram[port_A_addr >> 2] = port_A_data_in;
		else			// read
			port_A_data_out = dpsram[port_A_addr >> 2];
	end
	else
		$display("Error: memory reference not word aligned!\n");
end


always @(posedge clk)
begin
	if (!nreset)
	begin
		ii=0;
		iii=0;
		out1=0;
	end
	else
	begin
		ii=ii+1;
		iii=iii+1;
	end	
end

endmodule