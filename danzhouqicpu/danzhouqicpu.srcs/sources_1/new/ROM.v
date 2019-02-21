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

    // 实验要求：指令存储器和数据存储器存储单元宽度一律使用8位
    // 所以将一个32位的指令拆成4个8位的存储器单元存储
    // 从文件取出后将他们合并为32位的指令
    reg [7:0] mem[99:0];
    initial begin
        $readmemb("C:/Users/IT/Desktop/c21/jizu/danzhouqicpu/rom_data.txt", mem); // 从文件中读取指令二进制代码赋值给mem
        out = 32'b0000_0000_0000_0000_0000_0000_0000_0000; // 指令初始化
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
