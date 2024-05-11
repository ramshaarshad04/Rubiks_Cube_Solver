module v_count(clk, enable, count);
input clk;
input enable;
output [9:0] count;
reg [9:0] count;
initial count = 0;
always @ (posedge clk)
begin
if (count < 524 & enable == 1)
begin
count <= count + 1;
end
if (count >= 524)
begin
count =0;
end
end
endmodule