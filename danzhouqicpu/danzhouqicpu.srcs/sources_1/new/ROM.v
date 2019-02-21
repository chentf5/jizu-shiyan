`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/14 20:32:48
// Design Name: 
// Module Name: ROM
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



module ROM (InsMemRW,pc,out);
        input InsMemRW;
        input [31:0] pc;
        output reg [31:0] out;

    // ʵ��Ҫ��ָ��洢�������ݴ洢���洢��Ԫ���һ��ʹ��8λ
    // ���Խ�һ��32λ��ָ����4��8λ�Ĵ洢����Ԫ�洢
    // ���ļ�ȡ�������Ǻϲ�Ϊ32λ��ָ��
    reg [7:0] mem[99:0];
    initial begin
        $readmemb("C:/Users/IT/Desktop/c21/jizu/danzhouqicpu/rom_data.txt", mem); // ���ļ��ж�ȡָ������ƴ��븳ֵ��mem
        out = 32'b0000_0000_0000_0000_0000_0000_0000_0000; // ָ���ʼ��
    end

    always @(InsMemRW or pc) begin
         if(InsMemRW==1) begin
         out[31:24] = men[pc];
         out[23:16] = men[pc+1];
         out[15:8] = men[pc+2];
         out[7:0] = men[pc+3];
    end
    end

endmodule
