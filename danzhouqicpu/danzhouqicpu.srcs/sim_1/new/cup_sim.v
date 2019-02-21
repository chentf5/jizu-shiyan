`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/19 10:26:12
// Design Name: 
// Module Name: cup_sim
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


module SingleCircleCPUTest;

    // Inputs
    reg CLK;
    reg Reset;

    // Outputs
    wire [31:0] Out1;
    wire [31:0] Out2;
    wire [31:0] curPC;
    wire [31:0] Result;
    wire [5:0] opCode;

    // Instantiate the Unit Under Test (UUT)
    SingleCycleCPU uut (
        .clk(CLK), 
        .Reset(Reset),
        .opCode(opCode),
        .Out1(Out1),
        .Out2(Out2),
        .curPC(curPC),
        .Result(Result)
    );

    initial begin
        // Initialize Inputs
        CLK = 0;
        Reset = 0;
        #50; // 刚开始设置pc为0
            CLK = 1;
        #50;
            Reset = 1;
        forever #50 begin // 产生时钟信号
            CLK = !CLK;
        end
    end

endmodule
