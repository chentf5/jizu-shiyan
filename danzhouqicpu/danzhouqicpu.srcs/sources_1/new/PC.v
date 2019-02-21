`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/18 12:09:39
// Design Name: 
// Module Name: PC
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


module PC(clk,ReSet,PCWre,PCSrc,immeditate,Out,addr);
    input clk,ReSet,PCWre;
    input [1:0] PCSrc;
    input [31:0] immeditate;
    input [25:0] addr;
    output [31:0] Out;
    reg [31:0] Out;
    
    always @(negedge clk or negedge ReSet)
        begin
            if(ReSet==0) begin
                        Out = 0;
                        end
            else if (PCWre) begin
                case(PCSrc)
                2'b00 : Out = Out + 4;
                2'b01 : Out = Out + 4 + immeditate*4;
                2'b10 : begin
                            Out[27:2] = addr[25:0];
                            Out[1:0] = 2'b00;
                            Out = Out + 4;
                         end
                default : begin
                        Out = Out + 4;
                    end
                endcase
             end
        end
endmodule
