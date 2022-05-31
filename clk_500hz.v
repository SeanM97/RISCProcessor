`timescale 1ns / 1ps
/*********************************************************************************
 *
 * Author:		Sean Masterson
 * Email:		sean.masterson@student.csulb.edu
 * Filename:	clk_500hz.v
 * Date:			May 6, 2019
 * Version:		1
 *
 * Notes:		This module divides the incoming clock frequency by 200000. The
 *					clock is expected to have a frequency of 100 MHz should make the
 *					the divided clock (clk_out) have a frequency of 500 Hz.
 *
 **********************************************************************************/
module clk_500hz(clk, reset, clk_out);
	 
	 input	clk, reset;
	 output	clk_out;
	 reg		clk_out;
	 integer i;
	 
	 //**************************************************************
	 // The following verilog code will "divide" an incoming clock
	 // by the 32-bit decimal value specified in the "if condition"
	 //
	 // The value of the counter that counts the incoming clock ticks
	 // is equal to [ (Incoming Freq / Outgoing Freq) / 2]
	 //**************************************************************

	always @(posedge clk or posedge reset) begin
		if (reset == 1'b1) begin
			i = 0;
			clk_out = 0;
		end
		// got a clock, so increment the counter and
		// test to see if half a period has elapsed
		else begin
			i = i + 1;
				if (i >= 100000) begin
					clk_out = ~clk_out;	// 1/2 a clock cycle occurs for every clk in
					i = 0;
				end // if
			end // else
			
		end // always
		
endmodule
