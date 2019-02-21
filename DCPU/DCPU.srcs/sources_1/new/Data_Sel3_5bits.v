`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/12 19:33:21
// Design Name: 
// Module Name: Data_Sel3_5bits
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


module Data_Sel3_5bits(dataA, dataB, dataC, SelSrc, Output);
    input [4:0] dataA, dataB, dataC;
    input [1:0] SelSrc; 
    output reg [4:0] Output;
    
    always@(dataA or dataB or dataC or SelSrc) begin
        case(SelSrc)
            2'b00 : Output = dataA;
            2'b01 : Output = dataB;
            2'b10 : Output = dataC;
            2'b11 : Output = 0;
        endcase
    end
endmodule
