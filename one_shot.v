`timescale 1ns / 1ps
/*********************************************************************************
 *
 * Author:		Sean Masterson
 * Email:		sean.masterson@student.csulb.edu
 * Filename:	one_shot.v
 * Date:			May 6, 2019
 * Version:		1
 *
 * Notes:		clk_in is not the clock of the board but rather the clock created by
 *					the module clk_500hz. The frequency is expected to be 500 Hz or else
 *					the length of the pulse will vary and time until stabilization will
 *					not be correct. At 500 Hz, the time between each clk_in is 2 ms.
 *
 **********************************************************************************/
module one_shot(clk_in, reset, D_in, D_out);
	 
	input clk_in;
    input reset;
    input D_in;	// 1-bit Input
    output D_out;	// 1-bit Output

	 wire D_out;
	 
	 // The following template provides a one-shot pulse
	 // from a non-clock input (D_in)
	 //	input D_in, clk_in, reset;
	 //	output D_out;
	 //	wire D_out;
	 
	 reg q9, q8, q7, q6, q5, q4, q3, q2, q1, q0;
	 
	 always @ (posedge clk_in or posedge reset)
		if (reset == 1'b1)
			{q9, q8, q7, q6, q5, q4, q3, q2, q1, q0} <= 10'b0;
			else begin
				// shift in the new sample that's on the D_in input
				q9 <= q8; q8 <= q7; q7 <= q6; q6 <= q5; q5 <= q4;
				q4 <= q3; q3 <= q2; q2 <= q1; q1 <= q0; q0 <= D_in;
			end
	 
		// create the debounded, one-shot output pulse
		assign D_out = !q9 & q8 & q7 & q6 & q5 &
							q4 & q3 & q2 & q1 & q0;
	 

endmodule
