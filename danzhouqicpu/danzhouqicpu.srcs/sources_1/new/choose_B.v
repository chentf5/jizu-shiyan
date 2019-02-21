`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/18 20:05:45
// Design Name: 
// Module Name: choose_B
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


module choose_B(ALUSrc,data2,immediate,regb);
    input ALUSrc;
    input [31:0] data2;
    input [31:0] immediate;
    output [31:0] regb;
    
    always@(ALUSrc or data2 or immediate) begin
        if(ALUSrc == 0)
            regb = data2;
        else
            regb = immediate;
    end
endmodule
