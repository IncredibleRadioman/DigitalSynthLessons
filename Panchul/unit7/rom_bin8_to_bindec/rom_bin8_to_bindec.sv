//  модуль для преобразования бинарного 8-битного числа
//  в двоично-десятичное на базе ПЗУ
module      rom_bin8_to_bindec (
    //  входное число
    input       [7:0] a,
    //  тактирование
    input       clk,
    //  выход - сотни (0 1 2)
    output      [1:0] hundreds,
    //  выход - десятки (0-9)
    output      [3:0] tens,
    //  выход - единицы (0-9)
    output      [3:0] ones 
);

//  сама память
reg         [9:0] rom_data[(2**8 - 1):0];

reg         [7:0] addr;

integer i;

reg     [1:0] h;
reg     [3:0] t;
reg     [3:0] o;

wire    [9:0] read_data;

initial begin
    //  заполнение ячеек памяти
    for (   i = 0; i <= (2**8 - 1) ; i = i + 1) begin
        h = i / 100;
        t = (i - 100 * h) / 10;
        o = (i - 100 * h - 10 * t);

        rom_data[i] = {h, t, o};
    end
end

//  выдача выхода
always  @(posedge clk) begin
    addr <= a;
end

assign      read_data = rom_data[addr];

assign      hundreds = read_data[9:8];
assign      tens = read_data[7:4];
assign      ones = read_data[3:0];

endmodule