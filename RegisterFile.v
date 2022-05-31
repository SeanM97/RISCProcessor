`timescale 1ns / 1ps
/*********************************************************************************
 *
 * Author:		Sean Masterson
 *					Raul Cabral
 * Email:		sean.masterson@student.csulb.edu
 *					raul.cabral@student.csulb.edu
 * Filename:	Register_file.v
 * Date:			May 6, 2019
 * Version:		1
 *
 * Notes:		This module creaste an 8x16 register file in which data can be read
 *					and written to. It instantiates 8 instances of reg16 and three 
 *					instances of a 3-to-8 decoder. One decoder takes W_Adr as an input, 
 *					another takes R_Adr, and another takes S_Adr. The decoder that takes
 *					W_Adr as an an input is only enabled when we is enabled, while the
 *					other decoders are always on. The outputs of decoders is 8 bits in 
 *					which the one of the 8 bits is active and the rest are inactive. The 
 *					nth bit of the decoder's output is active where n is value of the 
 *					input of the decoder in hex. The outputs of the decoders are used as 
 *					the inputs for the each reg16 file with each instance getting a 
 *					different bit from each output of the three decoders.
 *
 **********************************************************************************/
 
module RegisterFile(
    input clk, reset,
    input [15:0] W,
    input wire [2:0] W_Adr,
    input we,
    input wire [2:0] R_Adr,
    input wire [2:0] S_Adr,
    output [15:0] R,
    output [15:0] S
    );
	 
	wire Wy7,Wy6,Wy5,Wy4,Wy3,Wy2,Wy1,Wy0;
	wire Ry7,Ry6,Ry5,Ry4,Ry3,Ry2,Ry1,Ry0;
	wire Sy7,Sy6,Sy5,Sy4,Sy3,Sy2,Sy1,Sy0;
	 
	reg16 r7 (clk, reset, Wy7, W, Ry7, Sy7, R, S);
	reg16 r6 (clk, reset, Wy6, W, Ry6, Sy6, R, S);
	reg16 r5 (clk, reset, Wy5, W, Ry5, Sy5, R, S);
	reg16 r4 (clk, reset, Wy4, W, Ry4, Sy4, R, S);
	reg16 r3 (clk, reset, Wy3, W, Ry3, Sy3, R, S);
	reg16 r2 (clk, reset, Wy2, W, Ry2, Sy2, R, S);
	reg16 r1 (clk, reset, Wy1, W, Ry1, Sy1, R, S);
	reg16 r0 (clk, reset, Wy0, W, Ry0, Sy0, R, S);
	 
	dec_3to8 d2 (W_Adr,  we, Wy7, Wy6, Wy5, Wy4, Wy3, Wy2, Wy1, Wy0);
	dec_3to8 d1 (R_Adr, 1'b1, Ry7, Ry6, Ry5, Ry4, Ry3, Ry2, Ry1, Ry0);
	dec_3to8 d0 (S_Adr, 1'b1, Sy7, Sy6, Sy5, Sy4, Sy3, Sy2, Sy1, Sy0);
	 
endmodule
