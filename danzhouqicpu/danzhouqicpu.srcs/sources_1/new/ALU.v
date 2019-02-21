`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/14 20:27:01
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] ReadData1, 
    input [31:0] ReadData2,
    input [31:0] inExt,
    input [4:0] insa,
    input ALUSrcA, ALUSrcB,
    input [2:0] ALUopcode,
    output reg zero,
    output reg sign,
    output reg [31:0] result
);

    wire [31:0] A;
    wire [31:0] B;
    assign A = ALUSrcA ? insa:ReadData1;
    assign B = ALUSrcB? inExt : ReadData2;

    //assign zero = (result==0)?1:0;//存在疑问
    always @(ReadData1 or ReadData2 or inExt or ALUSrcA or ALUSrcB or ALUopcode or A or B) begin
        case (ALUopcode)
        3'b000 : begin
            result = A + B;
            zero = (result==0)?1:0;
            sign = (result[31]==0)?0:1;
            end
        3'b001 : begin
            result = A - B;
            zero = (result==0)?1:0;
            sign = (result[31]==0)?0:1;
            end
        3'b010 : begin
            result = B << A;
            zero = (result==0)?1:0;
            sign = (result[31]==0)?0:1;
            end
        3'b011 :begin
            result = A | B;
            zero = (result==0)?1:0;
            sign = (result[31]==0)?0:1;
            end
        3'b100 :begin
            result = A & B;
            zero = (result==0)?1:0;
            sign = (result[31]==0)?0:1;
            end
        3'b101 : begin
            result = (A < B)?1:0; // 无符号比较
            zero = (result==0)?1:0;
            sign = (result[31]==0)?0:1;
            end
        3'b110 : begin // 带符号比较
            result =(((A<B) && (A[31] == B[31] )) ||( ( A[31] ==1 && B[31] == 0)))?1:0;
            zero = (result==0)?1:0;
            sign = (result[31]==0)?0:1;
        end
        3'b111 :begin
            result = A ^ B;
            zero = (result==0)?1:0;
            sign = (result[31]==0)?0:1;
            end
            default : begin
                            result = 32'h0000_0000_0000_0000_0000_0000_0000_0000;
                           // $display (" no match");
                        end
        endcase
    end
endmodule