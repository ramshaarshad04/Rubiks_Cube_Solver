module h_count(clk, count, trigv);
input clk;
output trigv;
output [9:0] count;
reg [9:0] count;
reg trigv;
initial count = 0;
initial trigv =0;
always @ (posedge clk)
begin
if (count < 799)
begin
count <= count + 1;
trigv <=0;
end
else
begin
trigv <= 1;
count <= 0;
end
end
endmodule