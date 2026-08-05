//  генератор сигналов переноса для
//  префиксного сумматора Скланского
module  prefix_carry_generator_Sklansky #(
    //  количетсво уровней
    parameter   LEVELS = 3,
    //  разрядность -  степень 2-ки, т.к. сеть построена
    //  с помощью деления отрезков пополам
    parameter   WIDTH = 2**LEVELS
) (
    //  входной сигнал переноса
    input   carry_in,
    //  сигналы генерации переноса для каждого разряда
    input   [WIDTH - 1 : 0] generate_in,
    //  сигналы прохождения переноса для каждого разряда
    input   [WIDTH - 1 : 0] propagate_in,
    //  выходные (итоговые) сигналы переноса для каждого разряда
    output  [WIDTH - 1 : 0] carry,
    //  старший сигнал переноса (как правило - переполнение)
    output  carry_out
);

//  добавим массив для хранения сигналов между узлами
//  графа в сумматоре Скланского для каждого из уровней
wire    [WIDTH : 0] g_temp [LEVELS : 0];
wire    [WIDTH : 0] p_temp [LEVELS : 0];

//  на нулевом уровне - просто входные сигналы gi и pi
assign g_temp[0] = {generate_in, carry_in};
assign p_temp[0] = {propagate_in, carry_in};

generate
    genvar i, j;
    for (i = 0; i <= LEVELS - 1; i = i + 1) begin : stage
        for (j = 0; j <= WIDTH; j = j + 1) begin : block
            if ((j / 2 ** i) % 2 == 1) begin
                //  при выполнении этого условия мы находимся
                //  в точке выходной сетки, где есть ячейка gp_cell

                //  на LEVEL = 1 ячейка ставится на каждый второй (индексы на 1 меньше)
                //  на LEVEL = 2 ячейка ставится на 2 3 6 7
                //  на LEVEL = 3 ячейка ставится на 4 5 6 7
                gp_cell i_gp_cell(
                    //  i - номер уровня
                    //  j - вот он отвечает за LEFT и RIGHT  
                    //  внутри gp_cell
                    
                    //  левый индекс - текущий j (условия для j - выше,
                    //  они определяют ставить gp_cell или нет)
                    .g_left(g_temp[i][j]),
                    //  для LEVELS = 3
                    //  а правый - для i = 0 он выберет 0, 2, 4, 6
                    //  для i = 1 : 1 и 5
                    //  для i = 2 : 3
                    .g_right(g_temp[i][(j / (2**i)) * (2**i) - 1]),

                    //  аналогично - для p
                    .p_left(p_temp[i][j]),
                    .p_right(p_temp[i][(j / (2**i)) * (2**i) - 1]),
                    //  выходные сигналы - это g и p на следующем уровне
                    .g_out(g_temp[i+1][j]),
                    .p_out(p_temp[i+1][j])
                );
            end
            else begin
                //  иначе - в точке выходной сетки нет gp_cell
                //  здесь просто происходит копирование на след уровень
                //  тех же сигналов g и p
                assign g_temp[i+1][j] = g_temp[i][j];
                assign p_temp[i+1][j] = p_temp[i][j];
            end
        end
    end
endgenerate

//  формируем шину переносов (по определению это выходной G[WIDTH - 1, 0])
assign carry = g_temp[LEVELS][WIDTH-1 : 0];
//  самый верхний перенос (он же переполнение)
//  будет если либо он возник в самом старшем разряде
//  либо возник до (g_temp - он же G[WIDTH - 1 : 0]) и
//  и он прошел в последний разряд
assign carry_out = g_temp[LEVELS][WIDTH] | p_temp[LEVELS][WIDTH] & g_temp[LEVELS][WIDTH-1];

endmodule