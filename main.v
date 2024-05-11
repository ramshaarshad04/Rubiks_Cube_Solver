`timescale 1ns / 1ps

module main(
input wire clk,
    input reset,
    input wire button1,
    input wire button2,
    output right_clockwise,
    output right_anticlockwise,
    output left_clockwise,
    output left_anticlockwise,
    output front_clockwise,
    output front_anticlockwise,
    output back_clockwise,
    output back_anticlockwise,
    output top_clockwise,
    output top_anticlockwise,
    output bottom_clockwise,
    output bottom_anticlockwise,
    output h_sync,
    output v_sync,
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue
    );  
    wire shuffle;
    wire retain;

rubiks_solver_states_edition state(clk,
   button1,
   button2,
   right_clockwise,
    right_anticlockwise,
    left_clockwise,
    left_anticlockwise,
    front_clockwise,
    front_anticlockwise,
    back_clockwise,
    back_anticlockwise,
    top_clockwise,
    top_anticlockwise,
    bottom_clockwise,
    bottom_anticlockwise, 
    random,
    shuffle,
    retain);

 vga_top_lev display(clk,reset ,random,shuffle,retain, h_sync, v_sync, red, green ,blue);  

endmodule
