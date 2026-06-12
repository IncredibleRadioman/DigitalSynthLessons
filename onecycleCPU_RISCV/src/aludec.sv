module aludec (
    //  5-й бит поля op = Instr[6:0]
    input logic opb5,
    //  поле funct3 = Instr[14:12]
    input logic [2:0] funct3,
    //  поле funct7b5 = Instr[30]
    input logic funct7b5,
    //  указание от основного декодера
    input logic [1:0] ALUOp,
    //  сигнал - указание АЛУ какую операцию выполнять
    output logic [2:0] ALUControl
);

//  сигнал о том, что операция типа R и вычитание
logic RTypeSub;
assign RTypeSub = funct7b5 & opb5;

always_comb begin
    case (ALUOp)
        //  команды lw, sw
        2'b00:  ALUControl = 3'b000; // +
        //  команда beq
        2'b01:  ALUControl = 3'b001; // -
        default: 
        //  для остальных команд выбор операции 
        //  определяется полем funct3
            case (funct3)

                3'b000: if (RTypeSub)
                            ALUControl = 3'b001; // -
                        else
                            ALUControl = 3'b000; // +
                3'b010: 
                    ALUControl = 3'b101; // slt, slti
                3'b110:
                    ALUControl = 3'b011; // or, ori
                3'b111:
                    ALUControl = 3'b010; // and, andi
                default:
                    ALUControl = 3'bxxx;

            endcase
    endcase
end
    
endmodule