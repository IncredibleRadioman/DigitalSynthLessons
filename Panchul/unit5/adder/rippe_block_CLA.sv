//  последовательное соединение сумматоров с ускоренным переносом
module  ripple_block_CLA #(
    //  разрядность одного сумматора-блочка
    parameter   GROUP_WIDTH = 4,
    //  количество сумматоров блочков
    parameter   GROUP_COUNT = 2
    //  таким образом общая разрядность сумматора = 8 бит
) (
    //  входной сигнал переноса
    input   carry_in,
    //  первое слагаемое
    input   [GROUP_COUNT * GROUP_WIDTH - 1 : 0] x,
    //  второе слагаемое
    input   [GROUP_COUNT * GROUP_WIDTH - 1 : 0] y,
    //  результат
    output  [GROUP_COUNT * GROUP_WIDTH - 1 : 0] z,
    //  выходной перенос (как правило - это флаг переполнения)
    output  carry_out
);

//  создаем шину переносов для каждого из сумматоров (НЕ РАЗРЯДА)
//  это carry_in'ы для каждого и выходной carry_out
wire    [GROUP_COUNT : 0] carry;
//  в 0-м сумматоре входной перенос равен входному для всего сумматора\
//  в целом
assign carry[0] = carry_in;

generate
    genvar i;
    for (i = 0 ; i <= GROUP_COUNT - 1; i = i + 1) begin : stage
    //  создаем каждый из GROUP_COUNT сумматоров разрядностью GROUP_WIDTH
    carry_lookahead_adder #(
    .WIDTH(GROUP_WIDTH)
    ) i_CLA (
        .carry_in(carry[i]),
        //  разряды не все, а только GROUP_WIDTH штук
        .x(x[(i+1) * GROUP_WIDTH - 1 : i * GROUP_WIDTH]),
        .y(y[(i+1) * GROUP_WIDTH - 1 : i * GROUP_WIDTH]),
        .z(z[(i+1) * GROUP_WIDTH - 1 : i * GROUP_WIDTH]),
        .carry_out(carry[i + 1])
    );
    //  0-й сумматор сгенерит carry_out который будет передан в 1-й
    //  1-й сумматор сгенерит carry_out который будет передан в 2-й
    //  и т.д.
    end`
endgenerate

//  выходной перенос из последнего сумматора-блочка
//  будет выходным переносом всего сумматора
assign carry_out = carry[GROUP_COUNT];

endmodule