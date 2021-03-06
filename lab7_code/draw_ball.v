//Subject:
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Szuyi Huang
//----------------------------------------------
//Date:        2013-12-11 13:39
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------
module draw_ball(
  vcounter,
  hcounter,
  visible,
  color,
  radius,
  ball_x,
  ball_y,
  VGA_R,
  VGA_G,
  VGA_B
);

//--------------------------------------------------------------------------------
// I/O ports declearation
input [10:0] vcounter;
input [11:0] hcounter;
input  [1:0] color;
input        visible;
input  [2:0] radius;
input [10:0] ball_x;
input [10:0] ball_y;
output       VGA_R;
output       VGA_G;
output       VGA_B;

//--------------------------------------------------------------------------------
// Internal signal
reg          VGA_R;
reg          VGA_G;
reg          VGA_B;
wire [31:0] ball_size;

//--------------------------------------------------------------------------------
// Parameter declearation

//--------------------------------------------------------------------------------
// Function Design
assign ball_size = ((hcounter - ball_x)*(hcounter - ball_x)+(vcounter - ball_y)*(vcounter - ball_y));
// (X-X0)^2 +(Y-Y0)^2 <= r^2

always@(*)
begin
  VGA_R = 1'b0;
  VGA_G = 1'b0;
  VGA_B = 1'b0;
  if(visible)begin
    if(ball_size <= ((radius*5+50)*(radius*5+50))) begin
      if(color == 2'd1) begin
        VGA_R = 1'b1;
        VGA_G = 1'b0;
        VGA_B = 1'b0;
      end else if(color == 2'd2) begin
        VGA_R = 1'b0;
        VGA_G = 1'b1;
        VGA_B = 1'b0;
      end else if(color == 2'd3) begin
        VGA_R = 1'b0;
        VGA_G = 1'b0;
        VGA_B = 1'b1;
      end
    end
  end
end

endmodule

