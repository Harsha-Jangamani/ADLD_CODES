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

output reg car_count
output reg fs_detect;
output reg correct_password;
output reg bs_detect;

always@(posedge clk,negedge rst)
begin
if(rst)
cst <= S0;//S0
car_count <= 4'b0;
else 
cst <= nst;//nst
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
	bs_detect=1'b1;
	nst=S0; end
	else begin
	car_parked=1'b0;
	nst=S0 ; end
	end
	endcase

end
endmodule




	




