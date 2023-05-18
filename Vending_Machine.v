`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2023 18:58:14
// Design Name: 
// Module Name: Vending_Machine
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


module Vending_Machine(
input clk,
input rst,
input sel_a,
input sel_b,
input sel_c,
input sel_d,
input coin_5,
input coin_10,
output reg disp_a,
output reg disp_b,
output reg disp_c,
output reg disp_d,
output reg change_5,
output reg change_10
);

localparam IDLE=3'b000,PRODUCT_SELECTED=3'b001,AMT_RECEIVED=3'b010,DISPENSE_PRODUCT=3'b011,DISPENSE_CHANGE=3'b100;
reg [2:0] state,next_state;
reg [3:0] change ,price;
reg dispensed;
reg change_5_dispensed,change_10_dispensed;

always@(posedge clk) begin
if(rst) begin
state <= IDLE;
dispensed <= 0;
price <= 0;
change <= 0;
disp_a <= 0;
disp_b <= 0;
disp_c <= 0;
disp_d <= 0;
change_5_dispensed <= 0;
change_10_dispensed <= 0;
end else
state <= next_state;

case(state)

IDLE: begin
if(sel_a) begin
price <= 5;
next_state <= PRODUCT_SELECTED;
end else if(sel_b) begin
price <= 10;
next_state <= PRODUCT_SELECTED;
end else if(sel_c) begin
price <= 15;
next_state <= PRODUCT_SELECTED;
end else if(sel_d) begin
price <= 20;
next_state <= PRODUCT_SELECTED;
end else
next_state <= IDLE;
end 

PRODUCT_SELECTED:begin
if(coin_5) begin
change <= change +5;
next_state <= AMT_RECEIVED;
end else if(coin_10) begin
change <= change +10;
next_state <= AMT_RECEIVED;
end else next_state <= PRODUCT_SELECTED;
end

AMT_RECEIVED:begin
if(change >= price) begin
dispensed <= 1;
change <= change - price;
next_state <= DISPENSE_PRODUCT;
end else
next_state <= AMT_RECEIVED;
end

DISPENSE_PRODUCT:begin
if(dispensed) begin
if(sel_a) 
disp_a <= 1;
else if(sel_b)
disp_b <=1;
else if(sel_c) 
disp_c <= 1;
else if(sel_d)
disp_d <= 1;
change_5_dispensed <= (change >= 5);
change_10_dispensed <= (change >= 10);
if(change_5_dispensed) begin
change_5 <= 1;
change <= change-5;
end
if(change_10_dispensed) begin
change_10 <= 1;
change <= change-10;
end
next_state <= DISPENSE_CHANGE;
end else begin
next_state <= DISPENSE_PRODUCT;
end
end

DISPENSE_CHANGE: begin
if (change_5_dispensed && change >= 5) begin
change_5 <= 1;
change_5_dispensed <= 0;
change <= change - 5;
end else if (change_10_dispensed && change >= 10) begin
change_10 <= 1;
change_10_dispensed <= 0;
change <= change - 10;
end else if (change_5_dispensed || change_10_dispensed) begin
next_state <= DISPENSE_CHANGE;
end else begin
next_state <= IDLE;
dispensed <= 0;
price <= 0;
change <= 0;
disp_a <= 0;
disp_b <= 0;
disp_c <= 0;
disp_d <= 0;
end
end
endcase
end
endmodule
