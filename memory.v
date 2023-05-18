module pipe_ex_(f,a,b,c,d,clk);
parameter N=10;
input [N-1:0] a,b,c,d;
input clk;
output [N-1:0] f;
reg [N-1:0] l12_x1,l12_x2,l12_d,l23_x3,l23_d,l34_f;

assign f=l34_f;

always@(posedge clk)
begin
l12_x1 <= #4 a+b;
l12_x2 <= #4 c-d;
l12_d <= d;

l23_x3 <= #4 l12_x1+l12_x2;
l23_d <= l12_d;

l34_f <= #6 l23_x3 + l23_d;
end
endmodule


