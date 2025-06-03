`include "Addition_Subtraction.v"
`include "Multiplication.v"
`include "Division.v"
module FPU_Core(
    input Clk,
    input RstN,
    input [31:0] a_operand,
    input [31:0] b_operand,
    input [3:0] Operation,
    output reg [31:0] FPU_Output,
    output reg Exception,
    output reg Overflow,
    output reg Underflow
);
    wire [31:0] Add_Sub_A, Add_Sub_B, Mul_A, Mul_B, Div_A, Div_B;
    wire Add_Sub_Exception, Mul_Exception, Mul_Overflow, Mul_Underflow, Div_Exception;
    wire [31:0] Add_Sub_Output, Mul_Output, Div_Output;
    wire AddBar_Sub;
    assign {Add_Sub_A, Add_Sub_B, AddBar_Sub} = (Operation == 4'd0) ? {a_operand, b_operand, 1'b0} : 64'dz;
    assign {Add_Sub_A, Add_Sub_B, AddBar_Sub} = (Operation == 4'd1) ? {a_operand, b_operand, 1'b1} : 64'dz;
    assign {Mul_A, Mul_B} = (Operation == 4'd2) ? {a_operand, b_operand} : 64'dz;
    assign {Div_A, Div_B} = (Operation == 4'd3) ? {a_operand, b_operand} : 64'dz;
    Addition_Subtraction AuI(Add_Sub_A, Add_Sub_B, AddBar_Sub, Add_Sub_Exception, Add_Sub_Output);
    Multiplication MuI(Mul_A, Mul_B, Mul_Exception, Mul_Overflow, Mul_Underflow, Mul_Output);
    Division DuI(Div_A, Div_B, Div_Exception, Div_Output);
    always @(posedge Clk or negedge RstN) begin
        if (~RstN) begin
            FPU_Output <= 32'd0;
            Exception <= 1'b0;
            Overflow <= 1'b0;
            Underflow <= 1'b0;
        end else begin
            case (Operation)
                4'd0: begin 
                    FPU_Output <= Add_Sub_Output;
                    Exception <= Add_Sub_Exception;
                    Overflow <= 1'b0;
                    Underflow <= 1'b0;
                end
                4'd1: begin 
                    FPU_Output <= Add_Sub_Output;
                    Exception <= Add_Sub_Exception;
                    Overflow <= 1'b0;
                    Underflow <= 1'b0;
                end
                4'd2: begin 
                    FPU_Output <= Mul_Output;
                    Exception <= Mul_Exception;
                    Overflow <= Mul_Overflow;
                    Underflow <= Mul_Underflow;
                end
                4'd3: begin 
                    FPU_Output <= Div_Output;
                    Exception <= Div_Exception;
                    Overflow <= 1'b0;
                    Underflow <= 1'b0;
                end
                default: begin
                    FPU_Output <= 32'd0;
                    Exception <= 1'b0;
                    Overflow <= 1'b0;
                    Underflow <= 1'b0;
                end
            endcase
        end
    end

endmodule
