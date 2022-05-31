`timescale 1ns / 1ps
 /*********************************************************************************
 *
 * Author:		Sean Masterson
 *					Raul Cabral
 * Email:		sean.masterson@student.csulb.edu
 *					raul.cabral@student.csulb.edu
 * Filename:	alu16.v
 * Date:			May 6, 2019
 * Version:		1
 *
 * Notes:		This is a 16-bit ALU which accepts two 16 bit inputs: R and S.
 *					It has 13 functions. The function performed is dependent on the 
 *					value of the 4-bit input 'Alu_Op'. Calculations based on the values 
 *					R and S are performed and the resulting outputs Y (output), N
 *					(negative), Z (zero), and C (carry) are computed.
 *					
 **********************************************************************************/

module alu16(
    input [15:0] R,
    input [15:0] S,
    input [3:0] Alu_Op,
    output reg [15:0] Y,
    output reg N,
    output reg Z,
    output reg C
    );
    
    always @(R or S or Alu_Op) begin
        case (Alu_Op)
            4'b0000: {C,Y} = {1'b0, S};             // Pass S
            4'b0001: {C,Y} = {1'b0, R};             // Pass R
            4'b0010: {C,Y} = S + 1;                 // Increment S          
            4'b0011: {C,Y} = S - 1;                 // Decrement S  
            4'b0100: {C,Y} = R + S;                 // Add  
            4'b0101: {C,Y} = R - S;                 // Subtract  
            4'b0110: {C,Y} = {S[0], 1'b0,S[15:1]};  // Right Shift S
            4'b0111: {C,Y} = {S[15], S[14:0],1'b0}; // Left Shift S
            4'b1000: {C,Y} = {1'b0, R & S};         // Logic and
            4'b1001: {C,Y} = {1'b0, R | S};         // Logic or
            4'b1010: {C,Y} = {1'b0, R ^ S};         // Logic xor
            4'b1011: {C,Y} = {1'b0, ~S};            // Logic not S (1's comp)
            4'b1100: {C,Y} = 0 - S;                 // Negate S
            default: {C,Y} = {1'b0, S};             // Pass S for default
        endcase
        
        // Handle last two status flags
        N = Y[15];
        if (Y == 16'b0)
            Z = 1'b1;
        else 
            Z = 1'b0;
            
    end            
    
endmodule
