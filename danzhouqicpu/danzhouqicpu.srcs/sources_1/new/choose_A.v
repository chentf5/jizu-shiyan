`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/18 15:22:44
// Design Name: 
// Module Name: choose_A
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


module choose_A(sa,data1,ALUSrcA,rega);
    input [4:0] sa;
    input [31:0] data1;
    input ALUSrc;
    output [31:0] rega;
    
    always@(ALUSrc or data1 or sa) begin
        if (ALUSrc == 0)
            rega = data1;
        else
            rega = { 27'b000000000000000000000000000,sa };
     end
endmodule
