`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/12 19:16:23
// Design Name: 
// Module Name: chooseA
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


module Reg_32bits(CLK, dataIn, dataOut);
    input CLK;
    input [31:0] dataIn;
    output reg [31:0] dataOut;
    
    always@(negedge CLK) begin
        dataOut <= dataIn;
    end
endmodule