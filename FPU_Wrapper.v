module FPU_Wrapper(
    input         Clk,
    input         RstN,
    input         ChipSelect,
    input         Write,
    input         Read,
    input  [1:0]  Address,
    input  [31:0] WriteData,
    output [31:0] ReadData
);
    wire [31:0] a_operand;
    wire [31:0] b_operand;
    wire [3:0] Operation;
    wire [31:0] FPU_Output;
    wire Exception;
    wire Overflow;
    wire Underflow;

    FPU_CSR CSR_DUT (
        .Clk       (Clk),
        .RstN      (RstN),
        .ChipSelect(ChipSelect),
        .Write     (Write),
        .Read      (Read),
        .Address   (Address),
        .WriteData (WriteData),
        .ReadData  (ReadData),
        .a_operand (a_operand),
        .b_operand (b_operand),
        .Operation (Operation),
        .FPU_Output(FPU_Output),
        .Exception (Exception),
        .Overflow  (Overflow),
        .Underflow (Underflow)

    );
    FPU_Core Core_DUT (
        .Clk       (Clk),
        .RstN      (RstN),
        .a_operand (a_operand),
        .b_operand (b_operand),
        .Operation (Operation),
        .FPU_Output(FPU_Output),
        .Exception (Exception),
        .Overflow  (Overflow),
        .Underflow (Underflow)
    );
endmodule