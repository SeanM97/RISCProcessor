`timescale 1ns / 1ps
/*********************************************************************************
 *
 * Author:		Sean Masterson
 *					Raul Cabral
 * Email:		sean.masterson@student.csulb.edu
 *					raul.cabral@student.csulb.edu
 * Filename:	top_level_verilog.v
 * Date:			May 6, 2019
 * Version:		1
 *
 * Notes:		This is the top level module that connects the inputs and outputs of
 *					the clock divider, button debouncers, display controller, RISC
 *					processor, and ram1 modules with each other. 'clk_500' is the 500 Hz
 *					clock created by the clock divider. The debouncers takes the inputs
 *					'step_clk', 'step_mem', and 'clk_500' and the outputs are the wires
 *					'step_clk_debounced' and 'step_mem_debounced'. 'clk_100MHz' must be 
 *					100 MHz or else the clock divider won't work correctly. 'reset' is
 *					used as the input for all modules except the ram1 module. 'D_out_idp'
 *					is the output from the integer data path module within the CPU_EU
 *					within the RISC processor module, which is used as the input for din
 *					of the ram1 module. 'Address' is the output from the CPU_EU that will
 *					be the address read from the 256x16 ram module. When 'dump_mem' is
 *					true, the address currently being read from memory will change to
 *					'mem_counter'. 'D_out_memory' is the data stored in the 256x16 at
 *					the memory location specified by 'madr'. 'status' represents the
 *					current instruction that the RISC processor is executing. Every time
 *					'step_mem_debounced' is true, a 16-bit register called 'mem_counter'
 *					is incremented by one, and is reset to 0 when reset is true.
 *					
 **********************************************************************************/

module top_level_verilog(clk_100MHz, 
								reset,
								step_mem,
								step_clk,
								dump_mem,
								a0, a1, a2, a3, a4, a5, a6, a7,
								a, b, c, d, e, f, g,
								status
								);
								
	input clk_100MHz, reset, step_mem, step_clk, dump_mem;
	
	output a0, a1, a2, a3, a4, a5, a6, a7;
   output a, b, c, d, e, f, g;
	output [7:0] status;
    
	wire [15:0] D_out_idp, Address, D_out_memory, madr;
	wire clk_500, step_clk_debounced, step_mem_debounced;

	reg [15:0] mem_counter;
	
	RISCProcessor risc (.step_clk_debounced(step_clk_debounced),
							.reset(reset),
							.D_in(D_out_memory),
							.Address(Address),
							.D_out(D_out_idp),
							.mw_en(mw_en),
							.status(status));
	
	assign madr = dump_mem ? mem_counter : Address;
	
	ram1 mem(.addr(madr), 
            .clk(clk_100MHz),
            .din(D_out_idp), 
            .we(mw_en), 
            .dout(D_out_memory));
				
	Display_Controller display_controller (.clk(clk_100MHz), 
										 .reset(reset),
										 .seg7(madr[15:12]),
										 .seg6(madr[11:8]),
										 .seg5(madr[7:4]),
										 .seg4(madr[3:0]),
										 .seg3(D_out_memory[15:12]),
										 .seg2(D_out_memory[11:8]),
										 .seg1(D_out_memory[7:4]),
										 .seg0(D_out_memory[3:0]),
										 .a7(a7),
										 .a6(a6),
										 .a5(a5),
										 .a4(a4),
										 .a3(a3),
										 .a2(a2),
										 .a1(a1),
										 .a0(a0),
										 .a(a),
										 .b(b),
										 .c(c),
										 .d(d),
										 .e(e), 
										 .f(f),
										 .g(g));
	
	clk_500hz  clk_divider (.clk(clk_100MHz), 
								.reset(reset), 
								.clk_out(clk_500));
							
	one_shot step_clk_debounced_ (.clk_in(clk_500),
										.reset(reset),
										.D_in(step_clk),
										.D_out(step_clk_debounced));
	
	one_shot step_mem_debounced_ (.clk_in(clk_500),
										.reset(reset),
										.D_in(step_mem),
										.D_out(step_mem_debounced));
										
	always@(posedge reset or posedge step_mem_debounced)
		if (reset == 1'b1)
			mem_counter <= 16'h00;
		else
			mem_counter <= mem_counter + 16'h01;
		
    
endmodule
