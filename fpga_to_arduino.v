`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2024 07:18:15 PM
// Design Name: 
// Module Name: fpga_to_arduino
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fpga_to_arduino(
    input [3:0] state,
    output reg right_clockwise,
    output reg right_anticlockwise,
    output reg left_clockwise,
    output reg left_anticlockwise,
    output reg front_clockwise,
    output reg front_anticlockwise,
    output reg back_clockwise,
    output reg back_anticlockwise,
    output reg top_clockwise,
    output reg top_anticlockwise,
    output reg bottom_clockwise,
    output reg bottom_anticlockwise
    );
reg a;
initial begin
a=1'b1;
end
always @(a) begin
if(state == 4'b0010)begin
front_clockwise = 1;
end 
else begin
front_clockwise = 0;
end
if (state == 4'b0000)begin
right_clockwise = 1;
end 
else begin
right_clockwise = 0;
end
if (state == 4'b0001)begin

left_clockwise = 1;
end 
else begin
left_clockwise = 0;
end
if (state == 4'b0011)begin
back_clockwise = 1;
end else begin
back_clockwise = 0;
end
if (state == 4'b0100)begin
top_clockwise = 1;
end else begin
top_clockwise = 0;
end
if (state == 4'b0101)begin
bottom_clockwise = 1;
end else begin
bottom_clockwise = 0;
end
if (state == 4'b1000)begin
right_anticlockwise = 1;
end else begin
right_anticlockwise = 0;
end
if (state == 4'b1001)begin
left_anticlockwise = 1;
end else begin
left_anticlockwise = 0;
end
if (state == 4'b1010)begin
front_anticlockwise = 1;
end else begin
front_anticlockwise = 0;
end
if (state == 4'b1011)begin
back_anticlockwise = 1;
end else begin
back_anticlockwise = 0;
end
if (state == 4'b1100)begin
top_anticlockwise = 1;
end 
else begin
top_anticlockwise = 0;
end
if (state == 4'b1101)begin
bottom_anticlockwise = 1;
end 
else begin
bottom_anticlockwise = 0;
end 
a=0;
end
endmodule
