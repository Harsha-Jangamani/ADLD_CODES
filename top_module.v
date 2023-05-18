`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2023 15:05:26
// Design Name: 
// Module Name: top_module
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


module top_module(
input clk,
input reset,
input start,
input [128:1]din,
input [7:0]key,
output reg key_found,
output signal_out,
output error_sig,
output [128:1]data
    );
    
    reg [7:0]counter;
    reg cntrl = 1'b1;
    
    wire dec_start;
    wire serial;
    wire out;
    wire temp_error;
    wire [128:1] temp_data;
        
encoder dut(.clk(clk),
    .reset(reset),
    .start(start),
    .din(din),
    .sig_out(dec_start),
    .dout(serial));
    
decoder uut(.clk(clk),
    .reset(reset),
    .start(dec_start),
    .serial_in(out),
    .sig_out(signal_out),
    .error(temp_error),
    .dout(temp_data));
    
    
always@(negedge clk)
begin
if(reset || !dec_start)
begin
    counter <= 8'h01;
    key_found <= 1'b0;
end
else
    begin
     if(counter < 8'd137)
     begin
        if((8'd137-(key)) == counter) key_found <= 1'b1; 
        else key_found <= 1'b0; 
        counter <= counter +1'b1;
     end
     else 
        counter <= 8'h01;
    end
end

assign out = (counter == (8'd138-(key)) )?(~serial):serial;
assign data = temp_data;
assign error_sig = temp_error;
       
endmodule
