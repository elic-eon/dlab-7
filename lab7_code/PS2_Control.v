`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    13:55:34 04/26/2013
// Design Name:
// Module Name:    PS2_Control
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
module PS2_Control(
  input CLK,
  input PS2_CLK,
  input PS2_DATA,
  input reset,
  input [2:0] radius,
  output reg [1:0] color,
  output reg [10:0] ball_x,
  output reg [10:0] ball_y
);

reg KCLK_P, KCLK_C;

always @ (posedge CLK)
begin
	if(reset)
	begin
		KCLK_P <= 0;
		KCLK_C <= 0;

	end
	else begin
		KCLK_P <= KCLK_C;
		KCLK_C <= PS2_CLK;

if(KCLK_P > KCLK_C)
		begin

			//		read data

		end
	end
end

endmodule
