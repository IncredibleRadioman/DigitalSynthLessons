module datapath (
    //  клок и ресет
    input logic clk, reset,
    //  для записи в рег файл взять результат АЛУ
    //  или память данных
    input logic [1:0] ResultSrc,
    //  выбор следующей инструкции между PC+4 и вычисленной
    //  (для переходов - условных или безусловных)
    input logic PCSrc,
    //  выбор для второго операнда АЛУ между
    //  непосредственным и регистром
    input logic ALUSrc,
    //  надо ли писать
    //  результат в рег файл
    input logic RegWrite,
    //  для mux'а, что выбирает способ расширения
    //  непосредственного операнда (в зависимости от
    //  типа команды)
    input logic [1:0] ImmSrc,
    //  выбор типа операции в АЛУ
    input logic [2:0] ALUControl,
    //  признак равенства нулю результата АЛУ
    output logic Zero,
    //  адрес текущей инструкции
    output logic [31:0] PC,
    //  текущая инструкция
    input logic [31:0] Instr,
    //  выход АЛУ, что используется как адрес
    output logic [31:0] ALUResult,
    //  непосредственно данные, которые
    //  по необходимости записываются в память
    //  данных 
    output logic [31:0] WriteData,
    //  а это прочитанные данные из памяти
    //  данных
    input logic [31:0] ReadData
);

//  внутренние сигналы
//  адрес следующей инструкции
//  он выбирается mux'ом
logic [31:0] PCNext;
//  а это варианты этого mux'а
//  PC + 4 с сумматора
logic [31:0] PCPlus;
//  с другого сумматора PC + ImmExt
logic [31:0] PCTarget;

//  непосредственный операнд
//  на выходе модуля расширения знака
logic [31:0] ImmExt;

//  операнды АЛУ
logic [31:0] SrcA, SrcB;
//  сигнал на входе рег файла
//  либо результат АЛУ
//  либо PC+4
//  либо данные из памяти (памяти данных)
logic [31:0] Result;

//  счетчик команд
//  непосредственно регистр PC
flopr #(32) pcreg(clk, reset, PCNext, PC);
//  сумматор, что считает PC + 4
adder pcadd4(PC, 32'd4, PCPlus4);
//  сумматор, что считает PC + ImmExt
adder pcaddbranch(PC, ImmExt, PCTarget);
//  мультиплексор, что выбирает PCNext
mux2 #(32) pcmux(PCPlus4, PCTarget, PCSrc, PCNext);

//  регистровый файл
regfile rf(clk, RegWrite, Instr[19:15],
        Instr[24:20], Instr[11:7], Result,
        SrcA, WriteData);
//  модуль расширения знака
extend ext(Instr[31:7], ImmSrc, ImmExt);

//  мультиплексор, что выбирает 2-й операнд
mux2 #(32) srcbmux(WriteData, ImmExt, ALUSrc,
            SrcB);
//  АЛУ
alu alu(SrcA, SrcB, ALUControl, ALUResult, Zero);

//  выходной mux
//  выбирает вход рег файла
mux3 #(32) resultmux(ALUResult, ReadData,
            PCPlus4, ResultSrc, Result);
    
endmodule