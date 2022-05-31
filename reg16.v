`timescale 1ns / 1ps
/*********************************************************************************
 *
 * Author:		Sean Masterson
 *					Raul Cabral
 * Email:		sean.masterson@student.csulb.edu
 *					raul.cabral@student.csulb.edu
 * Filename:	reg16.v
 * Date:			May 6, 2019
 * Version:		1
 *
 * Notes:		This module is a 16-bit register with an asynchronous reset and a
 *					synchronous load for the 16-bit Din input. The register has two 16
 *					bit output ports (DA and DB) for use in reading the current value
 *					stored. Both output ports have tri-state outputs that are controlled
 *					by the respective output enable (oeA and oeB). At the positive edge
 *					of the clock, if ld is enabled, then the current value stored in Dout
 *					be assigned to the value stored in the input Din, else it will 
 *					maintain its curent value. At the positive edge of reset, Dout is set
 *					is set to 0.
 *
 **********************************************************************************/

module reg16(
    input clk,
    input reset,
    input ld,
    input [15:0] Din,
	input oeA,
    input oeB,
    output [15:0] DA,
    output [15:0] DB
    );
	 
	reg [15:0] Dout;
	 
	// Behavioral section for writing to the register
	always @(posedge clk, posedge reset)
	   if (reset)
	       Dout <= 16'b0;
	   else
	       if (ld)
	       Dout <= Din;
	       else Dout <= Dout;
	
    // Conditional continuous assignments for reading the register.
	assign DA = oeA ? Dout : 16'hz;
	assign DB = oeB ? Dout : 16'hz;

endmodule
