//  исходный код МП (учебного) архитектуры
//  MIPS
//  внутренности CPU
module      sm_cpu(
    input   clk,
    input   rst
);

//  заведем провода для счетчика команд
//  это следующая команда (вход счетчика команд PC)
wire        [31:0] pc_new;
//  это текущая команда (выход счетчика команд PC)
wire        [31:0] pc;

//  провод для входа памяти команд уже есть - это pc
//  создаем провод для самой команды - выхода памяти команд
wire        [31:0] instr;

//  выбор адреса в зависимости от типа (в какой рег записать рез-т)
wire        regDst;
//  выбор второго операнда АЛУ
wire        aluSrc;

//  создаем провода для рег файла
wire        [4:0] a0 = 5'b0;
wire        [4:0] a1 = instr[25:21];
wire        [4:0] a2 = instr[20:16];
wire        [4:0] a3 = (regDst ? instr[15:11] : instr[20:16]);

wire        [31:0] rd0;
wire        [31:0] rd1;
wire        [31:0] rd2;
wire        [31:0] wd3;
wire        we3;

//  расширение константы Imm (с учетом знака)
wire        [31:0] signImm = { {16{instr[15]}}, instr[15:0]};

//  провода для АЛУ
wire        [31:0] srcA = rd1;
wire        [31:0] srcB = (aluSrc ? signImm : rd2);
wire        [2:0] aluControl;
wire        [4:0] shift = instr[10:6];
wire        aluZero;
wire        [31:0] result;
assign      wd3 = result;

//  стандартное вычисление след команды
wire        [31:0] pc_next = pc + 1;
//  вычисление на случай ветвления
wire        [31:0] pc_branch = signImm + pc_next;

//  выбор следующей команды
//  сигнал выбора
wire        pcSrc;
assign      pc_new = (pcSrc ? pc_branch : pc_next);

//  формирование входов УУ
wire        [5:0] cmdOper = instr[31:26];
wire        [5:0] cmdFunk = instr[5:0];

//  создаем регистр PC и подключаем провода
sm_register     r_pc(
    .clk(clk),
    .rst(rst),
    .d(pc_new),
    .q(pc)
);

//  создаем память команд и поключаем провода
sm_rom      instr_mem(
    .a(pc),
    .rd(instr)
);

//  объект рег файла
sm_reg_file     reg_file (
    .clk(clk),
    .a0(a0),
    .a1(a1),
    .a2(a2),
    .a3(a3),
    .rd0(rd0),
    .rd1(rd1),
    .rd2(rd2),
    .wd3(wd3),
    .we3(we3)
);

//  объект АЛУ
sm_alu      alu (
    .srcA(srcA),
    .srcB(srcB),
    .oper(aluControl),
    .shift(shift),
    .zero(aluZero),
    .result(result)
);


//  устройство управления
//  подключаем к нему провода
sm_control      c_unit(
    .cmdOper(cmdOper),
    .cmdFunk(cmdFunk),
    .aluZero(aluZero),
    .pcSrc(pcSrc),
    .regDst(regDst),
    .aluSrc(aluSrc),
    .aluControl(aluControl),
    .regWrite(we3)
);


endmodule