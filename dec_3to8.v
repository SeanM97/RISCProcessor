`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineers: Raul Cabral, Sean Masterson
// 
// Filename: dec_3to8.v
// Module Name: dec_3to8
// Project Name: RegisterFiles 
// Description: This module is a 3 to 8 decoder with an input enable. The outputs
// 				 are being assigned when enable is high. The output pattern is as 
// 				 follows, if the input in is 3'b000, the output is y7 and when the 
// 	          input is 3'b001 then y6 gets selected, etc. with the default case 
// 				 being that no output gets selected. 
//////////////////////////////////////////////////////////////////////////////////

module dec_3to8(
    input [2:0] in,
    input en,
    output y7,
    output y6,
    output y5,
    output y4,
    output y3,
    output y2,
    output y1,
    output y0
    );
	 
	 assign {y7,y6,y5,y4,y3,y2,y1,y0} = ({en, in} == 4'b1000) ? 8'b0000_0001 :
										({en, in} == 4'b1001) ? 8'b0000_0010 :
										({en, in} == 4'b1010) ? 8'b0000_0100 :
										({en, in} == 4'b1011) ? 8'b0000_1000 :
										({en, in} == 4'b1100) ? 8'b0001_0000 :
										({en, in} == 4'b1101) ? 8'b0010_0000 :
										({en, in} == 4'b1110) ? 8'b0100_0000 :
										({en, in} == 4'b1111) ? 8'b1000_0000 :
																8'b0000_0000 ;

endmodule
