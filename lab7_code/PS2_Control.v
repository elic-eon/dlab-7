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
reg [21:0] ARRAY;
reg [10:0] ball_x_w;
reg [10:0] ball_y_w;
reg  [1:0] color_w;
reg  [1:0] color_t;
reg  [1:0] color_t_w;

always @ (posedge CLK) begin
	if(reset) begin
		KCLK_P <= 0;
		KCLK_C <= 0;
    ARRAY  <= 22'b11_0000_0000_0_11_0000_0000_0;
  end else begin
		KCLK_P <= KCLK_C;
		KCLK_C <= PS2_CLK;
    ARRAY  <= ARRAY;
    if(KCLK_P > KCLK_C) begin
			//		read data
      ARRAY <= {PS2_DATA, ARRAY[21:1]};
    end
  end
end

always @(posedge CLK) begin
  if(reset) begin
    ball_x <= 320;
    ball_y <= 240;
  end else begin
    ball_x <= ball_x_w;
    ball_y <= ball_y_w;
  end
end

always @(ARRAY or ball_y or ball_x or radius) begin
  ball_y_w = ball_y;
  ball_x_w = ball_x;
  if (ARRAY[8:1] == 8'hF0 && {ARRAY[21], ARRAY[11:10], ARRAY[0]} == 4'b1010) begin
    case(ARRAY[19:12])
      8'h75:
      begin
        if ((ball_y + radius * 5) <= 11'd425)
          ball_y_w = ball_y + 11'd5;
      end
      8'h74:
      begin
        if ((ball_x + radius * 5) <= 11'd585)
          ball_x_w = ball_x + 11'd5;
      end
      8'h6B:
      begin
        if (ball_x >= 11'd55 + radius * 5)
          ball_x_w = ball_x - 11'd5;
      end
      8'h72:
      begin
        if (ball_y >= 11'd55 + radius * 5)
          ball_y_w = ball_x - 11'd5;
      end
    endcase
  end
end

always @(posedge CLK) begin
  if (reset) begin
    color   <= 2'd1;
    color_t <= 2'd1;
  end else begin
    color   <= color_w;
    color_t <= color_t_w;
  end
end

always @(ARRAY or color_t or color) begin
  color_t_w = color_t;
  color_w   = color;
  if (ARRAY[8:1] == 8'hF0 && {ARRAY[21], ARRAY[11:10], ARRAY[0]} == 4'b1010) begin
    case(ARRAY[19:12])
      8'h16: color_t_w = 2'd1;
      8'h1E: color_t_w = 2'd2;
      8'h26: color_t_w = 2'd3;
      8'h5A: color_w   = color_t;
    endcase
  end
end

endmodule
