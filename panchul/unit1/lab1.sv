module lab1
(
    //  входы - читают клавиши
    input [1:0] KEY,
    //  выход - светодиоды
    output [9:0] LED
);

//  воссоздаем логику из примера
wire a = ~ KEY[0];
wire b = ~ KEY[1];

//  базовые логические вентили
//  AND, OR, NOT
assign LED[0] = a & b;
assign LED[1] = a | b;
assign LED[2] = ~a;

//  вентиль XOR
//  здесь мы используем встроенную функцию
//   и реализация лежит на плечах синтезатора
assign LED[3] = a ^ b;

//  тоже XOR
//  но реализация вручную
assign LED[4] = (a | b) & ~ (a & b);

//  NOT
//  но через исключающее ИЛИ с 1
assign LED[5] = a ^ 1'b1;

//  иллюстрация теоремы Де Моргана
assign LED[6] = ~ (a & b);
assign LED[7] = ~a | ~b;
assign LED[8] = ~ (a | b);
assign LED[9] = ~a & ~b;

endmodule