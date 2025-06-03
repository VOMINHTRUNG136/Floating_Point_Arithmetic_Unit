`timescale 1ns / 1ps
module FPU_Core_tb;
    reg Clk;
    reg RstN;
    reg [31:0] a_operand;
    reg [31:0] b_operand;
    reg [3:0] Operation;
    wire [31:0] FPU_Output;
    wire Exception;
    wire Overflow;
    wire Underflow;
    FPU_Core uut (
        .Clk(Clk),
        .RstN(RstN),
        .a_operand(a_operand),
        .b_operand(b_operand),
        .Operation(Operation),
        .FPU_Output(FPU_Output),
        .Exception(Exception),
        .Overflow(Overflow),
        .Underflow(Underflow)
    );
    initial begin
        Clk = 0;
        forever #5 Clk = ~Clk; 
    end

    initial begin
        RstN = 0;
        #15 RstN = 1; 
    end
    initial begin
        #20;
        a_operand = 32'h404eb852;  
        b_operand = 32'h3FC00000;  
        Operation = 4'd0;
        #10; 
        a_operand = 32'h404eb852;  
        b_operand = 32'h40151eb8;  
        Operation = 4'd1;
        #10;
        a_operand = 32'h40151eb8;  
        b_operand = 32'h404eb852;  
        Operation = 4'd2;
        #10;
        a_operand = 32'h40151eb8;  
        b_operand = 32'h40151eb8;  
        Operation = 4'd3;
        #10;
        a_operand = 32'h40151eb8; 
        b_operand = 32'h00000000;
        Operation = 4'd3;
        #10;
        a_operand = 32'h7F7FFFFF; 
        b_operand = 32'h404eb852; 
        Operation = 4'd2;
        #10;
        a_operand = 32'h00000001; 
        b_operand = 32'h40151eb8; 
        Operation = 4'd1; 
    end

    initial begin
        $monitor("Time: %t, Op: %d, A: %h, B: %h, Out: %h, Exception: %b, Overflow: %b, Underflow: %b", 
                $time, Operation, a_operand, b_operand, FPU_Output, Exception, Overflow, Underflow);
    end

endmodule
