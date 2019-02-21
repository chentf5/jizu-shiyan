`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/12 19:22:23
// Design Name: 
// Module Name: chooser
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



module Data_Sel2_32bits(dataA, dataB, SrcSel, dataOutput);
    input [31:0] dataA, dataB;
    input SrcSel;
    output [31:0] dataOutput;
    assign dataOutput = (SrcSel == 0 ? dataA : dataB);
endmodule


