module memory_tb();
parameter N=10;
reg [N-1:0] a,b,c,d;
reg clk;
wire [N-1:0]f;

pipe_ex_ DUT(.a(a),.b(b),.c(c),.d(d),.clk(clk),.f(f));
initial begin
$monitor ("a=%d b=%d c=%d d=%d f=%d",a,b,c,d,f);
clk=1'b0;
a=10'd10;
b=10'd20;
c=10'd15;
d=10'd25;
#10

a=10'd15;
b=10'd10;
c=10'd13;
d=10'd20;
#10
a=10'd15;
b=10'd10;
c=10'd13;
d=10'd20;
#10
a=10'd15;
b=10'd10;
c=10'd13;
d=10'd20;
end 

always #5 clk=~clk;

endmodule


module pipe_ex_(f,a,b,c,d,clk);
parameter N=10;
input [N-1:0] a,b,c,d;
input clk;
output [N-1:0]f;
reg [N-1:0]l12_x1,l12_x2,l12_d,l23_x3,l23_d,l34_f;

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



