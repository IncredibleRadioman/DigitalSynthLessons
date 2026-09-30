`timescale 1ns / 1ns

module      testbench;

//  тактирование
reg         clk;
//  асинхронный сброс
reg         reset_n;
//  сигнал разрешения работы
reg         enable;
//  входной сигнал (2 битный)
reg         [1:0] a;
//  выходной сигнал
wire        [1:0] y;
wire        [1:0] y_mealey;
//  состояние
wire        [1:0] state;
wire        [1:0] state_mealey;


//  подключение устройства
fsm22_moore dut(
    .clk(clk),
    .reset_n(reset_n),
    .enable(enable),
    .a(a),
    .y(y)
);

fsm22_mealey dut2(
    .clk(clk),
    .reset_n(reset_n),
    .enable(enable),
    .a(a),
    .y(y_mealey)
);

assign state = dut.state;
assign state_mealey = dut2.state;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

//  симуляция
initial begin

    //  сброс
    clk = 1;
    reset_n = 0;
    enable = 0;
    a = 2'b10;
    #40;
    //  снимаем сброс
    enable = 0;
    reset_n = 1;
    //  ждем
    #10;
    //  тест  - проход по кругу
    //  S0 -> S1 при a = 2 (один из вариантов)
    
    enable = 1;
    //  такт
    #20;
    //  S1 -> S2 при a = 0
    a = 2'b00;
    //  такт
    #20;
    //  S2 -> S2 при a = 0 - проверим
    #20;
    //  S2 -> S3 при a = 1
    a = 2'b01;
    #20;
    //  S3 -> S0 при a = 3
    a = 2'b11;
    #20;
    //  S0 -> S3 при a = 3
    #20;
    //  закрепляем состояние
    enable = 0;
    #40;
    //  конец симуляции
    $finish;

end

//  тактирование
always begin
    //  такт длится 20 у.е.
    #10;
    clk = ~clk;
end

endmodule