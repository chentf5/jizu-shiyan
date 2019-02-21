`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/18 23:26:11
// Design Name: 
// Module Name: singleStyleCPU
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


module singleStyleCPU(
      input clk, Reset,
      wire[5:0] opCode,
          wire[31:0] Out1,Out2,curPC,Result
    );
    wire zero,sign,PCWre,ALUSrcA,ALUSrcB,DBDataSrc,RegWre,InsMemRW,mRD,mWR,RegDst,ExtSel;
    wire [2:0] ALUOp;
    wire [1:0] PCSrc;
    wire [31:0] Extout;
    wire [15:0] immediate;
    wire [31:0] DataOut;

    wire [4:0] rs,rt,rd;
    wire [4:0] sa;
    wire [25:0] jump;
    wire [31:0] instruction;
    assign opCode = instruction[31:26]; //6
    assign rs = instruction[25:21]; //5
    assign rt = instruction[20:16];//5
    assign rd = instruction[15:11];
    assign sa = instruction[10:6];
    assign immediate = instruction[15:0];
    assign jump = instruction[25:0];
    //wire [25:0] addr;
    ALU alu(Out1,Out2,Extout,sa,ALUSrcA,ALUSrcB,ALUOp,zero,sign,Result);
    PC pc(clk,Reset,PCWre,PCSrc,Extout,curPC,jump);
    ControlUnit CU(opCode,zero,sign,PCWre,ALUSrcA,ALUSrcB,DBDataSrc,RegWre,InsMemRW,mRD,mWR,RegDst,ExtSel,PCSrc,ALUOp);
    RAM men(clk,Result,Out2,mRD,mWR,DataOut);
    ROM instruction(InsMemRW,curPC,instruction);
    RegFile regfile(clk,Reset,RegWre,RegDst,rs,rt,rd,DBDataSrc,Result,DataOut,Out1,Out2);
    signzeroextend extend(ExtSel,immediate,Extout);
    
endmodule
