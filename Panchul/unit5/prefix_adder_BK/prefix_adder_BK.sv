module      prefix_adder_BK #
(
    parameter   LEVELS = 3
) (
    input   [(2 ** LEVELS - 1):0] x,
    input   [(2 ** LEVELS - 1):0] y,
    input   carry_in,
    output  [(2 ** LEVELS - 1):0] z,
    output  carry_out
);

wire    [(2 ** LEVELS - 1):0] p;
wire    [(2 ** LEVELS - 1):0] g;

assign p = x ^ y;
assign g = x & y;

wire    [(2 ** LEVELS):0] g_temp [(2 * LEVELS - 1):0];
wire    [(2 ** LEVELS):0] p_temp [(2 * LEVELS - 1):0];
wire    [(2 ** LEVELS) - 1 : 0] carry;

assign g_temp[0] = {g, carry_in};
assign p_temp[0] = {p, 1'b0};

generate

    genvar level;
    genvar bit_number;

    //  прямой ход
    for ( level = 0; level < LEVELS; level = level + 1) begin : stage
        for (bit_number = 0; bit_number <= (2 ** LEVELS); bit_number = bit_number + 1) begin : block
            //  шаг (откуда брать правый бит)
            localparam step = 2 ** level;

            //  следующий уровень нужен для условия - ставить ячейку
            localparam next_level = level + 1;

            //  если остаток от деления на 2^next_level равен
            //  2^next_level-1 => ставим узел

            if ((bit_number % (2 ** next_level))  == (2 ** next_level - 1)) begin
                //  узел есть
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
                //  узла нет
                assign g_temp[level + 1][bit_number] = g_temp[level][bit_number];
                assign p_temp[level + 1][bit_number] = p_temp[level][bit_number];
            end
        end
    end

    //  обратный ход

    for (level = LEVELS; level < (2 * LEVELS - 1); level = level + 1) begin : back_stage
        for (bit_number = 0; bit_number <= (2 ** LEVELS); bit_number = bit_number + 1) begin : back_block
            //  шаг (откуда брать правый бит)
            localparam step = 2 ** (2 * LEVELS - level - 2);
            localparam prev_step = 2 * step;

            if ((bit_number >= prev_step) && ((bit_number - step) % prev_step == prev_step - 1)) begin
                //  узел есть
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
                //  узла нет
                assign g_temp[level + 1][bit_number] = g_temp[level][bit_number];
                assign p_temp[level + 1][bit_number] = p_temp[level][bit_number];
            end
        end
    end

endgenerate

assign carry = g_temp[2 * LEVELS - 1][(2**LEVELS) - 1 : 0];
assign carry_out = g_temp[2 * LEVELS - 1][(2**LEVELS)];// | p_temp[2 * LEVELS - 1][(2**LEVELS)] & g_temp[2 * LEVELS - 1][(2**LEVELS) - 1];

assign z = p ^ carry;


endmodule