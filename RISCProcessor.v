`timescale 1ns / 1ps
/*********************************************************************************
 *
 * Author:		Sean Masterson
 *					Raul Cabral
 * Email:		sean.masterson@student.csulb.edu
 *					raul.cabral@student.csulb.edu
 * Filename:	RISCProcessor.v
 * Date:			May 6, 2019
 * Version:		1
 *
 * Notes:		This is the RISC Processor module that connects the inputs and outputs
 *					of the CPU_EU and CU modules with each other. 'step_clk_debounced' is
 *					used as an input for both modules and controls when an instruction is
 *					executed. 'reset' is used as the input for both modules. 'D_out' is
 *					the output from the integer data path module within the CPU_EU module.
 *					'Address' is the output from the CPU_EU representing an an address to
 *					be read from memory. 'W_Adr' represents an address in the register
 *					file that data will be written to. 'R_Adr' and 'S_Adr' represent
 *					addresses in the register file that data will be read from. 'status'
 *					represents the current instruction that the RISC processor is
 *					executing and N, Z, C. 'Alu_Op' represents what operation of the ALU
 *					located within CPU_EU will be performed. When 'rw_en' is true, the
 *					data specified by 'D_out' will be written at location 'W_adr' in the
 *					register file. 'ALU_Status' represents the values N, Z, and C.
 *					'rw_en', 's_sel', 'adr_sel', 'pc_sel', 'pc_ld', 'pc_inc', 'ir_ld' are
 *					all local 1-bit wires that are outputs from the CU used as inputs for
 *					the CPU_EU.
 *					
 **********************************************************************************/
 
module RISCProcessor(
	input reset, step_clk_debounced,
	
	input [15:0] D_in,
	output [15:0] Address, D_out,
	output mw_en,
	output [7:0] status
    );
	
	// local wires
	wire [15:0] ir_out;
	wire [3:0] Alu_Op;
	wire [2:0] W_Adr, R_Adr, S_Adr, ALU_Status; // ALU_Status = N, Z, C
	wire rw_en, s_sel, adr_sel, pc_sel, pc_ld, pc_inc, ir_ld;
								
	CPU_EU cpueu (.clk(step_clk_debounced), // input
					.reset(reset),
					.W_Adr(W_Adr),
					.R_Adr(R_Adr),
					.S_Adr(S_Adr),
					.Alu_Op(Alu_Op),
					.W_En(rw_en),
					.S_Sel(s_sel),
					.adr_sel(adr_sel),
					.D_in(D_in), // input
					.pc_sel(pc_sel),
					.pc_ld(pc_ld),
					.pc_inc(pc_inc),
					.ir_ld(ir_ld),
					.Address(Address), // output
					.D_out_idp(D_out), // output
					.ir_out(ir_out),
					.ALU_Status(ALU_Status));
					
	cu fsm (.clk(step_clk_debounced), // input
			.reset(reset), // input
			.IR(ir_out),
			.N(ALU_Status[2]),
			.Z(ALU_Status[1]),
			.C(ALU_Status[0]),
			.W_Adr(W_Adr),
			.R_Adr(R_Adr),
			.S_Adr(S_Adr),
			.adr_sel(adr_sel),
			.s_sel(s_sel),
			.pc_ld(pc_ld),
			.pc_inc(pc_inc), 
			.pc_sel(pc_sel),
			.ir_ld(ir_ld),
			.mw_en(mw_en), // output
			.rw_en(rw_en), 
			.alu_op(Alu_Op),
			.status(status)); // output
			
endmodule
