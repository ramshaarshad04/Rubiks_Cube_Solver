`timescale 1ns / 1ps

module random_new(
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
  state = $urandom ;
  always @(posedge clk or posedge reset)
  begin
  if (reset) begin
  state <= $urandom ;
  end
  else if (button) 
  begin
  state <= (a* state + c) % m;
  end
  end
always @ (posedge clk) begin
    if (button) begin
    case (state[2:0])
        3'b000: random_number <= 0;
        3'b001: random_number <= 1;
        3'b010: random_number <= 2;
        3'b011: random_number <= 3;
        3'b100: random_number <= 4;
        3'b101: random_number <= 5;
        3'b110: random_number <= 0;
        3'b111: random_number <= 1;
    
    endcase
    end
end
endmodule
