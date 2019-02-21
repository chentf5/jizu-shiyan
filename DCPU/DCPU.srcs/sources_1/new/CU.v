`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/12 19:52:09
// Design Name: 
// Module Name: CU
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



module CU(CLK, Reset, OpCode, sign, zero, PCWre, ExtSel, InsMemRW, IRWre, WrRegDSrc,
			RegDst, RegWre, DBDataSrc, nWR, nRD, ALUSrcB, ALUSrcA, PCSrc, ALUOp);
			
	input CLK, Reset;
	input [5:0] OpCode;
	input sign, zero;
	
	output reg PCWre, ExtSel, InsMemRW, IRWre, WrRegDSrc;
	output reg [1:0] RegDst;
	output reg RegWre, DBDataSrc, nWR, nRD, ALUSrcB, ALUSrcA;
	output reg [1:0] PCSrc;
	output reg [2:0] ALUOp;

    // 定义各个操作对应的操作码
    parameter [5:0] add = 6'b000000,
                    sub = 6'b000001,
                    addiu = 6'b000010,
                    Or = 6'b010000,
                    And = 6'b010000,
                    ori = 6'b010010,
                    andi = 6'b010001,
                    xori = 6'b010011,
                    sll = 6'b011000,
                    slt = 6'b100111,
                    slti = 6'b100110,
                    sw = 6'b110000,
                    lw = 6'b110001,
                    beq = 6'b110100,
                    bne = 6'b110101,
                    //bgtz = 
                    bltz = 6'b110110,
                    j = 6'b111000,  
                    jr = 6'b111001,
                    jal = 6'b111010,
                    halt = 6'b111111;

    // 定义各个状态对应的编码
    parameter [2:0] sIF = 3'b000, 
					sID = 3'b001, 
					aEXE = 3'b110,
					bEXE = 3'b101,
					cEXE = 3'b010,
					aWB = 3'b111,
					cWB = 3'b100, 
					cMEM = 3'b011;

    reg [2:0] curState, nextState;
    
    always@(negedge CLK) begin  // 下降沿触发状态的改变
        if(Reset)
            curState <= sIF;
        else
            curState <= nextState;
    end
    
    always@(curState or OpCode) begin  // 给nextState赋值，对照多周期CPU状态转移图
        case(curState)
            sIF: nextState = sID;
            sID: begin
                    if(OpCode == j || OpCode == jr || OpCode == halt || OpCode == jal)
                        nextState = sIF;
                    else if(OpCode == add || OpCode == sub || OpCode == addiu || OpCode == Or ||
						OpCode == And || OpCode == ori || OpCode == sll || OpCode ==slt ||
						OpCode == slti)
						nextState = aEXE;
					else if(OpCode == beq || OpCode == bne || OpCode == bltz)
					    nextState = bEXE;
					else if(OpCode == sw || OpCode == lw)
                        nextState = cEXE;
                 end
		    aEXE: nextState = aWB;
		    bEXE: nextState = sIF;
		    cEXE: nextState = cMEM;
            aWB: nextState = sIF;
            cMEM: begin
                      if(OpCode == lw)
                          nextState = cWB; // lw指令  
                      else
                          nextState = sIF; // sw指令  
                  end
            cWB: nextState = sIF;
            default: nextState = sIF;
        endcase
    end
    
    always @(curState or OpCode or zero or sign) begin
        // PCWre, InsMemRW, IRWre
        if(curState == sIF /*&& OpCode != halt*/) begin
            //这里面的是订正的写法,是最佳写法
            if(OpCode == halt) begin
                PCWre = 0; InsMemRW = 0; IRWre = 0;
            end
            else begin
                PCWre = 1; InsMemRW = 1; IRWre = 1;
            end
        end
        else begin
            PCWre = 0; InsMemRW = 0; IRWre = 0;
        end
        
        // ExtSel  
        if(curState == aEXE || curState == bEXE || curState == cEXE) begin
	        if(OpCode == ori || OpCode == ori || OpCode == xori)
	            ExtSel = 0;
	        else if(OpCode == addiu || OpCode == slti || OpCode == sw || OpCode == lw ||
					OpCode == beq || OpCode == bne || OpCode == bltz)
	            ExtSel = 1;  
        end
            
        // WrRegDSrc 
        if(curState == sID && OpCode == jal) WrRegDSrc = 0;
        else if(curState == aWB || curState == cWB)
	        WrRegDSrc = 1;  
        
        // RegDst 
        if(curState == sID && OpCode == jal) RegDst = 2'b00;
        else if(curState == aWB || curState == cWB) begin
            if(OpCode == add || OpCode == sub ||
				OpCode == And || OpCode == sll || OpCode == slt)
				RegDst = 2'b10;
			else if(OpCode == addiu || OpCode == andi || OpCode == ori || OpCode == xori || 
			         OpCode == slti || OpCode == lw)
				RegDst = 2'b01;
			//else if(OpCode == jal) RegDst = 2'b00;
        end
        else RegDst = 2'b11;
            
        // RegWre  
        if(curState == aWB || curState == cWB || (curState == sID && OpCode == jal))
            RegWre = 1;  
        else
            RegWre = 0;  
        
        // DBDataSrc  
        if(curState == aEXE) begin
				DBDataSrc = 0;
        end
        else if(curState == cMEM && OpCode == lw)
            DBDataSrc = 1; 
        
        
        //nRD, nWR 
        if(curState == cMEM) begin
        	if(OpCode == sw) begin
            	nWR = 1; nRD = 0; 
            end
			else if(OpCode == lw) begin
            	nWR = 0; nRD = 1; 
            end
		end	 
        else begin
            nWR = 0; nRD = 0;
        end
        
        // ALUSrcB 
		if(curState == aEXE || curState == bEXE || curState == cEXE) begin 
	        if(OpCode == addiu || OpCode == andi || OpCode == ori || OpCode == xori || OpCode == slti || OpCode == sw || OpCode == lw)
	            ALUSrcB = 1;  
	        else
	            ALUSrcB = 0;
        end
        
        
        if(curState == aEXE || curState == bEXE || curState == cEXE) begin
	        if(OpCode == sll)
	            ALUSrcA = 1;  
	        else
	            ALUSrcA = 0;
        end
        
        // PCSrc  
        if(curState == sID) begin
        	if(OpCode == j || OpCode == jal)
        		PCSrc = 2'b11;
        	else if(OpCode == jr)
        		PCSrc = 2'b10;
        end
        else if(curState == bEXE) begin
        	if(OpCode == beq)
        		PCSrc = (zero == 0 ? 2'b00 : 2'b01);
        	else if(OpCode == bne)
        		PCSrc = (zero == 0 ? 2'b01 : 2'b00);
        	else if(OpCode == bltz) begin
        		if(sign == 1)
        			PCSrc = 2'b01;
        		else PCSrc = 2'b00;
        	end
        end
        else if( (curState == aWB||curState == cWB) || (curState == cMEM && OpCode == sw))
        	PCSrc = 2'b00;
        //else if(curState == sWB && OpCode == jal)
        	//PCSrc = 2'b11;
        
        // ALUOp 
		if(curState == aEXE || curState == bEXE || curState == cEXE) begin
			if(OpCode == add || OpCode == addiu || OpCode == sw || OpCode == lw)
				ALUOp = 3'b000;//a+b
			else if(OpCode == sub || OpCode == bltz)
				ALUOp = 3'b001;//a-b
			else if(OpCode == slt || OpCode == slti)
				ALUOp = 3'b110; // 有符号比较
			else if(OpCode == sll)
				ALUOp = 3'b010; // B << A
			else if(OpCode == ori)
				ALUOp = 3'b011;//b|A
			else if(OpCode == And || OpCode == andi)
				ALUOp = 3'b100;//B&A
			else if(OpCode == beq || OpCode == bne|| OpCode == xori)
				ALUOp = 3'b111;//a^b
		end
    end  
endmodule
