`timescale 1ns / 1ps

module rubiks_display(

    input clk_d,
    input reset,
    input [9:0] pixel_x,
    input [9:0] pixel_y,
    input video_on,
    input [3:0] input_random,
    input shuffle,
    input retain,
    output reg [3:0] red,
    output reg [3:0] green,
    output reg [3:0] blue
    );
    
wire unit_on;
wire tens_on;
wire minute_on;
reg [25:0] framecount;
reg [3:0] unit ;
reg [3:0] tens ;
reg [3:0] minute;
reg start_on;
reg [25:0]delay_counter;
reg [25:0] start_count;
reg button;
wire [3:0]random;


initial
begin
framecount = 0;
minute = 0;
tens = 0;
unit = 0;
start_on = 1;
start_count = 0;
delay_counter = 0;
button = 1'b0;
end

//three digits for the timer
stop_watch digit_0(clk_d, pixel_x, pixel_y, 10'd80, 10'd15, unit, unit_on);
stop_watch digit_1(clk_d, pixel_x, pixel_y, 10'd60, 10'd15, tens, tens_on);
stop_watch digit_2(clk_d, pixel_x, pixel_y, 10'd20, 10'd15, minute, minute_on);

random_new number(clk_d, 0, button, random);

 always @(posedge clk_d) begin
 
 //Resetting the timer
     if (retain == 1)
    begin
    framecount <= 0;
        minute <= 0;
        tens <= 0;
        unit <= 0;
    end
 
 //incrementing timer
 if (shuffle == 1) begin
  if ((minute != 9 || tens != 5 || unit != 9))        
        begin
            framecount <= framecount + 1;
            if (framecount == 25000000)
            begin
                framecount <= 0;
                unit <= unit + 1;
                if (unit == 9)
                begin
                    unit <= 0;
                    tens <= tens + 1;
                    if (tens == 5)
                    begin
                        tens <= 0;
                        minute <= minute + 1;
                    end
                end
            end
             end   
        end

    
   end
   
 //toggling button to get blinking effect
always @(posedge clk_d) begin
    if (shuffle && (delay_counter == 2500000)) begin
        button <= ~button; 
        delay_counter <= 0; 
    end else if (shuffle) begin
        delay_counter <= delay_counter + 1; 
    end

    
end


// Start Screen Counter
always @(posedge clk_d) begin
if (reset) begin
    start_on <= 1;
    start_count <= 0;
end
    if (start_count == 50000000) begin 
        start_on <= 0; 
    end else  begin
        start_count <= start_count + 1; 
    end

end

    always @(posedge clk_d) begin
             
        red <= 4'h0;
        blue <= 4'h0;
        green <= 4'h0;
        if (video_on) begin

              //Timer color
              if (unit_on) begin
                red<=4'hF;
                green<=4'h0;
                blue<=4'h0; end
          else if (tens_on) begin
                red<=4'hF;
                green<=4'h0;
                blue<=4'h0; end
          else if (minute_on) begin
                red<=4'hF;
                green<=4'h0;
                blue<=4'h0; end

          
            if ((pixel_x >= 45 && pixel_x <= 50 && pixel_y >= 15 && pixel_y <= 20) ||
                (pixel_x >= 45 && pixel_x <= 50 && pixel_y >= 25 && pixel_y <= 30)) begin
                red <= 4'hF;
      
            end
    // Start Screen
    if (start_on) begin
            //conditions for writing the word CUBE.
            if ((pixel_x >= 90 && pixel_x <= 120 && pixel_y >= 110 && pixel_y <= 240) ||
                (pixel_x >= 120 && pixel_x <= 200 && pixel_y >= 110 && pixel_y <= 140) ||
                (pixel_x >= 120 && pixel_x <= 200 && pixel_y >= 210 && pixel_y <= 240) ||
                (pixel_x >= 220 && pixel_x <= 250 && pixel_y >= 110 && pixel_y <= 240) ||
                (pixel_x >= 250 && pixel_x <= 300 && pixel_y >= 210 && pixel_y <= 240) ||
                (pixel_x >= 300 && pixel_x <= 330 && pixel_y >= 110 && pixel_y <= 240) ||
                (pixel_x >= 350 && pixel_x <= 390 && pixel_y >= 110 && pixel_y <= 155) ||
                (pixel_x >= 390 && pixel_x <= 420 && pixel_y >= 110 && pixel_y <= 125) ||
                (pixel_x >= 420 && pixel_x <= 460 && pixel_y >= 110 && pixel_y <= 155) ||
                (pixel_x >= 350 && pixel_x <= 460 && pixel_y >= 155 && pixel_y <= 190) ||
                (pixel_x >= 350 && pixel_x <= 390 && pixel_y >= 190 && pixel_y <= 235) ||
                (pixel_x >= 390 && pixel_x <= 420 && pixel_y >= 220 && pixel_y <= 235) ||
                (pixel_x >= 420 && pixel_x <= 460 && pixel_y >= 190 && pixel_y <= 235) ||
                (pixel_x >= 480 && pixel_x <= 510 && pixel_y >= 110 && pixel_y <= 240) ||
                (pixel_x >= 510 && pixel_x <= 590 && pixel_y >= 110 && pixel_y <= 140) ||
                (pixel_x >= 510 && pixel_x <= 590 && pixel_y >= 165 && pixel_y <= 190) ||
                (pixel_x >= 510 && pixel_x <= 590 && pixel_y >= 215 && pixel_y <= 240)) begin
                red <= 4'hF;
            end
            //conditions for writing the word SOLVER.
            if ((pixel_x >= 90 && pixel_x <= 150 && pixel_y >= 280 && pixel_y <= 295) ||
                (pixel_x >= 90 && pixel_x <= 105 && pixel_y >= 295 && pixel_y <= 310) ||
                (pixel_x >= 90 && pixel_x <= 150 && pixel_y >= 310 && pixel_y <= 325) ||
                (pixel_x >= 135 && pixel_x <= 150 && pixel_y >= 325 && pixel_y <= 355) ||
                (pixel_x >= 90 && pixel_x <= 150 && pixel_y >= 355 && pixel_y <= 370) ||
                (pixel_x >= 160 && pixel_x <= 220 && pixel_y >= 280 && pixel_y <= 302) ||
                (pixel_x >= 160 && pixel_x <= 175 && pixel_y >= 302 && pixel_y <= 348) ||
                (pixel_x >= 205 && pixel_x <= 220 && pixel_y >= 302 && pixel_y <= 348) ||
                (pixel_x >= 160 && pixel_x <= 220 && pixel_y >= 348 && pixel_y <= 370) ||
                (pixel_x >= 230 && pixel_x <= 245 && pixel_y >= 280 && pixel_y <= 370) ||
                (pixel_x >= 245 && pixel_x <= 290 && pixel_y >= 355 && pixel_y <= 370) ||
                
                // new V cordinates
                (pixel_x >= 300 && pixel_x <= 320 && pixel_y >= 280 && pixel_y <= 340) ||
                (pixel_x >= 320 && pixel_x <= 340 && pixel_y >= 340 && pixel_y <= 360) ||
                (pixel_x >= 340 && pixel_x <= 360 && pixel_y >= 360 && pixel_y <= 380) ||
                (pixel_x >= 360 && pixel_x <= 380 && pixel_y >= 340 && pixel_y <= 360) ||
                (pixel_x >= 380 && pixel_x <= 400 && pixel_y >= 280 && pixel_y <= 340) ||

                
                   //cordinates for E and R.                
                   // 100 has been added in the x-axis to accomodate for the new V coords.
                (pixel_x >= 430 && pixel_x <= 445 && pixel_y >= 280 && pixel_y <= 365) ||
                (pixel_x >= 445 && pixel_x <= 490 && pixel_y >= 280 && pixel_y <= 295) ||
                (pixel_x >= 445 && pixel_x <= 490 && pixel_y >= 315 && pixel_y <= 330) ||
                (pixel_x >= 445 && pixel_x <= 490 && pixel_y >= 350 && pixel_y <= 365) ||
                (pixel_x >= 500 && pixel_x <= 560 && pixel_y >= 280 && pixel_y <= 320) ||
                (pixel_x >= 500 && pixel_x <= 515 && pixel_y >= 320 && pixel_y <= 370) ||
                (pixel_x >= 530 && pixel_x <= 545 && pixel_y >= 320 && pixel_y <= 370)) begin
                green <= 4'hf;
                red <= 4'h00;
            end
            if ((pixel_x >= 525 && pixel_x <= 535 && pixel_y >= 295 && pixel_y <= 305)) begin // moved 20 pixels to the right on x-axis.
                red <= 4'h0;
                green <= 4'h0;
                blue <= 4'h0;
            end
    end

//Shuffled Rubiks Cube
    if (((random == 0) && (shuffle == 1) && (button == 0)) || ( (input_random == 0)&& (retain == 1))) begin 
//front
    //first row
    if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
  if  (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
    //second row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
    //third row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
    if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
            
            
//bottom
//first row
if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 317 && pixel_y <= 347) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
  if  (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 317 && pixel_y <= 347) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 317 && pixel_y <= 347) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
    //second row 
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 357 && pixel_y <= 387) begin 
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 357 && pixel_y <= 387) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 357 && pixel_y <= 387) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
//third row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 397 && pixel_y <= 427) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 397 && pixel_y <= 427) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
    if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 397 && pixel_y <= 427) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
        
//top
//first row            
if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 77 && pixel_y <= 107) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
  if  (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 77 && pixel_y <= 107) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 77 && pixel_y <= 107) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
    //second row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 117 && pixel_y <= 147) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 117 && pixel_y <= 147) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 117 && pixel_y <= 147) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 157 && pixel_y <= 187) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 157 && pixel_y <= 187) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
    if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 157 && pixel_y <= 187) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end

//left
//first row
if (pixel_x >= 93 && pixel_x <= 123 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
  if  (pixel_x >= 133 && pixel_x <= 163 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 173 && pixel_x <= 203 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
    //second row
   if (pixel_x >= 93 && pixel_x <= 123 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 133 && pixel_x <= 163 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 173 && pixel_x <= 203 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
//third row
   if (pixel_x >= 93 && pixel_x <= 123 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 133 && pixel_x <= 163 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
    if (pixel_x >= 173 && pixel_x <= 203 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end

//right
//first row
if (pixel_x >= 333 && pixel_x <= 363 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
  if  (pixel_x >= 373 && pixel_x <= 403 && pixel_y >= 197 && pixel_y <= 227) begin
           red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 413 && pixel_x <= 443 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
    //second row
   if (pixel_x >= 333 && pixel_x <= 363 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 373 && pixel_x <= 403 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 413 && pixel_x <= 443 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 333 && pixel_x <= 363 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 373 && pixel_x <= 403 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
    if (pixel_x >= 413 && pixel_x <= 443 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
//back
//first row
if (pixel_x >= 453 && pixel_x <= 483 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
  if  (pixel_x >= 493 && pixel_x <= 523 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 533 && pixel_x <= 563 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
    //second row
   if (pixel_x >= 453 && pixel_x <= 483 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 493 && pixel_x <= 523 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 533 && pixel_x <= 563 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 453 && pixel_x <= 483 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 493 && pixel_x <= 523 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
    if (pixel_x >= 533 && pixel_x <= 563 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
        end
    
    if (((random == 1) && (shuffle == 1)&& (button == 0)) || ( (input_random == 1)&& (retain == 1))) begin 
//front
    //first row
    if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
  if  (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
    //second row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
    //third row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
    if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
            
            
//bottom
//first row
if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 317 && pixel_y <= 347) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
  if  (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 317 && pixel_y <= 347) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 317 && pixel_y <= 347) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
    //second row 
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 357 && pixel_y <= 387) begin 
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 357 && pixel_y <= 387) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 357 && pixel_y <= 387) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 397 && pixel_y <= 427) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 397 && pixel_y <= 427) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
    if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 397 && pixel_y <= 427) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
        
//top
//first row            
if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 77 && pixel_y <= 107) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
  if  (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 77 && pixel_y <= 107) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 77 && pixel_y <= 107) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
    //second row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 117 && pixel_y <= 147) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 117 && pixel_y <= 147) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 117 && pixel_y <= 147) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 157 && pixel_y <= 187) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 157 && pixel_y <= 187) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
    if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 157 && pixel_y <= 187) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end

//left
//first row
if (pixel_x >= 93 && pixel_x <= 123 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
  if  (pixel_x >= 133 && pixel_x <= 163 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 173 && pixel_x <= 203 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
    //second row
   if (pixel_x >= 93 && pixel_x <= 123 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 133 && pixel_x <= 163 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 173 && pixel_x <= 203 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 93 && pixel_x <= 123 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 133 && pixel_x <= 163 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
    if (pixel_x >= 173 && pixel_x <= 203 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end

//right
//first row
if (pixel_x >= 333 && pixel_x <= 363 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
  if  (pixel_x >= 373 && pixel_x <= 403 && pixel_y >= 197 && pixel_y <= 227) begin
           red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 413 && pixel_x <= 443 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
    //second row
   if (pixel_x >= 333 && pixel_x <= 363 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 373 && pixel_x <= 403 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 413 && pixel_x <= 443 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
//third row
   if (pixel_x >= 333 && pixel_x <= 363 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 373 && pixel_x <= 403 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
    if (pixel_x >= 413 && pixel_x <= 443 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
//back
//first row
if (pixel_x >= 453 && pixel_x <= 483 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
  if  (pixel_x >= 493 && pixel_x <= 523 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 533 && pixel_x <= 563 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
    //second row
   if (pixel_x >= 453 && pixel_x <= 483 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 493 && pixel_x <= 523 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 533 && pixel_x <= 563 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 453 && pixel_x <= 483 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 493 && pixel_x <= 523 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
    if (pixel_x >= 533 && pixel_x <= 563 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
        end
     
     if (((random == 2) && (shuffle == 1)&& (button == 0)) || ((input_random == 2)&& (retain == 1))) begin 
  //front
    //first row
    if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
  if  (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
    //second row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
    //third row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
    if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
            
            
//bottom
//first row
if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 317 && pixel_y <= 347) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
  if  (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 317 && pixel_y <= 347) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 317 && pixel_y <= 347) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
    //second row 
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 357 && pixel_y <= 387) begin 
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 357 && pixel_y <= 387) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 357 && pixel_y <= 387) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 397 && pixel_y <= 427) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 397 && pixel_y <= 427) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
    if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 397 && pixel_y <= 427) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
        
//top
//first row            
if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 77 && pixel_y <= 107) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
  if  (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 77 && pixel_y <= 107) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 77 && pixel_y <= 107) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
    //second row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 117 && pixel_y <= 147) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 117 && pixel_y <= 147) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 117 && pixel_y <= 147) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 157 && pixel_y <= 187) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 157 && pixel_y <= 187) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
    if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 157 && pixel_y <= 187) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end

//left
//first row
if (pixel_x >= 93 && pixel_x <= 123 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
  if  (pixel_x >= 133 && pixel_x <= 163 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 173 && pixel_x <= 203 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
    //second row
   if (pixel_x >= 93 && pixel_x <= 123 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 133 && pixel_x <= 163 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 173 && pixel_x <= 203 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 93 && pixel_x <= 123 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 133 && pixel_x <= 163 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
    if (pixel_x >= 173 && pixel_x <= 203 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end

//right
//first row
if (pixel_x >= 333 && pixel_x <= 363 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
  if  (pixel_x >= 373 && pixel_x <= 403 && pixel_y >= 197 && pixel_y <= 227) begin
           red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 413 && pixel_x <= 443 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
    //second row
   if (pixel_x >= 333 && pixel_x <= 363 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 373 && pixel_x <= 403 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 413 && pixel_x <= 443 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 333 && pixel_x <= 363 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 373 && pixel_x <= 403 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
    if (pixel_x >= 413 && pixel_x <= 443 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
//back
//first row
if (pixel_x >= 453 && pixel_x <= 483 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
  if  (pixel_x >= 493 && pixel_x <= 523 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 533 && pixel_x <= 563 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
    //second row
   if (pixel_x >= 453 && pixel_x <= 483 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 493 && pixel_x <= 523 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 533 && pixel_x <= 563 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 453 && pixel_x <= 483 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 493 && pixel_x <= 523 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
    if (pixel_x >= 533 && pixel_x <= 563 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
        end
 
    if (((random == 3) && (shuffle == 1)&& (button == 0)) || ( (input_random == 3)&& (retain == 1))) begin 
//front
    //first row
    if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
  if  (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
    //second row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
    //third row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
    if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
            
            
//bottom
//first row
if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 317 && pixel_y <= 347) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
  if  (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 317 && pixel_y <= 347) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 317 && pixel_y <= 347) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
    //second row 
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 357 && pixel_y <= 387) begin 
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 357 && pixel_y <= 387) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 357 && pixel_y <= 387) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
//third row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 397 && pixel_y <= 427) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 397 && pixel_y <= 427) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
    if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 397 && pixel_y <= 427) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
        
//top
//first row            
if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 77 && pixel_y <= 107) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
  if  (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 77 && pixel_y <= 107) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 77 && pixel_y <= 107) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
    //second row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 117 && pixel_y <= 147) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 117 && pixel_y <= 147) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 117 && pixel_y <= 147) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
//third row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 157 && pixel_y <= 187) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 157 && pixel_y <= 187) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
    if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 157 && pixel_y <= 187) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end

//left
//first row
if (pixel_x >= 93 && pixel_x <= 123 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
  if  (pixel_x >= 133 && pixel_x <= 163 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 173 && pixel_x <= 203 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
    //second row
   if (pixel_x >= 93 && pixel_x <= 123 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 133 && pixel_x <= 163 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 173 && pixel_x <= 203 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 93 && pixel_x <= 123 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 133 && pixel_x <= 163 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
    if (pixel_x >= 173 && pixel_x <= 203 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end

//right
//first row
if (pixel_x >= 333 && pixel_x <= 363 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
  if  (pixel_x >= 373 && pixel_x <= 403 && pixel_y >= 197 && pixel_y <= 227) begin
           red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 413 && pixel_x <= 443 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
    //second row
   if (pixel_x >= 333 && pixel_x <= 363 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 373 && pixel_x <= 403 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 413 && pixel_x <= 443 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 333 && pixel_x <= 363 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 373 && pixel_x <= 403 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
    if (pixel_x >= 413 && pixel_x <= 443 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
//back
//first row
if (pixel_x >= 453 && pixel_x <= 483 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
  if  (pixel_x >= 493 && pixel_x <= 523 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 533 && pixel_x <= 563 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
    //second row
   if (pixel_x >= 453 && pixel_x <= 483 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 493 && pixel_x <= 523 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 533 && pixel_x <= 563 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
//third row
   if (pixel_x >= 453 && pixel_x <= 483 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 493 && pixel_x <= 523 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
    if (pixel_x >= 533 && pixel_x <= 563 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
        end 
        end  
       
    if ((random == 4) && (shuffle == 1)&& (button == 0)) begin
//front
    //first row
    if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
  if  (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
    //second row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
    //third row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
    if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
            
            
//bottom
//first row
if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 317 && pixel_y <= 347) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
  if  (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 317 && pixel_y <= 347) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 317 && pixel_y <= 347) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
    //second row 
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 357 && pixel_y <= 387) begin 
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 357 && pixel_y <= 387) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 357 && pixel_y <= 387) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
//third row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 397 && pixel_y <= 427) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 397 && pixel_y <= 427) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
    if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 397 && pixel_y <= 427) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
        
//top
//first row            
if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 77 && pixel_y <= 107) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
  if  (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 77 && pixel_y <= 107) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 77 && pixel_y <= 107) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
    //second row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 117 && pixel_y <= 147) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 117 && pixel_y <= 147) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 117 && pixel_y <= 147) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 157 && pixel_y <= 187) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 157 && pixel_y <= 187) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
    if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 157 && pixel_y <= 187) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end

//left
//first row
if (pixel_x >= 93 && pixel_x <= 123 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
  if  (pixel_x >= 133 && pixel_x <= 163 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 173 && pixel_x <= 203 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
    //second row
   if (pixel_x >= 93 && pixel_x <= 123 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 133 && pixel_x <= 163 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 173 && pixel_x <= 203 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
//third row
   if (pixel_x >= 93 && pixel_x <= 123 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 133 && pixel_x <= 163 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
    if (pixel_x >= 173 && pixel_x <= 203 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end

//right
//first row
if (pixel_x >= 333 && pixel_x <= 363 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
  if  (pixel_x >= 373 && pixel_x <= 403 && pixel_y >= 197 && pixel_y <= 227) begin
           red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 413 && pixel_x <= 443 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
    //second row
   if (pixel_x >= 333 && pixel_x <= 363 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 373 && pixel_x <= 403 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 413 && pixel_x <= 443 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
//third row
   if (pixel_x >= 333 && pixel_x <= 363 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 373 && pixel_x <= 403 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
    if (pixel_x >= 413 && pixel_x <= 443 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
//back
//first row
if (pixel_x >= 453 && pixel_x <= 483 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
  if  (pixel_x >= 493 && pixel_x <= 523 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 533 && pixel_x <= 563 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
    //second row
   if (pixel_x >= 453 && pixel_x <= 483 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 493 && pixel_x <= 523 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 533 && pixel_x <= 563 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 453 && pixel_x <= 483 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 493 && pixel_x <= 523 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
    if (pixel_x >= 533 && pixel_x <= 563 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
        end
    
    if ((random == 5) && (shuffle == 1)&& (button == 0)) begin
//front
    //first row
    if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
  if  (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
    //second row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
    //third row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
    if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
            
            
//bottom
//first row
if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 317 && pixel_y <= 347) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
  if  (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 317 && pixel_y <= 347) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 317 && pixel_y <= 347) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
    //second row 
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 357 && pixel_y <= 387) begin 
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 357 && pixel_y <= 387) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 357 && pixel_y <= 387) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 397 && pixel_y <= 427) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 397 && pixel_y <= 427) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
    if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 397 && pixel_y <= 427) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
        
//top
//first row            
if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 77 && pixel_y <= 107) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
  if  (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 77 && pixel_y <= 107) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 77 && pixel_y <= 107) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
    //second row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 117 && pixel_y <= 147) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 117 && pixel_y <= 147) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 117 && pixel_y <= 147) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 157 && pixel_y <= 187) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 157 && pixel_y <= 187) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
    if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 157 && pixel_y <= 187) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end

//left
//first row
if (pixel_x >= 93 && pixel_x <= 123 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
  if  (pixel_x >= 133 && pixel_x <= 163 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 173 && pixel_x <= 203 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
    //second row
   if (pixel_x >= 93 && pixel_x <= 123 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 133 && pixel_x <= 163 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 173 && pixel_x <= 203 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 93 && pixel_x <= 123 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 133 && pixel_x <= 163 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
    if (pixel_x >= 173 && pixel_x <= 203 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end

//right
//first row
if (pixel_x >= 333 && pixel_x <= 363 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
  if  (pixel_x >= 373 && pixel_x <= 403 && pixel_y >= 197 && pixel_y <= 227) begin
           red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 413 && pixel_x <= 443 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
    //second row
   if (pixel_x >= 333 && pixel_x <= 363 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 373 && pixel_x <= 403 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 413 && pixel_x <= 443 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 333 && pixel_x <= 363 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 373 && pixel_x <= 403 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
    if (pixel_x >= 413 && pixel_x <= 443 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
//back
//first row
if (pixel_x >= 453 && pixel_x <= 483 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
  if  (pixel_x >= 493 && pixel_x <= 523 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 533 && pixel_x <= 563 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
    //second row
   if (pixel_x >= 453 && pixel_x <= 483 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 493 && pixel_x <= 523 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 533 && pixel_x <= 563 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 453 && pixel_x <= 483 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 493 && pixel_x <= 523 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
    if (pixel_x >= 533 && pixel_x <= 563 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
        end

         // solved screen
   if ((shuffle == 0)&& (retain == 0) && (start_on == 0)) begin
  //front
    //first row
    if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
  if  (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
    //second row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
    //third row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
    if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'hF;
        end
            
            
//bottom
//first row
if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 317 && pixel_y <= 347) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
  if  (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 317 && pixel_y <= 347) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 317 && pixel_y <= 347) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
    //second row 
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 357 && pixel_y <= 387) begin 
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 357 && pixel_y <= 387) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 357 && pixel_y <= 387) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 397 && pixel_y <= 427) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 397 && pixel_y <= 427) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
    if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 397 && pixel_y <= 427) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'hF;
        end
        
//top
//first row            
if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 77 && pixel_y <= 107) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
  if  (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 77 && pixel_y <= 107) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 77 && pixel_y <= 107) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
    //second row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 117 && pixel_y <= 147) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 117 && pixel_y <= 147) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 117 && pixel_y <= 147) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
//third row
   if (pixel_x >= 213 && pixel_x <= 243 && pixel_y >= 157 && pixel_y <= 187) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
   if (pixel_x >= 253 && pixel_x <= 283 && pixel_y >= 157 && pixel_y <= 187) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end
    if (pixel_x >= 293 && pixel_x <= 323 && pixel_y >= 157 && pixel_y <= 187) begin
            red <= 4'hF;
            blue <= 4'hF;
            green <= 4'hF;
        end

//left
//first row
if (pixel_x >= 93 && pixel_x <= 123 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
  if  (pixel_x >= 133 && pixel_x <= 163 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 173 && pixel_x <= 203 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
    //second row
   if (pixel_x >= 93 && pixel_x <= 123 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 133 && pixel_x <= 163 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 173 && pixel_x <= 203 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
//third row
   if (pixel_x >= 93 && pixel_x <= 123 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
   if (pixel_x >= 133 && pixel_x <= 163 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end
    if (pixel_x >= 173 && pixel_x <= 203 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h7;
        end

//right
//first row
if (pixel_x >= 333 && pixel_x <= 363 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
  if  (pixel_x >= 373 && pixel_x <= 403 && pixel_y >= 197 && pixel_y <= 227) begin
           red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 413 && pixel_x <= 443 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
    //second row
   if (pixel_x >= 333 && pixel_x <= 363 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 373 && pixel_x <= 403 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 413 && pixel_x <= 443 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
//third row
   if (pixel_x >= 333 && pixel_x <= 363 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
   if (pixel_x >= 373 && pixel_x <= 403 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
    if (pixel_x >= 413 && pixel_x <= 443 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'hF;
            blue <= 4'h0;
            green <= 4'h0;
        end
//back
//first row
if (pixel_x >= 453 && pixel_x <= 483 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
  if  (pixel_x >= 493 && pixel_x <= 523 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 533 && pixel_x <= 563 && pixel_y >= 197 && pixel_y <= 227) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
    //second row
   if (pixel_x >= 453 && pixel_x <= 483 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 493 && pixel_x <= 523 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 533 && pixel_x <= 563 && pixel_y >= 237 && pixel_y <= 267) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
//third row
   if (pixel_x >= 453 && pixel_x <= 483 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
   if (pixel_x >= 493 && pixel_x <= 523 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
    if (pixel_x >= 533 && pixel_x <= 563 && pixel_y >= 277 && pixel_y <= 307) begin
            red <= 4'h0;
            blue <= 4'hF;
            green <= 4'h0;
        end
        end
    
    // blinking effect
     if ((button == 1) && (shuffle == 1)&& (retain == 0)) begin 

            red <= 4'h0;
            blue <= 4'h0;
            green <= 4'h0;
            end
   
   end




    
endmodule
    

