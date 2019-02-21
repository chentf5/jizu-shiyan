`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/12 19:36:29
// Design Name: 
// Module Name: Ext_for_Jump
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


module Ext_for_Jump(PCadd4, addr, ext_data);
    input [31:28]PCadd4;
    input [25:0]addr;
    output reg [31:0]ext_data;

    always@(PCadd4 or addr) begin
        ext_data = {PCadd4, addr, 2'b00};
    end
endmodule
