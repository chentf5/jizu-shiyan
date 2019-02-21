`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/19 13:31:18
// Design Name: 
// Module Name: cpu_sim
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


module cpu_sim;

    // Inputs
    reg CLK;
    reg Reset;

    

    // Instantiate the Unit Under Test (UUT)
    singleStyleCPU uut (
        .clk(CLK),
        .Reset(Reset)
        );

    initial begin
        // Initialize Inputs
        CLK = 0;
        Reset = 0;
        #25; // 刚开始设置pc为0
            CLK = 1;
        #25;
            Reset = 1;
        forever #25 begin // 产生时钟信号
            CLK = !CLK;
        end
    end

endmodule