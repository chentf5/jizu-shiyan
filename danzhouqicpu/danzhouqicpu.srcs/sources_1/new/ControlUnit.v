`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/18 15:12:17
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(ins,zero,sign,PCWre,ALUSrcA,ALUSrcB,DBDataSrc,RegWre,InsMemRW,mRD,mWR,RegDst,ExtSel,PCSrc,ALUOp);
    input [5:0] ins;
    input zero,sign;
    output PCWre,ALUSrcA,ALUSrcB,DBDataSrc,RegWre,InsMemRW,mRD,mWR,RegDst,ExtSel;
    output [1:0] PCSrc;
    output [2:0] ALUOp;

        assign PCWre = (ins == 6'b111111)?0:1;
        assign ALUSrcA = (ins == 6'b011000)?1:0;
        assign ALUSrcB = (ins == 6'b000010 || ins == 6'b010000 || ins == 6'b010010 || ins == 6'b011100 || ins == 6'b100110 || ins == 6'b100111) ?1:0;
        assign DBDataSrc = (ins == 6'b100111)?1:0;
        assign RegWre = (ins == 6'b100110 || ins == 6'b110000 || ins == 6'b110001 || ins == 6'b110010 || ins == 6'b111111)? 0:1;
        assign mRD = (ins == 6'b100111)? 0:1;
        assign mWR = (ins == 6'b100110)? 0:1;
        assign RegDst = (ins == 6'b000000 || ins == 6'b000001 || ins == 6'b010001 || ins == 6'b010011 || ins == 6'b011000)?1:0;
        assign ExtSel = (ins == 6'b010000 || ins == 6'b010010)? 0:1;
        
        assign PCSrc[1] = (ins == 6'b111000)? 1:0;
        assign PCSrc[0] = ((ins == 6'b110000 && zero == 1) || (ins == 6'b110001 && zero == 0) || ins == 6'b110010)?1:0;
        assign ALUOp[2] = (ins == 6'b010000 || ins == 6'b010001 || ins == 6'b011100 || ins == 6'b110010)? 1:0;
        assign ALUOp[1] = (ins == 6'b010010 || ins == 6'b010011 || ins == 6'b011000 || ins == 6'b110010)? 1:0;
        assign ALUOp[0] = (ins == 6'b000000 || ins == 6'b000010|| ins == 6'b010000 || ins == 6'b010001 || ins == 6'b011000 || ins == 6'b100110 || ins == 6'b100111 || ins == 6'b110010)?0:1;

endmodule
