//  8-битный префиксный сумматор Когге-Стоуна
module      prefix_adder_KS_8b (
    input   [7:0] x,
    input   [7:0] y,
    input   carry_in,
    output  [7:0] z,
    output  carry_out
);

wire    [7:0] p;
wire    [7:0] g;

assign p = x ^ y;
assign g = x & y;

//  есть 3 уровня, на каждом ставятся узлы (или пропускаются сигналы)
//  в соответствующем разряде
//  УРОВЕНЬ 0 - сами входы g и p

//  УРОВЕНЬ 1 
//  [gp_cell] [gp_cell] [gp_cell] [gp_cell] [gp_cell] [gp_cell] [gp_cell] [empty]
//  УРОВЕНЬ 2
//  [gp_cell] [gp_cell] [gp_cell] [gp_cell] [gp_cell] [gp_cell] [empty]   [empty]
//  УРОВЕНЬ 3
//  [gp_cell] [gp_cell] [gp_cell] [gp_cell] [empty]   [empty]   [empty]   [empty]

//  введем сигналы g на каждый уровень как двумерный массив
//  самый правый сигнал = carry_in
wire    [8:0] g_temp [3:0];
wire    [8:0] p_temp [3:0];
wire    [7:0] carry;

//  заполним 0-й уровень
assign g_temp[0] = {g, carry_in};
assign p_temp[0] = {p, 1'b0};

//  начинаем заполнять уровни level + 1
generate
    //  счетчик уровней
    genvar level;
    //  счетчик битов
    genvar bit_number;

    for (level = 0; level < 3; level = level + 1) begin : stage
        for (bit_number = 0; bit_number <= 8; bit_number = bit_number + 1) begin : block
            //  шаг (откуда брать правый бит)
            localparam step = 2 ** level;

            //  узел ставится для бита, номер которого >= step
            if (    bit_number >= step) begin

                gp_cell i_gp_cell (
                    .g_left(g_temp[level][bit_number]),
                    .g_right(g_temp[level][bit_number - step]),
                    .p_left(p_temp[level][bit_number]),
                    .p_right(p_temp[level][bit_number - step]),
                    .g_out(g_temp[level + 1][bit_number]),
                    .p_out(p_temp[level + 1][bit_number])
                );
            end
            else begin
                assign g_temp[level + 1][bit_number] = g_temp[level][bit_number];
                assign p_temp[level + 1][bit_number] = p_temp[level][bit_number];
            end
        end
    end

endgenerate

assign carry = g_temp[3][7:0];
assign carry_out = g_temp[3][8] | p_temp[3][8] & g_temp[3][7];

assign z = p ^ carry;

endmodule


//  2^LEVELS-битный префиксный сумматор Когге-Стоуна
module      prefix_adder_KS #(
    parameter LEVELS = 5
) (
    input   [(2**LEVELS) - 1 : 0] x,
    input   [(2**LEVELS) - 1 : 0] y,
    input   carry_in,
    output  [(2**LEVELS) - 1 : 0] z,
    output  carry_out
);

wire    [(2**LEVELS) - 1 : 0] p;
wire    [(2**LEVELS) - 1 : 0] g;

assign p = x ^ y;
assign g = x & y;

//  есть 3 уровня, на каждом ставятся узлы (или пропускаются сигналы)
//  в соответствующем разряде
//  УРОВЕНЬ 0 - сами входы g и p

//  введем сигналы g на каждый уровень как двумерный массив
//  самый правый сигнал = carry_in
wire    [(2**LEVELS) : 0] g_temp [LEVELS:0];
wire    [(2**LEVELS) : 0] p_temp [LEVELS:0];
wire    [(2**LEVELS) - 1 : 0] carry;

//  заполним 0-й уровень
assign g_temp[0] = {g, carry_in};
assign p_temp[0] = {p, 1'b0};

//  начинаем заполнять уровни level + 1
generate
    //  счетчик уровней
    genvar level;
    //  счетчик битов
    genvar bit_number;

    for (level = 0; level < LEVELS; level = level + 1) begin : stage
        for (bit_number = 0; bit_number <= (2**LEVELS); bit_number = bit_number + 1) begin : block
            //  шаг (откуда брать правый бит)
            localparam step = 2 ** level;

            //  узел ставится для бита, номер которого >= step
            if (    bit_number >= step) begin

                gp_cell i_gp_cell (
                    .g_left(g_temp[level][bit_number]),
                    .g_right(g_temp[level][bit_number - step]),
                    .p_left(p_temp[level][bit_number]),
                    .p_right(p_temp[level][bit_number - step]),
                    .g_out(g_temp[level + 1][bit_number]),
                    .p_out(p_temp[level + 1][bit_number])
                );
            end
            else begin
                assign g_temp[level + 1][bit_number] = g_temp[level][bit_number];
                assign p_temp[level + 1][bit_number] = p_temp[level][bit_number];
            end
        end
    end

endgenerate

assign carry = g_temp[LEVELS][(2**LEVELS) - 1 : 0];
assign carry_out = g_temp[LEVELS][(2**LEVELS)] | p_temp[LEVELS][(2**LEVELS)] & g_temp[LEVELS][(2**LEVELS) - 1];

assign z = p ^ carry;

endmodule