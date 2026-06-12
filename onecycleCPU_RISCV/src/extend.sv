module extend (
    //  сам непосредственный операнд в команде
    input logic [31:7] instr,
    //  как расширять
    input logic [1:0] immsrc,
    //  расширенный операнд
    output logic [31:0] immext
);

always_comb begin
    case (immsrc)

    //  тип I
    2'b00:  immext = { {20{instr[31]}}, instr[31:20]};
    //  тип S
    2'b01:  immext = { {20{instr[31]}}, instr[31:25],
                        instr[11:7]};
    //  тип B
    2'b10:  immext = { {20{instr[31]}}, 
                        instr[7],
                        instr[30:25],
                        instr[11:8],
                        1'b0};
    //  тип J
    2'b11:  immext = { {12{instr[31]}}, 
                        instr[19:12],
                        instr[20],
                        instr[30:21],
                        1'b0};
    //  неизвестная команда
    default: immext = 32'bx;

    endcase
    
end
    
endmodule