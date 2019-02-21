`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/12 19:53:41
// Design Name: 
// Module Name: cpu
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


module cpu(
    CLK,
    Reset,
    Instruction,
    OpCode,
    rs,
    rt,
    rd,
    curPCAddr,
	nextPCAddr,
    writeData,
    Result, //test
    ReadData1,
    ReadData2,
    Immediate,
    sa,
    ALUOp,
    ALUSrcA,
    ALUSrcB
    );
    
    input CLK, Reset;
    output [31:0] Instruction, nextPCAddr, curPCAddr, writeData, Result, ReadData1, ReadData2, Immediate;
    output [5:0] OpCode;
    output [4:0] rs, rt, rd, sa;
    output [2:0] ALUOp;
    output ALUSrcA, ALUSrcB;
    
    wire [31:0] PC4, curIns, regIns, DB, DBDRSrc, ext_data, extendData, ASrcA, BSrcA, ALUA, ALUB, PCSrc1, DAddr, DataOut; 
    wire [4:0] WrReg;
    wire zero, sign, ExtSel, PCWre, IRWre, InsMemRW, RegWre, ALUSrcA, ALUSrcB, nRD, nWR, DBDataSrc;
    wire [1:0] RegDst;
    wire [1:0] PCSrc;
    
    
    // 为输出的值赋值
    assign Instruction = regIns;
    assign Immediate = extendData;
    assign OpCode = regIns[31:26];
    assign rs = regIns[25:21];
    assign rt = regIns[20:16];
    assign rd = regIns[15:11];
    assign sa = regIns[10:6];
    
    PC PC(PCWre, Reset, CLK, nextPCAddr, curPCAddr);
    
    PC_add4 PC_add4(curPCAddr, PC4);
    
    Ins_Mem Ins_Mem(InsMemRW, curPCAddr, curIns);
    
    IR IR(IRWre, CLK, curIns, regIns);
    
    Data_Sel3_5bits WrRegSrc(5'b11111, rt, rd, RegDst, WrReg);
    
    Data_Sel2_32bits WrDataSrc(PC4, DB, WrRegDSrc, writeData);
    
    Ext_for_Jump Ext_for_Jump(PC4[31:28], regIns[25:0], ext_data);
    
    Sign_Ext Sign_Ext(ExtSel, regIns[15:0], extendData);
    
    RegFile RegFile(RegWre, CLK, rs, rt, WrReg, writeData, ReadData1, ReadData2);
    
	CU CU(CLK, Reset, OpCode, sign, zero, PCWre, ExtSel, InsMemRW, IRWre, WrRegDSrc,
		RegDst, RegWre, DBDataSrc, nWR, nRD, ALUSrcB, ALUSrcA, PCSrc, ALUOp);
    
    Reg_32bits ADR(CLK, ReadData1, ASrcA);
    
    Reg_32bits BDR(CLK, ReadData2, BSrcA);
    
    Data_Sel2_32bits ALUSRCA(ASrcA, {27'b000000000000000000000000000, sa}, ALUSrcA, ALUA);
    
    Data_Sel2_32bits ALUSRCB(BSrcA, extendData, ALUSrcB, ALUB);
    
    ALU_32bits ALU_32bits(ALUA, ALUB, ALUOp, Result, zero, sign);
    
    PC_Add_Imm PC_Add_Imm(PC4, extendData, PCSrc1);
    
    Data_Sel4_32bits PCSRC(PC4, PCSrc1, ReadData1, ext_data, PCSrc, nextPCAddr);
    
    Reg_32bits ALUoutDR(CLK, Result, DAddr);
    
    RAM RAM(nRD, nWR, CLK, DAddr, BSrcA, DataOut);
    
    Data_Sel2_32bits DBSRC(Result, DataOut, DBDataSrc, DBDRSrc);
    
    Reg_32bits DBDR(CLK, DBDRSrc, DB);
    
endmodule