`timescale 1ns / 1ps

module top_lev(clock, c_div, h_count, v_count);
input clock;
output c_div;
output [9:0] h_count;
output [9:0] v_count;
wire c_div;
wire [9:0] h_count;
wire [9:0] v_count;

clk_div cd(.clk(clock), .clk_d(c_div));
h_count hc(.clk(c_div), .trigv(trigv), .count(h_count));
v_count vc(.clk(c_div), .enable(trigv), .count(v_count));

endmodule