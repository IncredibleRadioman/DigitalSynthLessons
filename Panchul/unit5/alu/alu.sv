`define ALU_AND     3'b000
`define ALU_ADD     3'b001
`define ALU_SLL     3'b010
`define ALU_SLT     3'b011

//  добавленные операции
`define ALU_OR      3'b100
`define ALU_SLR     3'b101
`define ALU_XOR     3'b110
`define ALU_SUB     3'b111

//  сумматор работает исключительно с беззнаковыми числами

module adder #(
    parameter WIDTH = 8
) (
    input   [WIDTH - 1 : 0] x,
    input   [WIDTH - 1 : 0] y,
    input   carry_in,
    output  [WIDTH - 1 : 0] z,
    output  carry_out
);

assign {carry_out, z} = x + y + carry_in;

endmodule


module  alu #(
    parameter WIDTH = 4,
    parameter SHIFT = 2
) (
    input   [WIDTH - 1 : 0] x,
    input   [WIDTH - 1 : 0] y,
    input   carry_in,
    input   [SHIFT - 1 : 0] shamt,
    input   [2 : 0] operation,
    output  zero,
    output  reg overflow,
    output  reg [WIDTH - 1 : 0] result
);

wire    [WIDTH - 1 : 0] adder_out;
wire    adder_out_overflow;

adder #(
    .WIDTH(WIDTH)
) i_adder (
    .x(x),
    .y((operation == `ALU_SUB) ? ~y : y),
    .carry_in((operation == `ALU_SUB) ? 1'b1 : carry_in),
    .z(adder_out),
    .carry_out(adder_out_overflow)
);

always @(*) begin
    overflow = 1'b0;
    case (  operation)
        `ALU_ADD : begin
            result = adder_out;
            overflow = adder_out_overflow;
        end
        `ALU_AND :
            result = x & y;
        `ALU_SLL :
            result = y << shamt;
        `ALU_SLT : 
            result = (x < y) ? 1'b1 : 1'b0;
        `ALU_OR  :
            result = x | y;
        `ALU_SLR :
            result = y >> shamt;
        `ALU_XOR :
            result = x ^ y;
        `ALU_SUB : begin
            result = adder_out;
            overflow = ~adder_out_overflow;
        end
        default :
            result = {WIDTH{1'bx}};
    endcase
end

//  flag
assign zero = (result == 0);

endmodule