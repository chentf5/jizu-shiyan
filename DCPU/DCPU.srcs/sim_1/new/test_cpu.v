`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/12 19:54:49
// Design Name: 
// Module Name: test_cpu
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



module test_cpu;
    reg CLK;
    reg Reset;
    wire [31:0] Instruction;
    wire [5:0] OpCode;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [31:0] curPCAddr;
	wire [31:0] nextPCAddr;
    wire [31:0] writeData;
    wire [31:0] Result; //test
    wire [31:0] ReadData1;
    wire [31:0] ReadData2;
    wire [31:0] Immediate;
    wire [4:0] sa;
    wire [2:0] ALUOp;
    wire ALUSrcA;
    wire ALUSrcB;

    cpu uut(
	    .CLK(CLK),
	    .Reset(Reset),
	    .Instruction(Instruction),
	    .OpCode(OpCode),
	    .rs(rs),
	    .rt(rt),
	    .rd(rd),
	    .curPCAddr(curPCAddr),
		.nextPCAddr(nextPCAddr),
	    .writeData(writeData),
	    .Result(Result), //test
	    .ReadData1(ReadData1),
	    .ReadData2(ReadData2),
	    .Immediate(Immediate),
	    .sa(sa),
	    .ALUOp(ALUOp),
	    .ALUSrcA(ALUSrcA),
	    .ALUSrcB(ALUSrcB) 
    );

    initial begin
        CLK = 0;
        Reset = 1;
        #50;
            CLK = !CLK;
        #50;
            Reset = 0;
      forever #50 begin
            CLK = !CLK;
        end
    end
endmodule
