module alupp_tb();
reg [3:0] rs1,rs2,rd,func;
reg clk1;
reg [7:0] addr;
wire [15:0] z;
integer k;

alupp dut(.rs1(rs1),.rs2(rs2),.rd(rd),.func(func),.clk1(clk1),.addr(addr),.z(z));

initial begin
clk1=0;
//clk2=0;
repeat(20)
begin
#5 clk1=1;clk1=0;
//#5 clk2=1;clk2=0;
end
end

initial 
for(k=0;k<16;k=k+1)
dut.regbank[k]=k;
initial begin

#10 rs1=3;rs2=5; rd=10; func=0;addr=125;
#10 rs1=3;rs2=8; rd=12; func=2;addr=126;
#10 rs1=10;rs2=5; rd=14; func=1;addr=128;
#10 rs1=7;rs2=3; rd=13; func=11;addr=127;
#10 rs1=10;rs2=5; rd=15; func=1;addr=129;
#10 rs1=12;rs2=13; rd=16; func=0;addr=130;

#60 for(k=125;k<131;k=k+1)
$display("mem[%3d]=%3d",k,dut.mem[k]);
end

initial begin
$dumpfile("alupp.vcd");
$dumpvars (0, alupp_tb);
$monitor("Time:%3d,F=%3d",$time,z);
#500 $finish;
end
endmodule

module alupp(rs1,rs2,rd,addr,func,clk1,z);
input [3:0] rs1,rs2,rd,func;
input clk1;
input [7:0] addr;
output [15:0] z; 

reg [15:0] l12_a,l12_b,l23_z,l34_z;
reg [3:0] l12_rd,l12_func,l23_rd;
reg [7:0] l12_addr,l23_addr,l34_addr;

reg [15:0] regbank [0:15];
reg [15:0] mem [0:255];

assign z=l34_z;

always@(posedge clk1)
begin
l12_a <= #2 regbank[rs1];
l12_b <= #2 regbank[rs2];
l12_rd <= #2 rd;
l12_func <= #2 func;
l12_addr <= #2 addr;
end

always@(negedge clk1)
begin
case(func)

0:l23_z <= #2 l12_a + l12_b;

1:l23_z <= #2 l12_a - l12_b;

2:l23_z <= #2 l12_a * l12_b;

3:l23_z <= #2 l12_a;

4:l23_z <= #2 l12_b;

5:l23_z <= #2 l12_a & l12_b;

6:l23_z <= #2 l12_a | l12_b;

7:l23_z <= #2 l12_a ^ l12_b;

8:l23_z <= #2 ~l12_a;

9:l23_z <= #2 ~l12_b;

10:l23_z <= #2 l12_a >> 1;

11:l23_z <= #2 l12_a << 1;

default:l23_z <= #2 16'h0000;

endcase

l23_rd <= #2 l12_rd;
l23_addr <= #2 l12_addr;
end

always@(posedge clk1)
begin
regbank[l23_rd] <= #2 l23_z;
l34_z <= #2 l23_z;
l34_addr <= #2 l23_addr;
end

always@(negedge clk1)
begin
mem[l34_addr] <= #2 l34_z;
end

endmodule




