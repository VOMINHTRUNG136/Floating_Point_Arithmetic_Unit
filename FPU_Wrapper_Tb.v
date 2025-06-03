`timescale 1ns / 1ps
module FPU_Wrapper_tb;
    reg Clk;
    reg RstN;
    reg ChipSelect;
    reg Write;
    reg Read;
    reg [1:0] Address;
    reg [31:0] WriteData;
    wire [31:0] ReadData;
    FPU_Wrapper uut (
        .Clk(Clk),
        .RstN(RstN),
        .ChipSelect(ChipSelect),
        .Write(Write),
        .Read(Read),
        .Address(Address),
        .WriteData(WriteData),
        .ReadData(ReadData)
    );

    initial begin
        Clk = 0;
        forever #5 Clk = ~Clk;
    end
    initial begin
        RstN = 0;
        #10 RstN = 1; 
    end
    initial begin
        // ADD
        #10;
        ChipSelect = 1;
        Write = 1;
        Read = 0;
        Address = 2'd0;
        WriteData = 32'h404eb852; 
        #10;
        Address = 2'd1; 
        WriteData = 32'h3FC00000;
        #10;
        Address = 2'd2; 
        WriteData = 32'd0; 
        #10;
        Write = 0;
        Read = 1;
        Address = 2'd3;
        // SUB
        #10;
        Write = 1;
        Read = 0;
        Address = 2'd0;
        WriteData = 32'h404eb852; 
        #10;
        Address = 2'd1; 
        WriteData = 32'h3FC00000;
        #10;
        Address = 2'd2; 
        WriteData = 32'd1; 
        #10;
        Write = 0;
        Read = 1;
        Address = 2'd3;
        #10
        // MUL
        #10;
        Write = 1;
        Read = 0;
        Address = 2'd0;
        WriteData = 32'h404eb852; 
        #10;
        Address = 2'd1; 
        WriteData = 32'h3FC00000;
        #10;
        Address = 2'd2; 
        WriteData = 32'd2; 
        #10;
        Write = 0;
        Read = 1;
        Address = 2'd3;
        #10
        // DIV
        #10;
        Write = 1;
        Read = 0;
        Address = 2'd0;
        WriteData = 32'h404eb852;
        #10;
        Address = 2'd1;
        WriteData = 32'h3FC00000;
        #10;
        Address = 2'd2;
        WriteData = 32'd3;
        #10;
        Write = 0;
        Read = 1;
        Address = 2'd3;
    end
    initial begin
        $monitor("Time: %t, Address: %d, WriteData: %h, ReadData: %h", $time, Address, WriteData, ReadData);
    end

endmodule
