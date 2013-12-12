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
module radius_control(
  CLK,
  reset,
  rotary_event,
  rotary_right,
  ball_x,
  ball_y,
  radius,
  oLED
);

//--------------------------------------------------------------------------------
// I/O ports declearation
input        CLK;
input        reset;
input        rotary_event;
input        rotary_right;
input [10:0] ball_x;
input [10:0] ball_y;
output [2:0] radius;
output [7:0] oLED;

//--------------------------------------------------------------------------------
// Internal signal
reg    [2:0] radius;
reg    [7:0] oLED;
reg    [2:0] n_radius;

//--------------------------------------------------------------------------------
// Parameter declearation

//--------------------------------------------------------------------------------
// Function Design
always @(posedge CLK)
begin
  if(reset)
    radius <= 3'd0;
  else
    radius <= n_radius;
end

always @(*)
begin
  n_radius = radius;
  if(rotary_event)begin
    if(rotary_right)begin//left,increase
      if((ball_x + (radius*5+50))<=11'd635 &&
        (ball_y + (radius*5+50))<=11'd475 &&
        (ball_x - (radius*5+50))>=11'd5 &&
        (ball_y - (radius*5+50))>=11'd5 )
        n_radius = radius + 1;
    end
    else begin
      if(radius!=3'd0)
        n_radius = radius - 1;
    end
  end
end

always @(*)
begin
  case(radius)
     3'd0: oLED=8'b00000001;
     3'd1: oLED=8'b00000011;
     3'd2: oLED=8'b00000111;
     3'd3: oLED=8'b00001111;
     3'd4: oLED=8'b00011111;
     3'd5: oLED=8'b00111111;
     3'd6: oLED=8'b01111111;
     3'd7: oLED=8'b11111111;
  endcase
end

endmodule

