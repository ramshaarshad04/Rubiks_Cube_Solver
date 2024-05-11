`timescale 1ns / 1ps

module vga_top_lev(
    input clk,
    input reset,
    input [3:0] random, 
    input shuffle,
    input retain,
    output h_sync,
    output v_sync,
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue
    );
    wire [9:0]h_count;
    wire [9:0]v_count;
    wire video_on;
    wire [9:0]x_loc;
    wire [9:0]y_loc;
    wire c_div;
    top_lev t(clk, c_div, h_count, v_count);
    vga_sync s(h_count, v_count, h_sync, v_sync, video_on, x_loc, y_loc);
    rubiks_display displayy(c_div,reset, x_loc, y_loc, video_on, random , shuffle,retain , red, green, blue);

endmodule
