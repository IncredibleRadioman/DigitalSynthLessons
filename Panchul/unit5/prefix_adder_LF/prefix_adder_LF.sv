//  префиксный сумматор Ладнера-Фишера
module      prefix_adder_LF #
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

wire    [(2 ** LEVELS):0] g_temp [LEVELS:0];
wire    [(2 ** LEVELS):0] p_temp [LEVELS:0];
wire    [(2 ** LEVELS) - 1 : 0] carry;

assign g_temp[0] = {g, carry_in};
assign p_temp[0] = {p, 1'b0};

generate

    genvar level;
    genvar column;

    //  прямой ход
    for ( level = 0; level < LEVELS; level = level + 1) begin : stage
        for (column = 0; column <= (2 ** LEVELS); column = column + 1) begin : block
            localparam bit_number = column - 1;
            
            if ((column >= (1 << level)) && (((column / (1 << level)) % 2) == 1)) begin
                localparam bit_R = (column / (1 << (level + 1))) * (1 << (level + 1)) + (1 << level) - 2;
                gp_cell i_gp_cell (
                    .g_left(g_temp[level][column]),
                    .g_right(g_temp[level][bit_R + 1]),
                    .p_left(p_temp[level][column]),
                    .p_right(p_temp[level][bit_R + 1]),
                    .g_out(g_temp[level + 1][column]),
                    .p_out(p_temp[level + 1][column])
                );
            end
            else begin
                //  узла нет
                assign g_temp[level + 1][column] = g_temp[level][column];
                assign p_temp[level + 1][column] = p_temp[level][column];
            end
        end
    end

endgenerate

assign carry = g_temp[LEVELS][(2**LEVELS) - 1 : 0];
assign carry_out = g_temp[LEVELS][(2**LEVELS)] | p_temp[LEVELS][(2**LEVELS)] & g_temp[LEVELS][(2**LEVELS) - 1];

assign z = p ^ carry;


endmodule