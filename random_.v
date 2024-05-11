`timescale 1ns / 1ps


module random_(
 input  clk,
 input  reset,
 input  button,
 output reg[3:0] random_number
 );
 reg [31:0] state;
 parameter integer a = 1664525;
 parameter integer c = 1013904223;
 parameter integer m = 429496729;
 initial
  state = $urandom % 4;
  always @(posedge clk or posedge reset)
  begin
  if (reset) begin
  state <= $urandom % 4;
  end
  else if (button) 
  begin
  state <= (a* state + c) % m;
  end
  end
always @ (posedge clk) begin
    random_number <= state % 4;
    end
always @ (posedge clk) begin
    case (state[1:0])
        2'b00: random_number <= 0;
        2'b01: random_number <= 1;
        2'b10: random_number <= 2;
        2'b11: random_number <= 3;
    endcase
end
endmodule
