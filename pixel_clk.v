`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////////////////
// Engineers: Raul Cabral, Sean Masterson
// 
// Filename: pixel_clk.v
// Module Name: pixel_clk 
// Project Name: MemoryAndDisplayControllers 
// Description: This module takes in a 100MHz clock and 'divides' it to output a
// 				 480Hz clock. The module needs a reset an input clock, 100Mhz, 
// 				 in this case, and an output clock, 480Hz. In order to do this,
//					 we need an equation that is equal to half the period of the output 
// 				 clock. The equation is as follows, [(Incoming Freq/Outgoing Freq)/2].
//					 The calculated value is used in the counter such that the outgoing 
// 				 clock is negated every half a period, or every 240Hz. This module  
//					 is needed in order to control the frequency of the clock for the 
// 				 pixel_controller module to work off of.
//////////////////////////////////////////////////////////////////////////////////

module pixel_clk(reset, clk_in, clk_out);
	input reset, clk_in;
	output clk_out;
	
	reg clk_out;
	integer 	i;
	
	always @(posedge clk_in, posedge reset)begin
		if(reset == 1'b1)
		begin
			i = 0;
			clk_out = 0;
		end
		// Got a clock, so increment the counter and
		// test to see if half a period has elapsed
		else begin
			i = i + 1;
			if(i >= 17'd104166) begin
				clk_out = ~clk_out;
				i = 0;
				end //if
			end//else
		end //always
		
endmodule

