`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/18 14:15:47
// Design Name: 
// Module Name: signzeroextend
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


module signzeroextend(ExtSel,im,out);
    input ExtSel;
    input [15:0] im;
    output [31:0] out;
    assign out[15:0] = im;
    assign out[31:16] = ExtSel ? (im[15] ? 16'hffff : 16'h0000) : 16'h0000;
endmodule
