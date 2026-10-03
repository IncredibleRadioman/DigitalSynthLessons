//  АЛУ для MIPS

//  коды операций
`define     ALU_ADD     3'b000
`define     ALU_OR      3'b001
`define     ALU_LUI     3'b010
`define     ALU_SRL     3'b011
`define     ALU_SLTU    3'b010
`define     ALU_SUBU    3'b101

//  сам модуль
//  выполняет действие в зависимости от кода операции
module      sm_alu (
    input   [31:0] srcA,
    input   [31:0] srcB,
    input   [2:0] oper,
    input   [4:0] shift,
    output  zero,
    output  reg [31:0] result
);

//  само сложение комбинационное
always @(*) begin
    case (  oper)
        default :
            result = srcA + srcB;
        `ALU_ADD :
            result = srcA + srcB;
        `ALU_OR :
            result = srcA | srcB;
        `ALU_LUI :
            result = (srcB << 16);
        `ALU_SRL :
            result = srcB >> shift;
        `ALU_SLTU :
            result = (srcA < srcB) ? 1 : 0;
        `ALU_SUBU :
            result = srcA - srcB;
    endcase
end

assign  zero = (result == 0);

endmodule