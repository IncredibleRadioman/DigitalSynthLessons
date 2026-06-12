module riscvsingle(
    //  клок и ресет
    input logic clk, reset,
    //  для доступа к памяти и чтения текущей команды
    //  это адрес запроса
    output logic [31:0] PC,
    //  порт памяти RD
    //  сама прочитанная инструкция
    input logic [31:0] Instr,
    //  сигнал о том, что в память данных нужно
    //  выполнить запись (к порту WE)
    output logic MemWrite,
    //  результат ALU, в некоторых командах
    //  он содержит адрес в памяти данных
    //  это как раз данный сигнал
    //  подключается к адресу памяти данных
    output logic [31:0] ALUResult,
    //  непосредственно данные, которые
    //  по необходимости записываются в память
    //  данных
    output logic [31:0] WriteData,
    //  а это прочитанные данные из памяти
    //  данных
    input logic[31:0] ReadData
);

//  внутренние сигналы
//  выбор для второго операнда АЛУ между
//  непосредственным и регистром
logic ALUSrc, 
//  выполняется ли запись в регистровый файл
RegWrite, 
//  признак безусловного перехода
Jump, 
//  признак того, что результат АЛУ равен 0
Zero;
//  для записи в рег файл взять результат АЛУ
//  или память данных
logic [1:0] ResultSrc, 
//  в зависимости от типа команды указывает
//  модулю расширения знака как расширять
//  знак непосредственного операнда
ImmSrc;
//  тип операции в АЛУ
logic [2:0] ALUControl;

//  компоненты
//  устройство управления
controller c(Instr[6:0], Instr[14:12],
    Instr[30], Zero,
    ResultSrc, MemWrite, PCSrc,
    ALUSrc, RegWrite, Jump,
    ImmSrc, ALUControl);
//  тракт данных
datapath dp(clk, reset, ResultSrc, PCSrc,
    ALUSrc, RegWrite,
    ImmSrc, ALUControl,
    Zero, PC, Instr,
    ALUResult, WriteData,
    ReadData);
endmodule