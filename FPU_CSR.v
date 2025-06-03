module FPU_CSR(
	input Clk,
	input RstN,
	input ChipSelect,
	input Write,
	input Read,
	input [1:0] Address,
	input [31:0] WriteData,
	output [31:0] ReadData,
	output [31:0] a_operand,
    output [31:0] b_operand,
    output [3:0] Operation,
    input [31:0] FPU_Output,
    input Exception,
    input Overflow,
    input Underflow
	);
	reg [31:0] Data_Reg;
	reg [31:0] Control_Reg;
	reg [31:0] Control_a_operand;
	reg [31:0] Control_b_operand;
	reg [3:0] Control_operation;
		assign a_operand = Control_a_operand;
		assign b_operand = Control_b_operand;
		assign Operation = Control_operation;
		assign ReadData = Data_Reg;
always @(posedge Clk or negedge RstN) begin
	if(~RstN) begin
		Control_Reg <= 32'd0;
		Control_a_operand <= 32'd0;
		Control_b_operand <= 32'd0;
		Control_operation <= 4'd0;
	end
	else if(ChipSelect & Write) begin
		case (Address)
		2'd0: Control_a_operand <= WriteData;
		2'd1: Control_b_operand <= WriteData;
		2'd2: Control_operation <= WriteData;
		endcase
	end
	else Control_Reg <= WriteData;
end

always @(posedge Clk or negedge RstN) begin
	if(~RstN) Data_Reg <= 32'd0;
	else if (ChipSelect & Read) begin
		case (Address)
		2'd0: Data_Reg <= Control_a_operand;
		2'd1: Data_Reg <= Control_b_operand;
		2'd2: Data_Reg <= Control_operation;
		2'd3: Data_Reg <= FPU_Output;
		default: Data_Reg <= Data_Reg;
		endcase
		end
	else
	Data_Reg <= Data_Reg;
	end
endmodule
