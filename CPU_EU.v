`timescale 1ns / 1ps
/*********************************************************************************
 *
 * Author:		Sean Masterson
 *					Raul Cabral
 * Email:		sean.masterson@student.csulb.edu
 *					raul.cabral@student.csulb.edu
 * Filename:	CPU_EU.v
 * Date:			May 6, 2019
 * Version:		1
 *
 * Notes:		This is the CPU execution unit module that connects the inputs and
 *					outputs of the PC register, IR register, and integer data path
 *					modules with each other. 'W_En', when enabled, enables writing to the
 *					interger data path register file. 'adr_sel' is used to select
 *					whether the output 'Address' should become either 'Reg_Out' or
 *					'pc_out'. When 'pc_ld' is enabled, the value 'PC_mux' will be
 *					loaded into the PC register. When 'pc_inc' is enabled, the value in
 *					the PC register will be incremented. When 'ir_ld' is enabled, the
 *					value 'D_in' will be loaded into the IR register. 'Alu_Out' is the
 *					output of the ALU and also the input to the register file. 'S_Sel'
 *					determines whether 'S' from the register file is passed or DS is
 *					passed as the the input 'S' to the ALU. 'Alu_Op' determines which
 *					function the ALU will perform. C, N, and Z represent whether the
 *					output of the ALU has a carry value, are negative, or are zero.
 *					When both 'pc_ld' and 'pc_inc' are either both enabled or disabled,
 *					the value in the PC register remains unchanged. The IR register
 *					is never incremented and is given a value of 0 for its 'inc' input.
 *					When 'pc_sel' is enabled, 'PC_mux' is assigned the value 'D_out_idp',
 *					otherwise it is assigned 'add_out'. 'SignExt' holds the value stored
 *					by 'ir_out' with the MSB of 'ir_out' repeated 8 times in the first
 *					8 bits of 'SignExt'. 'ALU_Status' holds values C, N, and Z. 'add_out'
 *					represents the result of addition of 'pc_out' and 'SignExt'.
 *					
 **********************************************************************************/

module CPU_EU(
    input clk, reset,
	 
	 input [2:0] W_Adr, R_Adr, S_Adr,
	 input [3:0] Alu_Op,
	 
    input W_En,
    input S_Sel, adr_sel,
    input [15:0] D_in,
    input pc_sel, pc_ld, pc_inc, ir_ld,
    output [15:0] Address,
    output [15:0] D_out_idp, ir_out,
	 output [2:0] ALU_Status
    );
	 
	wire [15:0] adr_mux, PC_mux, Reg_Out, pc_out, SignExt, add_out;
	wire C, N, Z;
   
	assign ALU_Status = {N, Z, C};
	
	IntegerDataPath idp (.clk(clk),
							.reset(reset),
							.W_En(W_En),
							.W_Adr(W_Adr),
							.R_Adr(R_Adr),
							.S_Adr(S_Adr),
							.DS(D_in),
							.S_Sel(S_Sel),
							.Alu_Op(Alu_Op),
							.Reg_Out(Reg_Out),
							.Alu_Out(D_out_idp),
							.C(C),
							.N(N),
							.Z(Z));
								 
	assign adr_mux = (adr_sel == 0) ? pc_out : Reg_Out;
	assign PC_mux = (pc_sel == 0) ? add_out : D_out_idp;
	assign Address = adr_mux;
	
	assign SignExt = {{8{ir_out[7]}}, ir_out[7:0]};
	assign add_out = SignExt + pc_out;
    
	reg16_inc_ld PC (.clk(clk),
						.reset(reset),
						.ld(pc_ld),
						.inc(pc_inc),
						.D(PC_mux),
						.Q(pc_out));
	
	reg16_inc_ld IR (.clk(clk),
						.reset(reset),
						.ld(ir_ld),
						.inc(1'b0),
						.D(D_in),
						.Q(ir_out));

endmodule
