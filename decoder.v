`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2023 12:06:19
// Design Name: 
// Module Name: decoder
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


module decoder(
input clk,
input reset,
input start,
input serial_in,
output reg sig_out,
output reg error,
output reg [128:1]dout
    );
    
    localparam idle = 3'b000,
     receive = 3'b001,
     xor_opn = 3'b010,
     error_flip = 3'b011,
     extract = 3'b100;
     
     
     reg [2:0] state,next_state;
     
     reg [136:1] shift;
     reg [7:0]dec_counter;
     reg [8:1]parity;
     
always@(posedge clk)
begin
if(reset) begin
    sig_out <= 1'b0;
    next_state <= idle;
    dout <= 0;
    dec_counter <= 8'h00;
end
//else state <= next_state;
//end

//always@(negedge clk)
else
begin
case(next_state)
    idle : begin
        sig_out <= 1'b0;
        shift <= 0;
        error <= 1'b0;
        dec_counter <= 8'h00;
        if(start) next_state <= receive;
        else next_state <= idle;
    end
    
    receive : begin
        if(dec_counter < 8'd136)
        begin
            shift <= {shift[135:1],serial_in};
            sig_out <= 1'b0; 
            error <= 1'b0;
            dec_counter <= dec_counter + 1'b1;
            next_state <= receive;            
        end
        else 
            begin
            dec_counter <= 8'h00;
            error <= 1'b0;
            next_state <= xor_opn;
            end
    end
    
    xor_opn:begin
        parity[1] <=  shift[1]   ^ shift[3]   ^ shift[5]   ^ shift[7]   ^ shift[9]   ^ shift[11]  ^ shift[13]  ^ shift[15]
                    ^ shift[17]  ^ shift[19]  ^ shift[21]  ^ shift[23]  ^ shift[25]  ^ shift[27]  ^ shift[29]  ^ shift[31] 
                    ^ shift[33]  ^ shift[35]  ^ shift[37]  ^ shift[39]  ^ shift[41]  ^ shift[43]  ^ shift[45]  ^ shift[47] 
                    ^ shift[49]  ^ shift[51]  ^ shift[53]  ^ shift[55]  ^ shift[57]  ^ shift[59]  ^ shift[61]  ^ shift[63] 
                    ^ shift[65]  ^ shift[67]  ^ shift[69]  ^ shift[71]  ^ shift[73]  ^ shift[75]  ^ shift[77]  ^ shift[79] 
                    ^ shift[81]  ^ shift[83]  ^ shift[85]  ^ shift[87]  ^ shift[89]  ^ shift[91]  ^ shift[93]  ^ shift[95] 
                    ^ shift[97]  ^ shift[99]  ^ shift[101] ^ shift[103] ^ shift[105] ^ shift[107] ^ shift[109] ^ shift[111] 
                    ^ shift[113] ^ shift[115] ^ shift[117] ^ shift[119] ^ shift[121] ^ shift[123] ^ shift[125] ^ shift[127]
                    ^ shift[129] ^ shift[131] ^ shift[133] ^ shift[135];
                    
        parity[2] <=  shift[2]   ^ shift[3]   ^ shift[6]   ^ shift[7]   ^ shift[10]  ^ shift[11]  ^ shift[14]  ^ shift[15]
                    ^ shift[18]  ^ shift[19]  ^ shift[22]  ^ shift[23]  ^ shift[26]  ^ shift[27]  ^ shift[30]  ^ shift[31] 
                    ^ shift[34]  ^ shift[35]  ^ shift[38]  ^ shift[39]  ^ shift[42]  ^ shift[43]  ^ shift[46]  ^ shift[47] 
                    ^ shift[50]  ^ shift[51]  ^ shift[54]  ^ shift[55]  ^ shift[58]  ^ shift[59]  ^ shift[62]  ^ shift[63] 
                    ^ shift[66]  ^ shift[67]  ^ shift[70]  ^ shift[71]  ^ shift[74]  ^ shift[75]  ^ shift[78]  ^ shift[79] 
                    ^ shift[82]  ^ shift[83]  ^ shift[86]  ^ shift[87]  ^ shift[90]  ^ shift[91]  ^ shift[94] ^ shift[95] 
                    ^ shift[98]  ^ shift[99]  ^ shift[102] ^ shift[103] ^ shift[106] ^ shift[107] ^ shift[110] ^ shift[111] 
                    ^ shift[114] ^ shift[115] ^ shift[118] ^ shift[119] ^ shift[122] ^ shift[123] ^ shift[126] ^ shift[127]
                    ^ shift[130] ^ shift[131] ^ shift[134] ^ shift[135];
                    
        parity[3] <=  shift[4]   ^ shift[5]   ^ shift[6]   ^ shift[7]   ^ shift[12]  ^ shift[13]  ^ shift[14]  ^ shift[15]
                    ^ shift[20]  ^ shift[21]  ^ shift[22]  ^ shift[23]  ^ shift[28]  ^ shift[29]  ^ shift[30]  ^ shift[31] 
                    ^ shift[36]  ^ shift[37]  ^ shift[38]  ^ shift[39]  ^ shift[44]  ^ shift[45]  ^ shift[46]  ^ shift[47] 
                    ^ shift[52]  ^ shift[53]  ^ shift[54]  ^ shift[55]  ^ shift[60]  ^ shift[61]  ^ shift[62]  ^ shift[63] 
                    ^ shift[68]  ^ shift[69]  ^ shift[70]  ^ shift[71]  ^ shift[76]  ^ shift[77]  ^ shift[78]  ^ shift[79] 
                    ^ shift[84]  ^ shift[85]  ^ shift[86]  ^ shift[87]  ^ shift[92]  ^ shift[93]  ^ shift[94] ^ shift[95] 
                    ^ shift[100] ^ shift[101] ^ shift[102] ^ shift[103] ^ shift[108] ^ shift[109] ^ shift[110] ^ shift[111] 
                    ^ shift[116] ^ shift[117] ^ shift[118] ^ shift[119] ^ shift[124] ^ shift[125] ^ shift[126] ^ shift[127]
                    ^ shift[132] ^ shift[133] ^ shift[134] ^ shift[135]; 
        parity[4] <=  shift[8]   ^ shift[9]   ^ shift[10]  ^ shift[11]  ^ shift[28]  ^ shift[29]  ^ shift[30]  ^ shift[31] 
                    ^ shift[40]  ^ shift[41]  ^ shift[42]  ^ shift[43]  ^ shift[44]  ^ shift[45]  ^ shift[46]  ^ shift[47] 
                    ^ shift[56]  ^ shift[57]  ^ shift[58]  ^ shift[59]  ^ shift[60]  ^ shift[61]  ^ shift[62]  ^ shift[63] 
                    ^ shift[72]  ^ shift[73]  ^ shift[74]  ^ shift[75]  ^ shift[76]  ^ shift[77]  ^ shift[78]  ^ shift[79] 
                    ^ shift[88]  ^ shift[89]  ^ shift[90]  ^ shift[91]  ^ shift[92]  ^ shift[93]  ^ shift[94] ^ shift[95] 
                    ^ shift[104] ^ shift[105] ^ shift[106] ^ shift[107] ^ shift[108] ^ shift[109] ^ shift[110] ^ shift[111] 
                    ^ shift[120] ^ shift[121] ^ shift[122] ^ shift[123] ^ shift[124] ^ shift[125] ^ shift[126] ^ shift[127]
                    ^ shift[136];                     
        parity[5] <=  shift[16]  ^ shift[17]  ^ shift[18]  ^ shift[19]  ^ shift[20]  ^ shift[21]  ^ shift[22]  ^ shift[23]
                    ^ shift[24]  ^ shift[25]  ^ shift[26]  ^ shift[27]  ^ shift[28]  ^ shift[29]  ^ shift[30]  ^ shift[31] 
                    ^ shift[48]  ^ shift[49]  ^ shift[50]  ^ shift[51]  ^ shift[52]  ^ shift[53]  ^ shift[54]  ^ shift[55] 
                    ^ shift[56]  ^ shift[57]  ^ shift[58]  ^ shift[59]  ^ shift[60]  ^ shift[61]  ^ shift[62]  ^ shift[63] 
                    ^ shift[80]  ^ shift[81]  ^ shift[82]  ^ shift[83]  ^ shift[84]  ^ shift[85]  ^ shift[86]  ^ shift[87] 
                    ^ shift[88]  ^ shift[89]  ^ shift[90]  ^ shift[91]  ^ shift[92]  ^ shift[93]  ^ shift[94]  ^ shift[95] 
                    ^ shift[112] ^ shift[113] ^ shift[114] ^ shift[115] ^ shift[116] ^ shift[117] ^ shift[118] ^ shift[119] 
                    ^ shift[120] ^ shift[121] ^ shift[122] ^ shift[123] ^ shift[124] ^ shift[125] ^ shift[126] ^ shift[127]; 
                                                          
        parity[6] <=  shift[32]  ^ shift[33]  ^ shift[34]  ^ shift[35]  ^ shift[36]  ^ shift[37]  ^ shift[38]  ^ shift[39]
                    ^ shift[40]  ^ shift[41]  ^ shift[42]  ^ shift[43]  ^ shift[44]  ^ shift[45]  ^ shift[46]  ^ shift[47] 
                    ^ shift[48]  ^ shift[49]  ^ shift[50]  ^ shift[51]  ^ shift[52]  ^ shift[53]  ^ shift[54]  ^ shift[55] 
                    ^ shift[56]  ^ shift[57]  ^ shift[58]  ^ shift[59]  ^ shift[60]  ^ shift[61]  ^ shift[62]  ^ shift[63] 
                    ^ shift[96]  ^ shift[97]  ^ shift[98]  ^ shift[99]  ^ shift[100] ^ shift[101] ^ shift[102] ^ shift[103] 
                    ^ shift[104] ^ shift[105] ^ shift[106] ^ shift[107] ^ shift[108] ^ shift[109] ^ shift[110] ^ shift[111] 
                    ^ shift[112] ^ shift[113] ^ shift[114] ^ shift[115] ^ shift[116] ^ shift[117] ^ shift[118] ^ shift[119] 
                    ^ shift[120] ^ shift[121] ^ shift[122] ^ shift[123] ^ shift[124] ^ shift[125] ^ shift[126] ^ shift[127];
                     
        parity[7] <=  shift[64]  ^ shift[65]  ^ shift[66]  ^ shift[67]  ^ shift[68]  ^ shift[69]  ^ shift[70]  ^ shift[71]
                    ^ shift[72]  ^ shift[73]  ^ shift[74]  ^ shift[75]  ^ shift[76]  ^ shift[77]  ^ shift[78]  ^ shift[79] 
                    ^ shift[80]  ^ shift[81]  ^ shift[82]  ^ shift[83]  ^ shift[84]  ^ shift[85]  ^ shift[86]  ^ shift[87] 
                    ^ shift[88]  ^ shift[89]  ^ shift[90]  ^ shift[91]  ^ shift[92]  ^ shift[93]  ^ shift[94]  ^ shift[95] 
                    ^ shift[96]  ^ shift[97]  ^ shift[98]  ^ shift[99]  ^ shift[100] ^ shift[101] ^ shift[102] ^ shift[103] 
                    ^ shift[104] ^ shift[105] ^ shift[106] ^ shift[107] ^ shift[108] ^ shift[109] ^ shift[110] ^ shift[111] 
                    ^ shift[112] ^ shift[113] ^ shift[114] ^ shift[115] ^ shift[116] ^ shift[117] ^ shift[118] ^ shift[119] 
                    ^ shift[120] ^ shift[121] ^ shift[122] ^ shift[123] ^ shift[124] ^ shift[125] ^ shift[126] ^ shift[127];
                     
        parity[8]  <=  shift[128] ^ shift[129] ^shift[130]  ^shift[131]  ^shift[132]  ^shift[133]  ^shift[134]  ^shift[135] 
                      ^  shift[136] ;  
        dec_counter    <= 8'h00;
        sig_out <= 1'b0;   
        error <= 1'b0;                          
        next_state <= error_flip;                            
    end
    
    error_flip : begin   
        if(parity != 8'h00)
        begin
            error <= 1'b1;
            shift[parity] <= ~shift[parity];
        end
        else error <= 1'b0;
        next_state    <= extract;    
        dec_counter       <= 8'h00;
        sig_out <= 1'b0;   
    end
    
    extract : begin
            sig_out <= 1'b1;
            dout <= {shift[136:129],shift[127:65],shift[63:33],shift[31:17],
                     shift[15:9],shift[7:5],shift[3]};
            next_state <= idle;
    end
    default : begin
        next_state <= idle;
        dec_counter <= 8'h00;
        sig_out <= 1'b0;
        error <= 1'b0;
        dout <= 0;
    end

endcase

end
end ///////////////
endmodule
