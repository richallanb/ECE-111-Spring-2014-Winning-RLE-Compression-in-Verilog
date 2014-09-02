// Copyright (C) 1991-2012 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 32-bit"
// VERSION		"Version 12.0 Build 263 08/02/2012 Service Pack 2 SJ Full Version"
// CREATED		"Tue May 06 12:07:32 2014"

module block_m(
	clk,
	reset,
	writing,
	datain,
	CU1_lrunwo,
	CU1_haslast,
	CU2_haslast,
	CU3_haslast,
	CU4_haslast,
	CU1_curr,
	CU1_lrun,
	CU2_curr,
	CU3_curr,
	CU4_curr,
	CU4_lrunlen,
	CU4_lrunval
);


input wire	clk;
input wire	reset;
input wire	writing;
input wire	[31:0] datain;
output wire	CU1_lrunwo;
output wire	CU1_haslast;
output wire	CU2_haslast;
output wire	CU3_haslast;
output wire	CU4_haslast;
output wire	[15:0] CU1_curr;
output wire	[15:0] CU1_lrun;
output wire	[15:0] CU2_curr;
output wire	[15:0] CU3_curr;
output wire	[15:0] CU4_curr;
output wire [7:0] CU4_lrunlen;
output wire [7:0] CU4_lrunval;


wire	[7:0] SYNTHESIZED_WIRE_0;
wire	[7:0] SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	[31:0] SYNTHESIZED_WIRE_3;
wire	[7:0] SYNTHESIZED_WIRE_4;
wire	[7:0] SYNTHESIZED_WIRE_5;
wire	[3:0] SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
wire	[31:0] SYNTHESIZED_WIRE_8;
wire	[7:0] SYNTHESIZED_WIRE_9;
wire	[7:0] SYNTHESIZED_WIRE_10;
wire	[3:0] SYNTHESIZED_WIRE_11;
wire	SYNTHESIZED_WIRE_12;
wire	[31:0] SYNTHESIZED_WIRE_13;
wire	[7:0] SYNTHESIZED_WIRE_14;
wire	[7:0] SYNTHESIZED_WIRE_15;
wire	[3:0] SYNTHESIZED_WIRE_16;





comp_unit	b2v_inst(
	.clk(clk),
	.reset(reset),
	.writing(writing),
	.din(datain),
	.l_run_len_i(SYNTHESIZED_WIRE_0),
	.l_run_val_i(SYNTHESIZED_WIRE_1),
	.l_run_wo(CU1_lrunwo),
	.en_next(SYNTHESIZED_WIRE_2),
	.has_last(CU1_haslast),
	.curr_out(CU1_curr),
	.dout_next(SYNTHESIZED_WIRE_3),
	.l_run_dout(CU1_lrun),
	.l_run_len_o(SYNTHESIZED_WIRE_4),
	.l_run_val_o(SYNTHESIZED_WIRE_5),
	.offset_o(SYNTHESIZED_WIRE_6));


comp_unit_x	b2v_inst2(
	.clk(clk),
	.reset(reset),
	.writing(writing),
	.enabled(SYNTHESIZED_WIRE_2),
	.din(SYNTHESIZED_WIRE_3),
	.l_run_len_i(SYNTHESIZED_WIRE_4),
	.l_run_val_i(SYNTHESIZED_WIRE_5),
	.offset_i(SYNTHESIZED_WIRE_6),
	.en_next(SYNTHESIZED_WIRE_7),
	.has_last(CU2_haslast),
	.curr_out(CU2_curr),
	.dout_next(SYNTHESIZED_WIRE_8),
	.l_run_len_o(SYNTHESIZED_WIRE_9),
	.l_run_val_o(SYNTHESIZED_WIRE_10),
	.offset_o(SYNTHESIZED_WIRE_11));


comp_unit_x	b2v_inst3(
	.clk(clk),
	.reset(reset),
	.writing(writing),
	.enabled(SYNTHESIZED_WIRE_7),
	.din(SYNTHESIZED_WIRE_8),
	.l_run_len_i(SYNTHESIZED_WIRE_9),
	.l_run_val_i(SYNTHESIZED_WIRE_10),
	.offset_i(SYNTHESIZED_WIRE_11),
	.en_next(SYNTHESIZED_WIRE_12),
	.has_last(CU3_haslast),
	.curr_out(CU3_curr),
	.dout_next(SYNTHESIZED_WIRE_13),
	.l_run_len_o(SYNTHESIZED_WIRE_14),
	.l_run_val_o(SYNTHESIZED_WIRE_15),
	.offset_o(SYNTHESIZED_WIRE_16));


comp_unit_x	b2v_inst4(
	.clk(clk),
	.reset(reset),
	.writing(writing),
	.enabled(SYNTHESIZED_WIRE_12),
	.din(SYNTHESIZED_WIRE_13),
	.l_run_len_i(SYNTHESIZED_WIRE_14),
	.l_run_val_i(SYNTHESIZED_WIRE_15),
	.offset_i(SYNTHESIZED_WIRE_16),
	
	.has_last(CU4_haslast),
	.curr_out(CU4_curr),
	
	.l_run_len_o(SYNTHESIZED_WIRE_0),
	.l_run_val_o(SYNTHESIZED_WIRE_1)
	);
assign CU4_lrunlen = SYNTHESIZED_WIRE_0 ;
assign CU4_lrunval = SYNTHESIZED_WIRE_1;

endmodule
