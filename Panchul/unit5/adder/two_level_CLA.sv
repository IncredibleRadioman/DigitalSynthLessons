module two_level_CLA #(
    //  ширина сумматоров-блочков 1-го уровня
    parameter     WIDTH_0 = 2,
    //  количество генераторов переноса 2-го уровня
    parameter     WIDTH_1 = 2,
    //  количество групп
    parameter     GROUP_COUNT = 2  

    //  получается GROUP_COUNT генераторов переноса 2-го уровня
    //  которые обрабатывают по WIDTH_1 сумматоров-блочков
    //  получая от них групповые сигналы генерации и прохождения
    //  и отдавая им carry_in'ы для окончательного расчета рез-та

  //    общая разрядность = GROUP_COUNT * WIDTH_1 * WIDTH_0
) (
    //  первое слагаемое
    input   [GROUP_COUNT * WIDTH_1 * WIDTH_0 - 1 : 0] x,
    //  второе слагаемое
    input   [GROUP_COUNT * WIDTH_1 * WIDTH_0 - 1 : 0] y,
    //  результат
    output  [GROUP_COUNT * WIDTH_1 * WIDTH_0 - 1 : 0] z,
    //  выходной перенос (означает переполнение)
    output  carry_out
);

//  временные сигналы для групповых
//  сигналов прохождения
wire    [GROUP_COUNT * WIDTH_1 - 1 : 0] p_temp;
//  сигналов генерации
wire    [GROUP_COUNT * WIDTH_1 - 1 : 0] g_temp;
//  а также для сигналов переноса (для carry_in'ов)
wire    [GROUP_COUNT * WIDTH_1 : 0] c_temp;

//  у 0-го блока входной сигнал переноса = входному сигналу переноса всего сумматора
assign  c_temp[0] = carry_in;

generate
    genvar i;
    genvar j;
    for (i = 0; i <= GROUP_COUNT * WIDTH_1 -1 ; i = i + 1) begin : stage
        //  расставляем сумматоры-блочки шириной WIDTH_0
        //  всего их будет GROUP_COUNT * WIDTH_1 штук
        carry_lookahead_adder #(
        .WIDTH(WIDTH_0)) i_CLA (
            //  carry_in берется очередной с шины, и вот с 1-го по
            //  GROUP_COUNT * WIDTH_1-й будут сгенерированы блоком на
            //  2-м уровне, который получив групповые G и P
            //  посчитает carry_in для каждого из сумматоров-блочков
            .carry_in(c_temp[i]),
            //  очередные WIDTH_0 бит исходных слагаемых
            .x(x[(i+1) * WIDTH_0 - 1 :  i * WIDTH_0]),
            .y(y[(i+1) * WIDTH_0 - 1 :  i * WIDTH_0]),
            //  рассчитываемые очередные WIDTH_0 бит результата
            //  как только придет carry_in - результат поменяется
            //  почти мгновенно
            .z(z[(i+1) * WIDTH_0 - 1 :  i * WIDTH_0]),
            //  те самые сигналы группового переноса, которые будут
            //  исп-ся блоком 2-го уровня для создания carry_in
            .group_propagate(p_temp[i]),
            .group_propagate(g_temp[i]),
            .carry_out()
        );
    end

    //  создаем блоки второго уровня - генераторы переноса
    //  их GROUP_COUNT штук
    for (j = 0; j <= GROUP_COUNT - 1; j = j + 1) begin : clg_stage
        carry_lookahead_generator_v #(
        .WIDTH(WIDTH_1)) i_CLG (
            //  получает carry_in от предыдущего
            .carry_in(c_temp[WIDTH_1 * j]),
            //  получает групповые переносы от очередных WIDTH_1 сумматоров-блочков
            //  шириной WIDTH_0 (ширина сумматоров)
            //  для примера из параметров по умолчанию:

            //  генератор переносов 0
            //  обрабатывает сигналы P и G от сумматоров 0 и 1
            //  выдает carry_in'ы для 1-го и 2-го

            //  генератор переносов 1
            //  обрабатывает сигналы P и G от сумматоров 2 и 3
            //  выдает carry_in'ы для 3-го и 4-го (4-го нет - это выходной
            //  перенос от всего сумматора)

            .generate_in(g_temp[WIDTH_1 * (j + 1) - 1 : WIDTH_1 * j]),
            .propagate_in(p_temp[WIDTH_1 * (j + 1) - 1 : WIDTH_1 * j]),
            //  генерирует carry_in для следующих WIDTH_1 сумматоров
            //  для всех сумматоров своей группы, кроме самого первого
            //  и для самого первого сумматора, что обрабатывается следующим CLG
            .carry(c_temp[WIDTH_1 * (j + 1) : WIDTH_1 * j + 1]),
            .group_propagate(),
            .group_generate()
        );
    end

endgenerate

//  выдаем выходной перенос всего сумматора
assign carry_out = c_temp[GROUP_COUNT * WIDTH_1];
    
endmodule