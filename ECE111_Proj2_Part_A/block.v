// Copyright (C) 1991-2013 Altera Corporation
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

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 13.1.0 Build 162 10/23/2013 SJ Web Edition"
// CREATED		"Thu May 08 01:03:42 2014"

module block(
	clk,
	reset,
	start,
	datain,
	message_addr,
	message_size,
	rle_addr,
	CU2_haslast,
	CU3_haslast,
	CU4_haslast,
	CU1_lrunwo,
	CU1_haslast,
	firstread,
	writing,
	done_read,
	done_write,
	CU1_curr,
	CU1_lrun,
	CU2_curr,
	CU3_curr,
	CU4_curr,
	dataout,
	dout_pipe,
	port_A_addr_read,
	port_A_addr_write,
	rle_size
);


input wire	clk;
input wire	reset;
input wire	start;
input wire	[31:0] datain;
input wire	[31:0] message_addr;
input wire	[31:0] message_size;
input wire	[31:0] rle_addr;
output wire	CU2_haslast;
output wire	CU3_haslast;
output wire	CU4_haslast;
output wire	CU1_lrunwo;
output wire	CU1_haslast;
output wire	firstread;
output wire	writing;
output wire	done_read;
output wire	done_write;
output wire	[15:0] CU1_curr;
output wire	[15:0] CU1_lrun;
output wire	[15:0] CU2_curr;
output wire	[15:0] CU3_curr;
output wire	[15:0] CU4_curr;
output wire	[31:0] dataout;
output wire	[31:0] dout_pipe;
output wire	[15:0] port_A_addr_read;
output wire	[15:0] port_A_addr_write;
output wire	[31:0] rle_size;

wire	SYNTHESIZED_WIRE_47;
wire	SYNTHESIZED_WIRE_48;
wire	SYNTHESIZED_WIRE_49;
wire	[31:0] SYNTHESIZED_WIRE_3;
wire	[7:0] SYNTHESIZED_WIRE_4;
wire	[7:0] SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_50;
wire	SYNTHESIZED_WIRE_51;
wire	[31:0] SYNTHESIZED_WIRE_9;
wire	[7:0] SYNTHESIZED_WIRE_10;
wire	[7:0] SYNTHESIZED_WIRE_11;
wire	[3:0] SYNTHESIZED_WIRE_12;
wire	SYNTHESIZED_WIRE_52;
wire	[31:0] SYNTHESIZED_WIRE_16;
wire	[7:0] SYNTHESIZED_WIRE_17;
wire	[7:0] SYNTHESIZED_WIRE_18;
wire	[3:0] SYNTHESIZED_WIRE_19;
wire	SYNTHESIZED_WIRE_53;
wire	[31:0] SYNTHESIZED_WIRE_23;
wire	[7:0] SYNTHESIZED_WIRE_24;
wire	[7:0] SYNTHESIZED_WIRE_25;
wire	[3:0] SYNTHESIZED_WIRE_26;
wire	SYNTHESIZED_WIRE_28;
wire	SYNTHESIZED_WIRE_29;
wire	SYNTHESIZED_WIRE_30;
wire	SYNTHESIZED_WIRE_31;
wire	SYNTHESIZED_WIRE_35;
wire	SYNTHESIZED_WIRE_38;
wire	SYNTHESIZED_WIRE_39;
wire	SYNTHESIZED_WIRE_40;
wire	[15:0] SYNTHESIZED_WIRE_42;
wire	[15:0] SYNTHESIZED_WIRE_43;
wire	[15:0] SYNTHESIZED_WIRE_44;
wire	[15:0] SYNTHESIZED_WIRE_45;
wire	[15:0] SYNTHESIZED_WIRE_46;

assign	CU2_haslast = SYNTHESIZED_WIRE_29;
assign	CU3_haslast = SYNTHESIZED_WIRE_30;
assign	CU4_haslast = SYNTHESIZED_WIRE_31;
assign	CU1_lrunwo = SYNTHESIZED_WIRE_35;
assign	CU1_haslast = SYNTHESIZED_WIRE_28;
assign	firstread = SYNTHESIZED_WIRE_48;
assign	writing = SYNTHESIZED_WIRE_47;
assign	done_read = SYNTHESIZED_WIRE_51;
assign	CU1_curr = SYNTHESIZED_WIRE_42;
assign	CU1_lrun = SYNTHESIZED_WIRE_46;
assign	CU2_curr = SYNTHESIZED_WIRE_43;
assign	CU3_curr = SYNTHESIZED_WIRE_44;
assign	CU4_curr = SYNTHESIZED_WIRE_45;
assign	dout_pipe = SYNTHESIZED_WIRE_3;




comp_unit	b2v_inst(
	.clk(clk),
	.reset(reset),
	.writing(SYNTHESIZED_WIRE_47),
	.first_read_i(SYNTHESIZED_WIRE_48),
	.start(SYNTHESIZED_WIRE_49),
	.din(SYNTHESIZED_WIRE_3),
	.l_run_len_i(SYNTHESIZED_WIRE_4),
	.l_run_val_i(SYNTHESIZED_WIRE_5),
	.l_run_wo(SYNTHESIZED_WIRE_35),
	.en_next(SYNTHESIZED_WIRE_50),
	.has_last(SYNTHESIZED_WIRE_28),
	.curr_out(SYNTHESIZED_WIRE_42),
	.dout_next(SYNTHESIZED_WIRE_9),
	.l_run_dout(SYNTHESIZED_WIRE_46),
	.l_run_len_o(SYNTHESIZED_WIRE_10),
	.l_run_val_o(SYNTHESIZED_WIRE_11),
	.offset_o(SYNTHESIZED_WIRE_12));


