`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/12 19:50:27
// Design Name: 
// Module Name: Data_Sel4_32bits
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


module Data_Sel4_32bits(dataA, dataB, dataC, dataD, SelSrc, Output);
    input [31:0] dataA, dataB, dataC, dataD;
    input [1:0] SelSrc; 
    output reg [31:0] Output;
    
    always@(dataA or dataB or dataC or dataD or SelSrc) begin
        case(SelSrc)
            2'b00 : Output = dataA;
            2'b01 : Output = dataB;
            2'b10 : Output = dataC;
            2'b11 : Output = dataD;
        endcase
    end
endmodule

