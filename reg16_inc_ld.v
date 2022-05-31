`timescale 1ns / 1ps
/*********************************************************************************
 *
 * Author:		Sean Masterson
 *					Raul Cabral
 * Email:		sean.masterson@student.csulb.edu
 *					raul.cabral@student.csulb.edu
 * Filename:	reg16_inc_ld.v
 * Date:			May 6, 2019
 * Version:		1
 *
 * Notes:		This is a 16-bit register with the option to load a new value into
 *					register or increment or increment its existing value. When 'ld'
 *					is enabled, the value in 'D' gets loaded into 'Q'. When 'inc' is
 *					enabled, the value in 'Q' is incremented and is loaded into 'Q'. When
 *					both 'inc' and 'ld' are enabled or disabled, then the value in 'Q'
 *					will remain the same. 'reset' will reset the value in 'Q' to 0.
 *					
 **********************************************************************************/

module reg16_inc_ld(
    input clk,
    input reset,
    input ld, inc,
    input [15:0] D,
    output reg [15:0] Q
    );
	 
	// Behavioral section for writing to the register
	always @(posedge clk, posedge reset)
	   if (reset)
			Q <= 16'b0;
		else // got clk
			case ({ld, inc})
				2'b01: Q <= Q + 16'b1;
				2'b10: Q <= D;
				default: Q <= Q;
			endcase

endmodule
