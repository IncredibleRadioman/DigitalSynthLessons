//  на входе data_in и выходе data_out устанавливаются регистры
//  описание модуля регистра

//  все в точности со схемой, что я нарисовал в Obsidian!!!!
module register #(
    parameter DATA_WIDTH = 4
) (
    input       ena,
    input       clk,
    input       [DATA_WIDTH - 1 : 0] d,
    output      reg [DATA_WIDTH - 1 : 0] q
);


always @(posedge clk) begin
    if (ena)
        q <= d;
end

endmodule

//  модуль памяти с регистрами на входе и выходе данных
module      ram_with_regs #(
    parameter       DATA_WIDTH = 8,
    parameter       ADDR_WIDTH = 16
) (
    //  сигнал чтения/записи (=1 - запись, =0 - чтение)
    input           we,
    //  тактирование
    input           clk,
    //  запись
    input       [(DATA_WIDTH - 1) : 0] data_in,
    input       [(ADDR_WIDTH - 1) : 0] addr,
    //  чтение
    output      [(DATA_WIDTH - 1) : 0] data_out,
    output      [(ADDR_WIDTH - 1) : 0] addr_out

);

//  массив памяти
reg         [(DATA_WIDTH - 1) : 0] ram[0 : (2**ADDR_WIDTH - 1)];

//  для входных сигналов устанавливается 3 регистра
//  создаем провода для их выходов
wire        [(DATA_WIDTH - 1) : 0] data_in_reg_out;
wire        [(ADDR_WIDTH - 1) : 0] addr_reg_out;
wire        we_reg_out;

//  для 2 выходных - еще 2 регистра
//  создаем провода для их входов
wire        [(DATA_WIDTH - 1) : 0] data_out_reg_in;
wire        [(ADDR_WIDTH - 1) : 0] addr_out_reg_in;

//  входной регистр данных
register # (
    .DATA_WIDTH(DATA_WIDTH)
) data_in_reg (
    .ena(1'b1),
    .clk(clk),
    .d(data_in),
    .q(data_in_reg_out)
);

//  входной регистр адреса
register # (
    .DATA_WIDTH(ADDR_WIDTH)
) addr_reg (
    .ena(1'b1),
    .clk(clk),
    .d(addr),
    .q(addr_reg_out)
);

//  входной регистр сигнала записи
register # (
    .DATA_WIDTH(1)
) we_reg (
    .ena(1'b1),
    .clk(clk),
    .d(we),
    .q(we_reg_out)
);

//  выходной регистр данных
register #(
    .DATA_WIDTH(DATA_WIDTH)
) data_out_reg (
    .ena(~we_reg_out),
    .clk(clk),
    .d(data_out_reg_in),
    .q(data_out)
);

//  выходной регистр адреса
register #(
    .DATA_WIDTH(ADDR_WIDTH)
) addr_out_reg (
    .ena(~we_reg_out),
    .clk(clk),
    .d(addr_out_reg_in),
    .q(addr_out)
);

//  операция записи
always @(posedge clk) begin
    if (    we_reg_out) begin
        //  теперь она происходит по тому, что записано на выходе разрешающего
        //  регистра
        ram[addr_reg_out] <= data_in_reg_out;
    end
end

assign addr_out_reg_in = addr_reg_out;
assign data_out_reg_in = ram[addr_out_reg_in];


endmodule