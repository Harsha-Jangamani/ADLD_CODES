`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2023 12:55:14
// Design Name: 
// Module Name: encoder
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


module encoder(
input clk,
input reset,
input start,
input [128:1]din,
output reg sig_out,
output reg dout
    );
    
    
    parameter N = 128; 
    
    localparam idle = 2'b00,
               check_bits = 2'b01,
               add_check_bits = 2'b10,
               serial_out = 2'b11;
               
    reg [136:1]shift;
    
    reg [1:0] state,next_state;
    reg [7:0] en_counter;
    reg [8:1] parity;
    
    
    
always@(posedge clk)
begin
    if(reset) 
        begin
            sig_out <= 1'b0;
            dout    <= 0;
            state   <= idle;
        end
    else state <= next_state; 
end
    
    always@(negedge clk)
    begin
        case(state)
        idle:begin
          sig_out <= 1'b0;
          dout <= 0;
          shift <= 0;
          en_counter <= 8'h00;
          if(start) next_state <= check_bits;
          else next_state <= idle;
        end
        
        check_bits: begin
            sig_out <= 1'b0;
       
            parity[1] <=            din[1]   ^ din[2]  ^din[4]   ^din[5]   ^din[7]   ^din[9]   ^din[11]
                         ^din[12]  ^din[14]  ^din[16]  ^din[18]  ^din[20]  ^din[22]  ^din[24]  ^din[26]
                         ^din[27]  ^din[29]  ^din[31]  ^din[33]  ^din[35]  ^din[37]  ^din[39]  ^din[41]
                         ^din[43]  ^din[45]  ^din[47]  ^din[49]  ^din[51]  ^din[53]  ^din[55]  ^din[57]
                         ^din[58]  ^din[60]  ^din[62]  ^din[64]  ^din[66]  ^din[68]  ^din[70]  ^din[72]
                         ^din[74]  ^din[76]  ^din[78]  ^din[80]  ^din[82]  ^din[84]  ^din[86]  ^din[88]
                         ^din[90]  ^din[92]  ^din[94]  ^din[96]  ^din[98]  ^din[100] ^din[102] ^din[104]
                         ^din[106] ^din[108] ^din[110] ^din[112] ^din[114] ^din[116] ^din[118] ^din[120]
                         ^din[121] ^din[123] ^din[125] ^din[127];
                         
            parity[2] <=            din[1]   ^ din[3]  ^din[4]   ^din[6]   ^din[7]   ^din[10]  ^din[11]
                         ^din[13]  ^din[14]  ^din[17]  ^din[18]  ^din[21]  ^din[22]  ^din[25]  ^din[26]
                         ^din[28]  ^din[29]  ^din[32]  ^din[33]  ^din[36]  ^din[37]  ^din[40]  ^din[41]
                         ^din[44]  ^din[45]  ^din[48]  ^din[49]  ^din[52]  ^din[53]  ^din[56]  ^din[57]
                         ^din[59]  ^din[60]  ^din[63]  ^din[64]  ^din[67]  ^din[68]  ^din[71]  ^din[72]
                         ^din[75]  ^din[76]  ^din[79]  ^din[80]  ^din[83]  ^din[84]  ^din[87]  ^din[88]
                         ^din[91]  ^din[92]  ^din[95]  ^din[96]  ^din[99]  ^din[100] ^din[103] ^din[104]
                         ^din[107] ^din[108] ^din[111] ^din[112] ^din[115] ^din[116] ^din[119] ^din[120]
                         ^din[122] ^din[123] ^din[126] ^din[127];
                         
            parity[3] <=            din[2]   ^ din[3]  ^din[4]   ^din[8]   ^din[9]   ^din[10]  ^din[11]
                         ^din[15]  ^din[16]  ^din[17]  ^din[18]  ^din[23]  ^din[24]  ^din[25]  ^din[26]
                         ^din[30]  ^din[31]  ^din[32]  ^din[33]  ^din[38]  ^din[39]  ^din[40]  ^din[41]
                         ^din[46]  ^din[47]  ^din[48]  ^din[49]  ^din[54]  ^din[55]  ^din[56]  ^din[57]
                         ^din[61]  ^din[62]  ^din[63]  ^din[64]  ^din[69]  ^din[70]  ^din[71]  ^din[72]
                         ^din[77]  ^din[78]  ^din[79]  ^din[80]  ^din[85]  ^din[86]  ^din[87]  ^din[88]
                         ^din[93]  ^din[94]  ^din[95]  ^din[96]  ^din[101] ^din[102] ^din[103] ^din[104]
                         ^din[109] ^din[110] ^din[111] ^din[112] ^din[117] ^din[118] ^din[119] ^din[120]
                         ^din[124] ^din[125] ^din[126] ^din[127];
                         
            parity[4] <=            din[5]   ^ din[6]  ^din[7]   ^din[8]   ^din[9]   ^din[10]  ^din[11]
                         ^din[19]  ^din[20]  ^din[21]  ^din[22]  ^din[23]  ^din[24]  ^din[25]  ^din[26]
                         ^din[34]  ^din[35]  ^din[36]  ^din[37]  ^din[38]  ^din[39]  ^din[40]  ^din[41]
                         ^din[50]  ^din[51]  ^din[52]  ^din[53]  ^din[54]  ^din[55]  ^din[56]  ^din[57]
                         ^din[65]  ^din[66]  ^din[67]  ^din[68]  ^din[69]  ^din[70]  ^din[71]  ^din[72]
                         ^din[81]  ^din[82]  ^din[83]  ^din[84]  ^din[85]  ^din[86]  ^din[87]  ^din[88]
                         ^din[97]  ^din[98]  ^din[99]  ^din[100] ^din[101] ^din[102] ^din[103] ^din[104]
                         ^din[113] ^din[114] ^din[115] ^din[116] ^din[117] ^din[118] ^din[119] ^din[120]
                         ^din[128];    
            parity[5] <=            din[12]  ^ din[13] ^din[14]  ^din[15]  ^din[16]  ^din[17]  ^din[18]
                         ^din[19]  ^din[20]  ^din[21]  ^din[22]  ^din[23]  ^din[24]  ^din[25]  ^din[26]
                         ^din[42]  ^din[43]  ^din[44]  ^din[45]  ^din[46]  ^din[47]  ^din[48]  ^din[49]
                         ^din[50]  ^din[51]  ^din[52]  ^din[53]  ^din[54]  ^din[55]  ^din[56]  ^din[57]
                         ^din[73]  ^din[74]  ^din[75]  ^din[76]  ^din[77]  ^din[78]  ^din[79]  ^din[80]
                         ^din[81]  ^din[82]  ^din[83]  ^din[84]  ^din[85]  ^din[86]  ^din[87]  ^din[88]
                         ^din[105] ^din[106] ^din[107] ^din[108] ^din[109] ^din[110] ^din[111] ^din[112]
                         ^din[113] ^din[114] ^din[115] ^din[116] ^din[117] ^din[118] ^din[119] ^din[120];
                         
            parity[6] <=            din[27]  ^ din[28] ^din[29]  ^din[30]  ^din[31]  ^din[32]  ^din[33]
                         ^din[34]  ^din[35]  ^din[36]  ^din[37]  ^din[38]  ^din[39]  ^din[40]  ^din[41]
                         ^din[42]  ^din[43]  ^din[44]  ^din[45]  ^din[46]  ^din[47]  ^din[48]  ^din[49]
                         ^din[50]  ^din[51]  ^din[52]  ^din[53]  ^din[54]  ^din[55]  ^din[56]  ^din[57]
                         ^din[89]  ^din[90]  ^din[91]  ^din[92]  ^din[93]  ^din[94]  ^din[95]  ^din[96]
                         ^din[97]  ^din[98]  ^din[99]  ^din[100] ^din[101] ^din[102] ^din[103] ^din[104]
                         ^din[105] ^din[106] ^din[107] ^din[108] ^din[109] ^din[110] ^din[111] ^din[112]
                         ^din[113] ^din[114] ^din[115] ^din[116] ^din[117] ^din[118] ^din[119] ^din[120];   
          
            parity[7] <=            din[58]  ^ din[59] ^din[60]  ^din[61]  ^din[62]  ^din[63]  ^din[64]
                         ^din[65]  ^din[66]  ^din[67]  ^din[68]  ^din[69]  ^din[70]  ^din[71]  ^din[72]
                         ^din[73]  ^din[74]  ^din[75]  ^din[76]  ^din[77]  ^din[78]  ^din[79]  ^din[80]
                         ^din[81]  ^din[82]  ^din[83]  ^din[84]  ^din[85]  ^din[86]  ^din[87]  ^din[88]
                         ^din[89]  ^din[90]  ^din[91]  ^din[92]  ^din[93]  ^din[94]  ^din[95]  ^din[96]
                         ^din[97]  ^din[98]  ^din[99]  ^din[100] ^din[101] ^din[102] ^din[103] ^din[104]
                         ^din[105] ^din[106] ^din[107] ^din[108] ^din[109] ^din[110] ^din[111] ^din[112]
                         ^din[113] ^din[114] ^din[115] ^din[116] ^din[117] ^din[118] ^din[119] ^din[120];  
            
            parity[8] <=   ^din[121] ^din[122] ^din[123] ^din[124] ^din[125] ^din[126] ^din[127] ^din[128];                                                                                                                                         
            next_state <= add_check_bits;
        end
        
        add_check_bits : begin
            sig_out <= 1'b1;
            shift    <= {din[128:121],  parity[8], din[120:58],  parity[7], din[57:27],
                        parity[6], din[26:12],   parity[5],  din[11:5],  parity[4],
                         din[4:2],  parity[3],    din[1]  ,  parity[2], parity[1]};
            next_state <= serial_out;
        end 
        
        serial_out :begin
            sig_out <= 1'b1;
            if(en_counter < (N + 4'b1000))
            begin
                dout <= shift[136];
                shift <= {shift[135:1],1'b0};
                en_counter <= en_counter + 1'b1; 
                next_state <= serial_out;
                
            end
            else 
                begin
                    sig_out <= 1'b0;           
                    next_state <= idle;
                end
        end   
        
        default : begin
            sig_out <= 1'b0;
            dout <= 1'b0;
            next_state <= idle;
        end 
        endcase 
    end
endmodule
