module assignment1_tb();
reg clk;
reg fs_car;
reg bs_car;
reg rst;
reg [3:0] password1;
wire [3:0] password2;
wire car_parked;
wire fs_detect;
wire bs_detect;
wire correct_password;
wire car_count;

assignment1 DUT(.clk(clk),
.fs_car(fs_car),
.bs_car(bs_car),
.rst(rst),
.password1(password1),
.password2(password2),
.car_parked(car_parked),
.fs_detect(fs_detect),
.bs_detect(bs_detect),
.correct_password(correct_password),
.car_count(car_count)
);

initial clk=0;
always#5 clk=~clk;
assign password2=4'b0101;

initial begin
clk=0;
fs_car=0;
bs_car=0;
rst=1;
password1=4'b0;
#10;
$display("clk=%b fs_car=%b bs_car=%b rst=%b password1=%b password2=%b car_parked=%b fs_detect=%b bs_detect=%b correct_password=%b car_count=%b",clk,fs_car,bs_car,rst,password1,password2,car_parked,fs_detect,bs_detect,correct_password,car_count);

clk=1;
rst=0;
fs_car=1;
bs_car=0;
#10 password1=4'b1010;
#10 bs_car=1;
#10 fs_car=0;
#10;
$display("clk=%b fs_car=%b bs_car=%b rst=%b password1=%b password2=%b car_parked=%b fs_detect=%b bs_detect=%b correct_password=%b car_count=%b",clk,fs_car,bs_car,rst,password1,password2,car_parked,fs_detect,bs_detect,correct_password,car_count);

clk=1;
rst=0;
fs_car=1;
bs_car=0;
#10 password1=4'b0101;
#10 bs_car=1;
#10 fs_car=0;
$display("clk=%b fs_car=%b bs_car=%b rst=%b password1=%b password2=%b car_parked=%b fs_detect=%b bs_detect=%b correct_password=%b car_count=%b",clk,fs_car,bs_car,rst,password1,password2,car_parked,fs_detect,bs_detect,correct_password,car_count);

clk=1;
rst=0;
fs_car=1;
bs_car=0;
#10 password1=4'b0101;
#10 bs_car=1;
#10 fs_car=0;
$display("clk=%b fs_car=%b bs_car=%b rst=%b password1=%b password2=%b car_parked=%b fs_detect=%b bs_detect=%b correct_password=%b car_count=%b",clk,fs_car,bs_car,rst,password1,password2,car_parked,fs_detect,bs_detect,correct_password,car_count);
#300 $finish;

end
endmodule

/* Design code */

module assignment1(clk,fs_car,bs_car,rst,password1,password2,car_parked,car_count,fs_detect,correct_password,bs_detect);
input clk;
input fs_car;
input bs_car;

input rst;
input [3:0] password1;
input [3:0] password2;
output reg car_parked;

assign password2=4'b0101;

reg [1:0]cst,nst;

parameter S0=0,S1=1,S2=2;

output reg car_count;
output reg fs_detect;
output reg correct_password;
output reg bs_detect;

always@(posedge clk,negedge rst)
begin
if(rst) begin
cst <= S0;
car_count <= 4'b0;end
else 
cst <= nst;
end

always@(*)
begin
case(cst)
S0: begin
if(fs_car) begin
	fs_detect=1'b1;
	nst=S1; end 
	else begin
	fs_detect=1'b0;
	nst=S0;	end
end

S1:begin
if(password1==password2) begin
correct_password=1'b1;
nst=S2; end
else begin
correct_password=1'b0;
nst=S1; end
end

S2:begin
if(bs_car) begin
car_parked=1'b1;
car_count=car_count+1;
nst=S0; end
else begin
car_parked=1'b0;
bs_detect=1'b1;
nst=S0; end
end
endcase

end
endmodule




	





	





	




	





	




