`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    00:22:10 11/03/2014
// Design Name:
// Module Name:    Input_2_32bit
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module   Enter(input  wire       clk,
                input  wire[4:0] BTN,	 // äº”ä¸ªæŒ‰é”®
                input  wire[15:0] SW, // ï¿??ï¿??
                output wire[4:0] BTN_out,
                output wire[15:0] SW_out // ï¿??ï¿??
            );
	// TODO é˜²æŠ–

    // always @(*) begin
    //     BTN_out = BTN;
    //     SW_out = SW;
    // end

    assign BTN_out = BTN;
    assign SW_out = SW;

endmodule
