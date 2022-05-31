`timescale 1ns / 1ps
/*********************************************************************************
 *
 * Author:		Sean Masterson
 * Email:		sean.masterson@student.csulb.edu
 * Filename:	hexTo7Segment.v
 * Date:			May 6, 2019
 * Version:		1
 *
 * Notes:		This is a 4 to 16 decoder. The input is 'hex' representing a 4-bit
 *					binary number (hex). A case statement is used to check every
 *					combination of bits in hex, and the outputs 'a' through 'f' are
 *					assigned values corresponding to 7 bits that represent how each
 *					number would be displayed on a 7 segment display active low. The
 *					default case assigns a through f a sequence of bits representing
 *					the display showing nothing at all.
 *
 **********************************************************************************/
module hexTo7segment(hex, a, b, c, d, e, f, g);
    input [3:0] hex;
    output a, b, c, d, e, f, g;

	assign {a, b, c, d, e, f, g} = ( hex == 4'b0000) ? 7'b0000001 :
											( hex == 4'b0001) ? 7'b1001111 :
											( hex == 4'b0010) ? 7'b0010010 :
											( hex == 4'b0011) ? 7'b0000110 :
											( hex == 4'b0100) ? 7'b1001100 :
											( hex == 4'b0101) ? 7'b0100100 :
											( hex == 4'b0110) ? 7'b0100000 :
											( hex == 4'b0111) ? 7'b0001111 :
											( hex == 4'b1000) ? 7'b0000000 :
											( hex == 4'b1001) ? 7'b0000100 :
											( hex == 4'b1010) ? 7'b0001000 :
											( hex == 4'b1011) ? 7'b1100000 :
											( hex == 4'b1100) ? 7'b0110001 :
											( hex == 4'b1101) ? 7'b1000010 :
											( hex == 4'b1110) ? 7'b0110000 :
											( hex == 4'b1111) ? 7'b0111000 :
																		7'b1111111;
												
endmodule
