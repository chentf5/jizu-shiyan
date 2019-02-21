`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/18 20:25:57
// Design Name: 
// Module Name: choose_regdata
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


module choose_regdata(DBdataSrc,ALUres,Mendata,DB);
    input DBdataSrc;
    input [31:0] ALUres;
    input [31:0] Mendata;
    output [31:0] DB;
    
    always@(DBdataSrc or ALUres or Mendata) begin
            if(DBdataSrc == 0)
                DB = ALUres;
            else
                DB = Mendata;
        end
endmodule
