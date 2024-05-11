module rubiks_solver_states_edition(
    input wire clk,
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
    output [3:0] random,
    output sol,
    output retain
);  

wire clk_d;
wire clk_25;
wire button_debounce1;
wire button_debounce2;
reg [3:0]state;
reg con;
reg sol;
reg retain;
wire [3:0] random; 
integer i;
reg [3:0] states[0:3][0:17];    
reg [3:0] solution[0:3][0:30];
reg  [7:0]state0_len = 19;
reg [7:0] state1_len = 16;
reg [7:0] state2_len = 12;
reg [7:0] state3_len = 15;   
reg [7:0] sol0_len = 31;
    reg [7:0] sol1_len = 28;
    reg [7:0] sol2_len = 28;
    reg [7:0] sol3_len = 25;
reg [3:0]temp;
initial begin
con = 1'b0;
state=4'b1111;
i=0;
retain = 1'b0;


//states[0][0]=4'b0000; states[0][1] = 4'b0001; states[0][2]= 4'b0010 ; states[0][3]= 4'b0011; states[0][4]=4'b0100;states[0][5]=4'b0101;states[0][5]=4'b1000; states[0][6]=4'b0001; states[0][7]=4'b0010; states[0][8]=4'b1101; states[0][9]=4'b1010; states[0][10]=4'b0011; states[0][11]=4'b0011; states[0][12]=4'b0000; states[0][13]=4'b1010; states[0][14]=4'b1010; states[0][15]=4'b1011; states[0][16]=4'b0100; states[0][17]=4'b0001; 
//        states[1][0]=4'b0001; states[1][1]=4'b0000 ; states[1][2]=4'b0100 ; states[1][3]=4'b0011 ; states[1][4]=4'b1001; states[1][5]=4'b0101 ; states[1][6]=4'b0001 ; states[1][7]=4'b1000 ; states[1][8]=4'b1100 ; states[1][9]=4'b1101 ; states[1][10]=4'b0001 ; states[1][11]=4'b1010 ; states[1][12]=4'b1010 ; states[1][13]=4'b1011 ; states[1][14]=4'b0001 ; states[1][15]= 4'b0101;
//        states[2][0] = 4'b0010; states[2][1] = 4'b0000; states[2][2] =4'b1001; states[2][3] = 4'b0101; states[2][4]=4'b0011 ; states[2][5]=4'b0100 ; states[2][6]=4'b1000 ; states[2][7]=4'b1010 ; states[2][8]=4'b1011 ; states[2][9]=4'b0001 ; states[2][10]=4'b1101 ; states[2][11]=4'b1100 ; 
//        states[3][0] =4'b0011 ; states[3][1] = 4'b1001; states[3][2] = 4'b0100; states[3][3]=4'b0010 ; states[3][4]=4'b1000 ; states[3][5]=4'b0001 ; states[3][6]=4'b0011 ; states[3][7]=4'b0101 ; states[3][8]=4'b1100 ; states[3][9]=4'b1010 ; states[3][10]=4'b0000; states[3][11]=4'b0010 ; states[3][12]=4'b1101 ; states[3][13]=4'b0100 ; states[3][14]=4'b0100 ; 
//    solution[0][0] = 4'b0000; solution[0][1] = 4'b0010; solution[0][2] = 4'b0010; solution[0][3] = 4'b0001; solution[0][4] = 4'b1011; solution[0][5] = 4'b0100; solution[0][6] = 4'b0001; solution[0][7] = 4'b0001; solution[0][8] = 4'b1100; solution[0][9] = 4'b1011; solution[0][10] = 4'b0101; solution[0][11] = 4'b0000; solution[0][12] = 4'b1011; solution[0][13] = 4'b1001; solution[0][14] = 4'b0101; solution[0][15] = 4'b0001; solution[0][16] = 4'b0001; solution[0][17] = 4'b0010; solution[0][18] = 4'b0010; solution[0][19] = 4'b0100; solution[0][20] = 4'b0011; solution[0][21] = 4'b0011; solution[0][22] = 4'b0101; solution[0][23] = 4'b0101; solution[0][24] = 4'b0000; solution[0][25] = 4'b0000; solution[0][26] = 4'b0001; solution[0][27] = 4'b0001;
//        solution[1][0] = 4'b0011; solution[1][1] = 4'b0011; solution[1][2] = 4'b1011; solution[1][3] = 4'b1100; solution[1][4] = 4'b1101; solution[1][5] = 4'b1010; solution[1][6] = 4'b0101; solution[1][7] = 4'b1011; solution[1][8] = 4'b1100; solution[1][9] = 4'b0001; solution[1][10] = 4'b0001; solution[1][11] = 4'b0101; solution[1][12] = 4'b0101; solution[1][13] = 4'b1001; solution[1][14] = 4'b0010; solution[1][15] = 4'b0010; solution[1][16] = 4'b0000; solution[1][17] = 4'b0011; solution[1][18] = 4'b0011; solution[1][19] = 4'b0000; solution[1][20] = 4'b0000; solution[1][21] = 4'b0101; solution[1][22] = 4'b0011; solution[1][23] = 4'b0011; solution[1][24] = 4'b0100; solution[1][25] = 4'b1101; solution[1][26] = 4'b0011; solution[1][27] = 4'b0011;
//        solution[2][0] = 4'b0100; solution[2][1] = 4'b0101; solution[2][2] = 4'b0001; solution[2][3] = 4'b0001; solution[2][4] = 4'b1010; solution[2][5] = 4'b1100; solution[2][6] = 4'b1001; solution[2][7] = 4'b0101; solution[2][8] = 4'b0000; solution[2][9] = 4'b0001; solution[2][10] = 4'b0100; solution[2][11] = 4'b0100; solution[2][12] = 4'b1010; solution[2][13] = 4'b0100; solution[2][14] = 4'b0000; solution[2][15] = 4'b0000; solution[2][16] = 4'b0100; solution[2][17] = 4'b0001; solution[2][18] = 4'b0001; solution[2][19] = 4'b0101; solution[2][20] = 4'b0000; solution[2][21] = 4'b0000; solution[2][22] = 4'b0101; solution[2][23] = 4'b0101; solution[2][24] = 4'b0010; solution[2][25] = 4'b0010; solution[2][26] = 4'b0011; solution[2][27] = 4'b0011;
//        solution[3][0] = 4'b1100; solution[3][1] = 4'b1001; solution[3][2] = 4'b1010; solution[3][3] = 4'b0001; solution[3][4] = 4'b1011; solution[3][5] = 4'b0000; solution[3][6] = 4'b1001; solution[3][7] = 4'b1010; solution[3][8] = 4'b1100; solution[3][9] = 4'b1001; solution[3][10] = 4'b0010; solution[3][11] = 4'b0010; solution[3][12] = 4'b0000; solution[3][13] = 4'b0000; solution[3][14] = 4'b0100; solution[3][15] = 4'b0000; solution[3][16] = 4'b0000; solution[3][17] = 4'b0010; solution[3][18] = 4'b0010; solution[3][19] = 4'b0001; solution[3][20] = 4'b0001; solution[3][21] = 4'b0101; solution[3][22] = 4'b0101;
//    end
     states[0][0]=4'b0000; states[0][1] = 4'b0001; states[0][2]= 4'b0010 ; states[0][3]= 4'b0011; states[0][4]=4'b0100;states[0][5]=4'b0101;states[0][6]=4'b1000; states[0][7]=4'b0001; states[0][8]=4'b0010; states[0][9]=4'b1101; states[0][10]=4'b1010; states[0][11]=4'b0011; states[0][12]=4'b0011; states[0][13]=4'b0000; states[0][14]=4'b1010; states[0][15]=4'b1010; states[0][16]=4'b1011; states[0][17]=4'b0100; states[0][18]=4'b0001; 
        states[1][0]=4'b0001; states[1][1]=4'b0000 ; states[1][2]=4'b0100 ; states[1][3]=4'b0011 ; states[1][4]=4'b1001; states[1][5]=4'b0101 ; states[1][6]=4'b0001 ; states[1][7]=4'b1000 ; states[1][8]=4'b1100 ; states[1][9]=4'b1101 ; states[1][10]=4'b0001 ; states[1][11]=4'b1010 ; states[1][12]=4'b1010 ; states[1][13]=4'b1011 ; states[1][14]=4'b0001 ; states[1][15]= 4'b0101;
        states[2][0] = 4'b0010; states[2][1] = 4'b0000; states[2][2] =4'b1001; states[2][3] = 4'b0101; states[2][4]=4'b0011 ; states[2][5]=4'b0100 ; states[2][6]=4'b1000 ; states[2][7]=4'b1010 ; states[2][8]=4'b1011 ; states[2][9]=4'b0001 ; states[2][10]=4'b1101 ; states[2][11]=4'b1100 ; 
        states[3][0] =4'b0011 ; states[3][1] = 4'b1001; states[3][2] = 4'b0100; states[3][3]=4'b0010 ; states[3][4]=4'b1000 ; states[3][5]=4'b0001 ; states[3][6]=4'b0011 ; states[3][7]=4'b0101 ; states[3][8]=4'b1100 ; states[3][9]=4'b1010 ; states[3][10]=4'b0000; states[3][11]=4'b0010 ; states[3][12]=4'b1101 ; states[3][13]=4'b0100 ; states[3][14]=4'b0100 ; 
    solution[0][0] = 4'b0010; solution[0][1] = 4'b0010; solution[0][2] = 4'b0000; solution[0][3] = 4'b0100; solution[0][4] = 4'b0000; solution[0][5] = 4'b0011; solution[0][6] = 4'b0011; solution[0][7] = 4'b0100; solution[0][8] = 4'b0100; solution[0][9] = 4'b0001; solution[0][10] = 4'b0001; solution[0][11] = 4'b0011; solution[0][12] = 4'b0011; solution[0][13] = 4'b0001; solution[0][14] = 4'b1101; solution[0][15] = 4'b0011; solution[0][16] = 4'b0000; solution[0][17] = 4'b0100; solution[0][18] = 4'b0100; solution[0][19] = 4'b0011; solution[0][20] = 4'b0011; solution[0][21] = 4'b0101; solution[0][22] = 4'b0101; solution[0][23] = 4'b0001; solution[0][24] = 4'b0001; solution[0][25] = 4'b0011; solution[0][26] = 4'b0011; solution[0][27] = 4'b0100; solution[0][28] = 4'b0010; solution[0][29] = 4'b0010; solution[0][30] = 4'b0101;
        
        solution[1][0] = 4'b1000; solution[1][1] = 4'b0010; solution[1][2] = 4'b0010; solution[1][3] = 4'b1100; solution[1][4] = 4'b1001; solution[1][5] = 4'b1101; solution[1][6] = 4'b0010; solution[1][7] = 4'b0011; solution[1][8] = 4'b0011; solution[1][9] = 4'b0101; solution[1][10] = 4'b0000; solution[1][11] = 4'b0000; solution[1][12] = 4'b0101; solution[1][13] = 4'b0000; solution[1][14] = 4'b0000; solution[1][15] = 4'b0001; solution[1][16] = 4'b0101; solution[1][17] = 4'b0010; solution[1][18] = 4'b0010; solution[1][19] = 4'b0000; solution[1][20] = 4'b0000; solution[1][21] = 4'b1101; solution[1][22] = 4'b0000; solution[1][23] = 4'b0000; solution[1][24] = 4'b1100; solution[1][25] = 4'b0011; solution[1][26] = 4'b0011; solution[1][27] = 4'b0101;
        
        solution[2][0] = 4'b0100; solution[2][1] = 4'b0101; solution[2][2] = 4'b0001; solution[2][3] = 4'b0001; solution[2][4] = 4'b1010; solution[2][5] = 4'b1100; solution[2][6] = 4'b1001; solution[2][7] = 4'b0101; solution[2][8] = 4'b0000; solution[2][9] = 4'b0001; solution[2][10] = 4'b0100; solution[2][11] = 4'b0100; solution[2][12] = 4'b1010; solution[2][13] = 4'b0100; solution[2][14] = 4'b0000; solution[2][15] = 4'b0000; solution[2][16] = 4'b0100; solution[2][17] = 4'b0001; solution[2][18] = 4'b0001; solution[2][19] = 4'b0101; solution[2][20] = 4'b0000; solution[2][21] = 4'b0000; solution[2][22] = 4'b0101; solution[2][23] = 4'b0101; solution[2][24] = 4'b0010; solution[2][25] = 4'b0010; solution[2][26] = 4'b0011; solution[2][27] = 4'b0011;
        
        solution[3][0] = 4'b0010; solution[3][1] = 4'b0100; solution[3][2] = 4'b0100; solution[3][3] = 4'b0001; solution[3][4] = 4'b0011; solution[3][5] = 4'b0011; solution[3][6] = 4'b0100; solution[3][7] = 4'b1101; solution[3][8] = 4'b0010; solution[3][9] = 4'b0010; solution[3][10] = 4'b0000; solution[3][11] = 4'b0000; solution[3][12] = 4'b1011; solution[3][13] = 4'b0100; solution[3][14] = 4'b0100; solution[3][15] = 4'b0011; solution[3][16] = 4'b1001; solution[3][17] = 4'b0011; solution[3][18] = 4'b0001; solution[3][19] = 4'b0001; solution[3][20] = 4'b0010; solution[3][21] = 4'b0010; solution[3][22] = 4'b0011; solution[3][23]=4'b0011; solution[3][24]=4'b1101 ; solution[3][24]=4'b0010 ; solution[3][24]=4'b0010 ; solution[3][24]=4'b0100 ; solution[3][24]=4'b0100 ;    
        end
     
    debounce_new n1(0,clk_25,button1,button_debounce1);
    debounce_new n2(0,clk_25,button2,button_debounce2);
    clk_div_25 dine(clk,clk_25);
    clock_div bine(0,clk_25,clk_d);
    random_ rand(clk_25,0,button_debounce1,random);
    fpga_to_arduino a1(state,
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
    bottom_anticlockwise
    );
    
    always @(posedge clk_d)begin
       if (button_debounce1==1)begin
    con=1'b1;
    retain = 1'b1;
    end
    else if (button_debounce2==1)begin
    sol=1'b1;
    retain = 1'b0;
    end

        if (con==1'b1)begin
            if (random==0)begin
            
                if (i<state0_len)begin
                state = states[0][i];
                i<= i+1;
                end
                else begin
                con=1'b0;
                i <= 0;
                state=4'b1111;
                end
               end
              else if (random==1)begin 
              
              if (i<state1_len)begin
                state = states[1][i];
                i<= i+1;
                end
                else begin
                con=1'b0;
                i <= 0;
                state=4'b1111;
                end
                end
               else if (random==2)begin
              
              if (i<state2_len)begin
                state = states[2][i];
                i<= i+1;
                end
                else begin
                con=1'b0;
                i <= 0;
                state=4'b1111;
                end
                end
               else if (random==3)begin 
               
              if (i<state3_len)begin
                state = states[3][i];
                i<= i+1;
                end
                else begin
                con=1'b0;
                i <= 0;
                state=4'b1111;
                end
                end
               else begin
               state = 4'b1111;
               end
             end
         else if (sol==1'b1)begin
         if (random==0)begin
                if (i<sol0_len)begin
                state = solution[0][i];
                i<= i+1;
                end
                else begin
                sol=1'b0;
                i <= 0;
                state=4'b1111;
                end
               end
              else if (random==1)begin 
              if (i<sol1_len)begin
                state = solution[1][i];
                i<= i+1;
                end
                else begin
                sol=1'b0;
                i <= 0;
                state=4'b1111;
                end
                end
               else if (random==2)begin 
              if (i<sol2_len)begin
                state = solution[2][i];
                i<= i+1;
                end
                else begin
                sol=1'b0;
                i <= 0;
                state=4'b1111;
                end
                end
               else if (random==3)begin 
              if (i<sol3_len)begin
                state = solution[3][i];
                i<= i+1;
                end
                else begin
                sol=1'b0;
                i <= 0;
                state=4'b1111;
                end
                end
               else begin
               state = 4'b1111;
               end
         
         end
         else begin
         state = 4'b1111;
         end
end
endmodule
