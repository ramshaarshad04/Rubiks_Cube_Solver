`timescale 1ns / 1ps

module stop_watch(
    input clk,
    input [9:0]xloc, 
    input [9:0]yloc,
    input [9:0]pos_x,
    input [9:0]pos_y,
    input [3:0] num,
    output reg sprite_on
    );
    
wire [11:0] zero;
wire [11:0] one;
wire [11:0] two;
wire [11:0] three;
wire [11:0] four;
wire [11:0] five;
wire [11:0] six;
wire [11:0] seven;
wire [11:0] eight;
wire [11:0] nine;

assign zero =
(xloc >= pos_x+0 && xloc <= pos_x+15 && yloc >= pos_y+0 && yloc <= pos_y+3)||(xloc >= pos_x+0 && xloc <= pos_x+15 && yloc >= pos_y+16 && yloc <= pos_y+19)
||(xloc >= pos_x+0 && xloc <= pos_x+3 && yloc >= pos_y+4 && yloc <= pos_y+15)||(xloc >= pos_x+12 && xloc <= pos_x+15 && yloc >= pos_y+4 && yloc <= pos_y+15);

assign one = 
(xloc >= pos_x+0 && xloc <= pos_x+13 && yloc >= pos_y+18 && yloc <= pos_y+21)||(xloc >= pos_x+2 && xloc <= pos_x+9 && yloc >= pos_y+0 && yloc <= pos_y+3)
||(xloc >= pos_x+6 && xloc <= pos_x+9 && yloc >= pos_y+2 && yloc <= pos_y+17);

assign two =
(xloc >= pos_x+0 && xloc <= pos_x+15 && yloc >= pos_y+0 && yloc <= pos_y+3)||(xloc >= pos_x+0 && xloc <= pos_x+15 && yloc >= pos_y+8 && yloc <= pos_y+11)
||(xloc >= pos_x+0 && xloc <= pos_x+15 && yloc >= pos_y+16 && yloc <= pos_y+19)||(xloc >= pos_x+0 && xloc <= pos_x+3 && yloc >= pos_y+12 && yloc <= pos_y+15)
||(xloc >= pos_x+12 && xloc <= pos_x+15 && yloc >= pos_y+4 && yloc <= pos_y+7);

assign three = 
(xloc >= pos_x+0 && xloc <= pos_x+15 && yloc >= pos_y+0 && yloc <= pos_y+3)||(xloc >= pos_x+4 && xloc <= pos_x+15 && yloc >= pos_y+8 && yloc <= pos_y+11)
||(xloc >= pos_x+0 && xloc <= pos_x+15 && yloc >= pos_y+16 && yloc <= pos_y+19)||(xloc >= pos_x+12 && xloc <= pos_x+15 && yloc >= pos_y+0 && yloc <= pos_y+19);

assign four = 
(xloc >= pos_x+0 && xloc <= pos_x+3 && yloc >= pos_y+0 && yloc <= pos_y+11)||(xloc >= pos_x+0 && xloc <= pos_x+15 && yloc >= pos_y+8 && yloc <= pos_y+11)
||(xloc >= pos_x+10 && xloc <= pos_x+13 && yloc >= pos_y+2 && yloc <= pos_y+19);

assign five =
(xloc >= pos_x+0 && xloc <= pos_x+15 && yloc >= pos_y+0 && yloc <= pos_y+3)||(xloc >= pos_x+0 && xloc <= pos_x+15 && yloc >= pos_y+8 && yloc <= pos_y+11)
||(xloc >= pos_x+0 && xloc <= pos_x+15 && yloc >= pos_y+16 && yloc <= pos_y+19)||(xloc >= pos_x+0 && xloc <= pos_x+3 && yloc >= pos_y+4 && yloc <= pos_y+7)
||(xloc >= pos_x+12 && xloc <= pos_x+15 && yloc >= pos_y+12 && yloc <= pos_y+15);

assign six =
(xloc >= pos_x+0 && xloc <= pos_x+15 && yloc >= pos_y+0 && yloc <= pos_y+3)||(xloc >= pos_x+0 && xloc <= pos_x+15 && yloc >= pos_y+8 && yloc <= pos_y+11)
||(xloc >= pos_x+0 && xloc <= pos_x+15 && yloc >= pos_y+16 && yloc <= pos_y+19)||(xloc >= pos_x+0 && xloc <= pos_x+3 && yloc >= pos_y+4 && yloc <= pos_y+15)
||(xloc >= pos_x+12 && xloc <= pos_x+15 && yloc >= pos_y+12 && yloc <= pos_y+15);

assign seven =
(xloc >= pos_x+2 && xloc <= pos_x+15 && yloc >= pos_y+0 && yloc <= pos_y+3)||(xloc >= pos_x+12 && xloc <= pos_x+15 && yloc >= pos_y+4 && yloc <= pos_y+19);

assign eight =
(xloc >= pos_x+0 && xloc <= pos_x+15 && yloc >= pos_y+0 && yloc <= pos_y+3)||(xloc >= pos_x+0 && xloc <= pos_x+15 && yloc >= pos_y+16 && yloc <= pos_y+19)
||(xloc >= pos_x+0 && xloc <= pos_x+3 && yloc >= pos_y+3 && yloc <= pos_y+15)||(xloc >= pos_x+12 && xloc <= pos_x+15 && yloc >= pos_y+4 && yloc <= pos_y+15)
||(xloc >= pos_x+4 && xloc <= pos_x+11 && yloc >= pos_y+8 && yloc <= pos_y+11);

assign nine = 
(xloc >= pos_x+0 && xloc <= pos_x+15 && yloc >= pos_y+0 && yloc <= pos_y+3)||(xloc >= pos_x+0 && xloc <= pos_x+15 && yloc >= pos_y+8 && yloc <= pos_y+11)
||(xloc >= pos_x+0 && xloc <= pos_x+15 && yloc >= pos_y+16 && yloc <= pos_y+19)||(xloc >= pos_x+0 && xloc <= pos_x+3 && yloc >= pos_y+4 && yloc <= pos_y+7)
||(xloc >= pos_x+12 && xloc <= pos_x+15 && yloc >= pos_y+4 && yloc <= pos_y+19);

always @(posedge clk)
begin
    if (num == 4'd0)
        sprite_on <= zero;
    else if (num == 4'd1)
        sprite_on <= one;
    else if (num == 4'd2)
        sprite_on <= two;
    else if (num == 4'd3)
        sprite_on <= three;
    else if (num == 4'd4)
        sprite_on <= four;
    else if (num == 4'd5)
        sprite_on <= five;
    else if (num == 4'd6)
        sprite_on <= six;
    else if (num == 4'd7)
        sprite_on <= seven;
    else if (num == 4'd8)
        sprite_on <= eight;
    else if (num == 4'd9)
        sprite_on <= nine;
    else
        sprite_on <= 0;
end

endmodule