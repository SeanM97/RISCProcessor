`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineers: Raul Cabral, Sean Masterson
// 
// Filename: Display_Controller.v
// Module Name: Display_Controller
// Project Name: RegisterFiles 
// Description: This module is a display controller that instantiates four modules.
//	 				 It instantiates the pixel_clock, pixel _ontroller, ad_mux and the 
// 				 hexto7segment module and connects them accordingly. The output clock
// 				 of the pixel_clk is the input clock of the pixel_controller. Seg_sel
// 				 is shared from the pixel_controller to the ad_mux. The outputs of
// 				 the ad_mux are the inputs to the hexto7segment. 
//////////////////////////////////////////////////////////////////////////////////

module Display_Controller(
    input clk,
    input reset,
    input [3:0] seg7,
    input [3:0] seg6,
    input [3:0] seg5,
    input [3:0] seg4,
    input [3:0] seg3,
    input [3:0] seg2,
    input [3:0] seg1,
    input [3:0] seg0,
    output a7, a6, a5, a4, a3, a2, a1, a0,
    output a, b, c, d, e, f, g
    );
	 
	 wire [3:0] Y;
	 wire [2:0] seg_sel;
	 
	 pixel_clk  pixel_clock (.reset(reset), 
                      .clk_in(clk), 
                      .clk_out(clk_480));
							 
    pixel_controller  pix_controller (.clk(clk_480), 
                             .reset(reset), 
                             .a0(a0), 
                             .a1(a1), 
                             .a2(a2), 
                             .a3(a3), 
                             .a4(a4), 
                             .a5(a5), 
                             .a6(a6), 
                             .a7(a7), 
                             .seg_sel(seg_sel));
									  
	 ad_mux multiplexer (.d7(seg7),
								.d6(seg6),
								.d5(seg5),
								.d4(seg4),
								.d3(seg3),
								.d2(seg2),
								.d1(seg1),
								.d0(seg0),
								.sel(seg_sel),
								.Y(Y));
								
	 hexTo7segment hex7seg (.hex(Y),
						.a(a),
						.b(b),
						.c(c),
						.d(d),
						.e(e),
						.f(f),
						.g(g));
	 
endmodule
