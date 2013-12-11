`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    13:52:57 04/26/2013
// Design Name:
// Module Name:    ballgame
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
module ballgame(
  input iCLK_50,
  input iSW3,
  input ROT_A,
  input ROT_B,
  input PS2_CLK,
  input PS2_DATA,
  output wire  oVGA_R,
  output wire  oVGA_G,
  output wire  oVGA_B,
  output oHS,
  output oVS,
  output wire [7:0] oLED
    );

reg         CLK_25;
wire [10:0] ball_x,ball_y;
wire  [1:0] color;
wire  [2:0] radius;
wire        reset;
wire [10:0] vcounter;
wire [11:0] hcounter;
wire        rotary_event,
            rotary_right;
assign      reset = iSW3;
//assign color = 2'd1;
//assign radius = 3'd5;

// generate a 25Mhz clock
always @(posedge iCLK_50)
begin
	CLK_25=~CLK_25;
end

VGA_control vga_c(
  .CLK(CLK_25),
  .reset(reset),
  .vcounter(vcounter),
  .hcounter(hcounter),
  .visible(visible),
  .oHS(oHS),
  .oVS(oVS)
);

Rotation_direction r_dir(
  .CLK(iCLK_50),
  .ROT_A(ROT_A),
  .ROT_B(ROT_B),
  .rotary_event(rotary_event),
  .rotary_right(rotary_right)
);

radius_control radius_c(
  .CLK(iCLK_50),
  .reset(reset),
  .rotary_event(rotary_event),
  .rotary_right(rotary_right),
  .ball_x(ball_x),
  .ball_y(ball_y),
  .radius(radius),
  .oLED(oLED)
);

PS2_Control ps2(
  .CLK(iCLK_50),
  .PS2_CLK(PS2_CLK),
  .PS2_DATA(PS2_DATA),
  .reset(reset),
  .radius(radius),
  .color(color),
  .ball_x(ball_x),
  .ball_y(ball_y)
);

draw_ball d_ball(
  .vcounter(vcounter),
  .hcounter(hcounter),
  .visible(visible),
  .color(color),
  .radius(radius),
  .ball_x(ball_x),
  .ball_y(ball_y),
  .VGA_R(oVGA_R),
  .VGA_G(oVGA_G),
  .VGA_B(oVGA_B)
);

endmodule
