`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineers: Raul Cabral, Sean Masterson
// 
// Filename: pixel_controller.v
// Module Name: pixel_controller 
// Project Name: MemoryAndDisplayControllers
// Description: This module generates common anode inputs for the 7-segment 
// 				 displays and it also generates the select signals for the mux.
// 				 The next state logic is derived from the autonomous Finite State
//		 			 Machine, meaning that there are no inputs and that the state is
// 				 always changing. The select signals are just simply being assigned 
// 				 to the present state. 
//////////////////////////////////////////////////////////////////////////////////

module pixel_controller(
    input clk,
    input reset,
    output reg a7,
    output reg a6,
    output reg a5,
    output reg a4,
    output reg a3,
    output reg a2,
    output reg a1,
    output reg a0,
    output [2:0] seg_sel
    );
	 
	 reg [2:0] present_state;
	 reg [2:0] next_state;
	 
	 // Next State Logic
	 always @(present_state)
	 case (present_state)
		3'b000 : next_state = 3'b001;
		3'b001 : next_state = 3'b010;
		3'b010 : next_state = 3'b011;
		3'b011 : next_state = 3'b100;
		3'b100 : next_state = 3'b101;
		3'b101 : next_state = 3'b110;
		3'b110 : next_state = 3'b111;
		3'b111 : next_state = 3'b000;
		default next_state = 3'b000;
	 endcase
	 
	 // State Register Logic
	 always @(posedge clk, posedge reset)
		if (reset == 1'b1)
			present_state = 3'b0;
		else 
			present_state = next_state;
	
	 // Output Logic
	 always @(present_state)
		case (present_state)	// Note: Low Active Signals for Anodes
			3'b000 : {a7, a6, a5, a4, a3, a2, a1, a0} = 8'b1111_1110; // Anode 0 asserted
			3'b001 : {a7, a6, a5, a4, a3, a2, a1, a0} = 8'b1111_1101; // Anode 1 asserted
			3'b010 : {a7, a6, a5, a4, a3, a2, a1, a0} = 8'b1111_1011; // Anode 2 asserted
			3'b011 : {a7, a6, a5, a4, a3, a2, a1, a0} = 8'b1111_0111; // Anode 3 asserted
			3'b100 : {a7, a6, a5, a4, a3, a2, a1, a0} = 8'b1110_1111; // Anode 4 asserted
			3'b101 : {a7, a6, a5, a4, a3, a2, a1, a0} = 8'b1101_1111; // Anode 5 asserted
			3'b110 : {a7, a6, a5, a4, a3, a2, a1, a0} = 8'b1011_1111; // Anode 6 asserted
			3'b111 : {a7, a6, a5, a4, a3, a2, a1, a0} = 8'b0111_1111; // Anode 7 asserted
			default  {a7, a6, a5, a4, a3, a2, a1, a0} = 8'b1111_1110; // Anode 0 asserted
		endcase
	 
	 // Assigning select signals to present state.
	 assign seg_sel = present_state;
		
endmodule
