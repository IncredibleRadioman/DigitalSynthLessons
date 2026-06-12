module maindec (
    //  поле op = Instr[6:0]
    input logic [6:0] op,
    //  для записи в рег файл взять результат АЛУ
    //  или память данных - это мы сообщаем тракту данных
    output logic [1:0] ResultSrc,
    //  сообщаем - надо ли писать в память данных
    output logic MemWrite,
    //  проверяется ли условный переход
    output logic Branch,
    //  выбор для второго операнда АЛУ между
    //  непосредственным и регистром
    //  отправляем в тракт данных 
    output logic ALUSrc,
    //  сообщаем тракту данных, надо ли писать
    //  результат в рег файл
    output logic RegWrite,
    //  признак безусловного перехода
    output logic Jump,
    //  для mux'а, что выбирает способ расширения
    //  непосредственного операнда (в зависимости от
    //  типа команды)
    output logic [1:0] ImmSrc,
    //  указание для декодера АЛУ
    output logic [1:0] ALUOp
);

//  просто собираем все выходные сигналы в виде
//  шины для удобства
logic [10:0] controls;
assign {RegWrite, ImmSrc, ALUSrc, MemWrite,
        ResultSrc, Branch, ALUOp, Jump} = controls;
    
//  значения сигналов определяются полем op
always_comb begin
    case (op)

    7'b0000011: controls = 
        11'b1_00_1_0_01_0_00_0; //  lw
    7'b0100011: controls =
        11'b0_01_1_1_00_0_00_0; //  sw
    7'b0110011: controls =
        11'b1_xx_0_0_00_0_10_0; //  тип R
    7'b1100011: controls =
        11'b0_10_0_0_00_1_01_0; //  beq
    7'b0010011: controls = 
        11'b1_00_1_0_00_0_10_0; //  тип I
    7'b1101111: controls =
        11'b1_11_0_0_10_0_00_1; //  jal
    default: controls =
        11'bx_xx_x_x_xx_x_xx_x; //  неизвестная команда

    endcase
end

endmodule