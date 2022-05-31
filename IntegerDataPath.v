`timescale 1ns / 1ps
/*********************************************************************************
 *
 * Author:		Sean Masterson
 *					Raul Cabral
 * Email:		sean.masterson@student.csulb.edu
 *					raul.cabral@student.csulb.edu
 * Filename:	IntegerDataPath.v
 * Date:			May 6, 2019
 * Version:		1
 *
 * Notes:		This is the Integer Data Path module that connects the inputs and
 *					outputs of the register file, multiplexer, and ALU with each other. 
 *					'W_Addr' represents an address that data may get written to. 'S_Addr'
 *					and 'R_Addr' represent addresses that data will get read from. 
 *					'Alu_Op' is the output of the ALU and also the input to the register 
 *					file. 'S_Sel' is the data select input for the multiplexer that
 *					determines whether 'S' from the register file or 'DS' will become the
 *					input of 'S' of the ALU. 'Reg_Out' is solely dependent on 'R_Adr'
 *					while 'Alu_Out' is dependent on 'S_Sel', 'S_Adr', and 'Alu_Op'.
 *					C, N, and Z are for carry, negative, and zero.
 *					
 **********************************************************************************/
module IntegerDataPath(
    input clk,
    input reset,
    input W_En,
    input [2:0] W_Adr,
    input [2:0] R_Adr,
    input [2:0] S_Adr,
    input [15:0] DS,
    input S_Sel,
    input [3:0] Alu_Op,
    output wire [15:0] Reg_Out,
    output [15:0] Alu_Out,
    output C,
    output N,
    output Z
	 );
   
    wire [15:0] S;
    wire [15:0] S_Mux;
	
    RegisterFile RegisterFile (clk,
										reset,
										Alu_Out,
										W_Adr,
										W_En,
										R_Adr,
										S_Adr,
										Reg_Out,
										S);
										
    assign S_Mux = (S_Sel == 0) ? S : DS;
    alu16 alu (Reg_Out, S_Mux, Alu_Op, Alu_Out, N, Z, C);
    
endmodule
