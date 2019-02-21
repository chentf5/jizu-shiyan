`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/12 19:40:43
// Design Name: 
// Module Name: ALU_32bits
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


module ALU_32bits(ALUSrc_A, ALUSrc_B, ALUOp, result, zero, sign);
    input [31:0] ALUSrc_A;    
    input [31:0] ALUSrc_B;
    input [2:0] ALUOp; 
    output reg [31:0] result;
    output zero, sign;    
                
    assign zero = (result == 0 ? 1 : 0); 
    assign sign = result[31];                      
    always@(ALUOp or ALUSrc_A or ALUSrc_B) begin        
        case(ALUOp)          
            3'b000 : result = ALUSrc_A + ALUSrc_B;          
            3'b001 : result = ALUSrc_A - ALUSrc_B;   
            3'b010 : result = ALUSrc_B << ALUSrc_A;   
            3'b011 :  result = ALUSrc_A | ALUSrc_B;
            3'b100 : result = ALUSrc_B & ALUSrc_A;     
            3'b101 : result = (ALUSrc_A < ALUSrc_B) ? 1 : 0;           
            3'b110 : begin                                      // ´ø·ûºÅ±È½Ï                     
                       if (ALUSrc_A < ALUSrc_B && (ALUSrc_A[31] ==  ALUSrc_B[31]))                            
                                    result = 1;                   
                                    else if (ALUSrc_A[31] == 1 && ALUSrc_B[31] == 0)  
                                        result = 1;                    
                                    else result = 0;                           
                                 end
            3'b111 : result = ALUSrc_A ^ ALUSrc_B;      
            default : begin                             
                $display (" no match in ALU32\n");           
            end         
        endcase     
    end 
endmodule
