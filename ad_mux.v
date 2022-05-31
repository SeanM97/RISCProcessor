`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineers: Raul Cabral, Sean Masterson
// 
// Filename: ad_mux.v
// Module Name: ad_mux
// Project Name: MemoryAndDisplayControllers
// Description: This module is an 8 to 1 multiplexer with inputs being 4-bit wide
// 				 d7 through d0, a 3-bit wide input select and a 4-bit wide output
// 				 named Y. Given the select bits, Y would get the designated d input.
// 				 For instance, if the select bits were 3'b110, Y would end up 
// 				 getting the 7th d input which, in this case, is d6. The default
// 				 case being d0. The data that is being multiplexed here is the 
// 				 address information.  
//////////////////////////////////////////////////////////////////////////////////

module ad_mux(
    input [3:0] d7,
    input [3:0] d6,
    input [3:0] d5,
    input [3:0] d4,
    input [3:0] d3,
    input [3:0] d2,
    input [3:0] d1,
    input [3:0] d0,
    input [2:0] sel,
    output reg [3:0] Y
    );
	 
	 always @(*)
	 case (sel)
		3'b000: Y <= d0;
		3'b001: Y <= d1;
		3'b010: Y <= d2;
		3'b011: Y <= d3;
		3'b100: Y <= d4;
		3'b101: Y <= d5;
		3'b110: Y <= d6;
		3'b111: Y <= d7;
		default : Y <= d0;
	 endcase

endmodule
