`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/14 20:23:33
// Design Name: 
// Module Name: RegFile
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


module RegFile(CLK,RST,RegWre,RegDst,rs,rt,rd,DBDataSrc,dataFromALU,dataFromRW,ReadData1,ReadData2);
    input CLK;
    input RST;
    input RegWre,RegDst,DBDataSrc;
    //input [5:0] opCode;
    input [4:0] rs,rt,rd;
    //input [31:0] WriteData;
    //input [10:0] im;
    input [31:0] dataFromALU, dataFromRW;  
    output [31:0] ReadData1,ReadData2;
    wire [4:0] writeReg;  // Ҫд�ļĴ����˿�
    wire [31:0] writeData; // Ҫд������
    assign writeReg = RegDst? rd : rt;
    assign writeData = DBDataSrc? dataFromRW : dataFromALU;
    reg [31:0] regFile[1:31]; // �Ĵ������������ reg ����
    
    integer i;
    assign ReadData1 = (rs == 0) ? 0 : regFile[rs]; // ���Ĵ�������
    assign ReadData2 = (rt == 0) ? 0 : regFile[rt];
    always @ (negedge CLK or negedge RST) begin // ������ʱ�ӱ��ش���
    if (RST==0) begin
    for(i=1;i<32;i=i+1)
    regFile[i] <= 0;
    end
    else if(RegWre == 1 && writeReg != 0) // WriteReg != 0��$0 �Ĵ��������޸�
    regFile[writeReg] <= writeData; // д�Ĵ���
    end
endmodule
