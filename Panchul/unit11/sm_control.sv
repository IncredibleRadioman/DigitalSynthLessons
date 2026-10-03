//  устройство управления
module      sm_control (
    input       [5:0] cmdOper,
    input       [5:0] cmdFunk,
    input       aluZero,
    output      pcSrc,
    output      reg regDst,
    output      reg aluSrc,
    output      reg [2:0] aluControl,
    output      reg regWrite
);

reg             branch;
reg             condZero;

assign          pcSrc = branch & (aluZero == condZero);

//  оно неполное, но см. статью - его можно доработать
//  пока не трачу время - это время для Clifford Cummings :-)))
always @ (*) begin
    //control signals default values
    branch = 1’b0;
    condZero = 1’b0;
    regDst = 1’b0;
    regWrite = 1’b0;
    aluSrc = 1’b0;
    aluControl = `ALU_ADD;
    casez( {cmdOper,cmdFunk} )
        default : ;
        { `C_SPEC, `F_ADDU } : begin
            regDst = 1’b1;
            regWrite = 1’b1;
            aluControl = `ALU_ADD;
        end
        { `C_SPEC, `F_OR } : begin
            regDst = 1’b1;
            regWrite = 1’b1;
            aluControl = `ALU_OR;
        end
    endcase
end

endmodule