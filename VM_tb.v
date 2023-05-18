`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2023 20:28:46
// Design Name: 
// Module Name: VM_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module VM_tb();
reg clk;
reg rst;
reg sel_a;
reg sel_b;
reg sel_c;
reg sel_d;
reg coin_5;
reg coin_10;
wire disp_a;
wire disp_b;
wire disp_c;
wire disp_d;
wire change_5;
wire change_10;

Vending_Machine DUT(.clk(clk),.rst(rst),.sel_a(sel_a),.sel_b(sel_b),.sel_c(sel_c),.sel_d(sel_d),.coin_5(coin_5),
.coin_10(coin_10),.disp_a(disp_a),.disp_b(disp_b),.disp_c(disp_c),.disp_d(disp_d),.change_5(change_5),
.change_10(change_10));

initial begin
clk=0;
rst=1;
sel_a=0;
sel_b=0;
sel_c=0;
sel_d=0;
coin_5=0;
coin_10=0;

#100
clk=1;
rst=0;
sel_a=1;
sel_b=0;
sel_c=0;
sel_d=0;
coin_5=1;
coin_10=0;

end

initial clk=0;
always clk=~clk;

endmodule
