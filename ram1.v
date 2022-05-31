`timescale 1ns / 1ps
/*********************************************************************************
 *
 * Author:		Sean Masterson
 *					Raul Cabral
 * Email:		sean.masterson@student.csulb.edu
 *					raul.cabral@student.csulb.edu
 * Filename:	ram1.v
 * Date:			May 6, 2019
 * Version:		1
 *
 * Notes:		This is the 256x16 RAM module. There are 256 address locations, each
 *					with a width of 16 bits. To access the locations, an 8 bit input is
 *					used as to access which of the 256 locations to access. The data at
 *					at each location can be modified when a 'we' input is enabled, which
 *					sets the current data at the RAM location being access to the value
 *					of the 16-bit din. The 16-bits of data currently being accessed is
 *					outputted as dout. clk must be the 100 MHz clk or else it might not
 *					work correctly.
 *
 **********************************************************************************/
module ram1(addr, 
            clk, 
            din, 
            we, 
            dout);

    input [7:0] addr;
    input clk;
    input [15:0] din;
    input we;
   output [15:0] dout;
	
	//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
	ram_256x16 dut (
	  .clka(clk), // input clka
	  .wea(we), // input [0 : 0] wea
	  .addra(addr), // input [7 : 0] addra
	  .dina(din), // input [15 : 0] dina
	  .douta(dout) // output [15 : 0] douta
	);
   
endmodule