comp_unit_x	b2v_inst10(
	.clk(clk),
	.reset(reset),
	.writing(SYNTHESIZED_WIRE_47),
	.enabled(SYNTHESIZED_WIRE_50),
	.done_read(SYNTHESIZED_WIRE_51),
	.din(SYNTHESIZED_WIRE_9),
	.l_run_len_i(SYNTHESIZED_WIRE_10),
	.l_run_val_i(SYNTHESIZED_WIRE_11),
	.offset_i(SYNTHESIZED_WIRE_12),
	.en_next(SYNTHESIZED_WIRE_52),
	.has_last(SYNTHESIZED_WIRE_29),
	.zerofilled(SYNTHESIZED_WIRE_38),
	.curr_out(SYNTHESIZED_WIRE_43),
	.dout_next(SYNTHESIZED_WIRE_16),
	.l_run_len_o(SYNTHESIZED_WIRE_17),
	.l_run_val_o(SYNTHESIZED_WIRE_18),
	.offset_o(SYNTHESIZED_WIRE_19));


comp_unit_x	b2v_inst11(
	.clk(clk),
	.reset(reset),
	.writing(SYNTHESIZED_WIRE_47),
	.enabled(SYNTHESIZED_WIRE_52),
	.done_read(SYNTHESIZED_WIRE_51),
	.din(SYNTHESIZED_WIRE_16),
	.l_run_len_i(SYNTHESIZED_WIRE_17),
	.l_run_val_i(SYNTHESIZED_WIRE_18),
	.offset_i(SYNTHESIZED_WIRE_19),
	.en_next(SYNTHESIZED_WIRE_53),
	.has_last(SYNTHESIZED_WIRE_30),
	.zerofilled(SYNTHESIZED_WIRE_39),
	.curr_out(SYNTHESIZED_WIRE_44),
	.dout_next(SYNTHESIZED_WIRE_23),
	.l_run_len_o(SYNTHESIZED_WIRE_24),
	.l_run_val_o(SYNTHESIZED_WIRE_25),
	.offset_o(SYNTHESIZED_WIRE_26));


comp_unit_x	b2v_inst12(
	.clk(clk),
	.reset(reset),
	.writing(SYNTHESIZED_WIRE_47),
	.enabled(SYNTHESIZED_WIRE_53),
	.done_read(SYNTHESIZED_WIRE_51),
	.din(SYNTHESIZED_WIRE_23),
	.l_run_len_i(SYNTHESIZED_WIRE_24),
	.l_run_val_i(SYNTHESIZED_WIRE_25),
	.offset_i(SYNTHESIZED_WIRE_26),
	
	.has_last(SYNTHESIZED_WIRE_31),
	.zerofilled(SYNTHESIZED_WIRE_40),
	.curr_out(SYNTHESIZED_WIRE_45),
	
	.l_run_len_o(SYNTHESIZED_WIRE_4),
	.l_run_val_o(SYNTHESIZED_WIRE_5)
	);


pipe_read	b2v_inst18(
	.clk(clk),
	.reset(reset),
	.writing(SYNTHESIZED_WIRE_47),
	.start(start),
	.message_addr(message_addr),
	.message_size(message_size),
	.port_A_data_out(datain),
	
	.firstread(SYNTHESIZED_WIRE_48),
	.done_read(SYNTHESIZED_WIRE_51),
	.started(SYNTHESIZED_WIRE_49),
	.dout(SYNTHESIZED_WIRE_3),
	.port_A_addr(port_A_addr_read));


pipe_write	b2v_inst21(
	.clk(clk),
	.reset(reset),
	.CU1_haslast(SYNTHESIZED_WIRE_28),
	.CU2_haslast(SYNTHESIZED_WIRE_29),
	.CU3_haslast(SYNTHESIZED_WIRE_30),
	.CU4_haslast(SYNTHESIZED_WIRE_31),
	.CU2_en(SYNTHESIZED_WIRE_50),
	.CU3_en(SYNTHESIZED_WIRE_52),
	.CU4_en(SYNTHESIZED_WIRE_53),
	.lrun_wo(SYNTHESIZED_WIRE_35),
	.done_read(SYNTHESIZED_WIRE_51),
	.first_read(SYNTHESIZED_WIRE_48),
	.CU2_zero(SYNTHESIZED_WIRE_38),
	.CU3_zero(SYNTHESIZED_WIRE_39),
	.CU4_zero(SYNTHESIZED_WIRE_40),
	.started(SYNTHESIZED_WIRE_49),
	.CU1_curr(SYNTHESIZED_WIRE_42),
	.CU2_curr(SYNTHESIZED_WIRE_43),
	.CU3_curr(SYNTHESIZED_WIRE_44),
	.CU4_curr(SYNTHESIZED_WIRE_45),
	.lrun(SYNTHESIZED_WIRE_46),
	.rle_addr(rle_addr),
	.writing(SYNTHESIZED_WIRE_47),
	.done_write(done_write),
	.dout(dataout),
	.port_A_addr(port_A_addr_write),
	.rle_size(rle_size));


endmodule
