//  блок для сумматора с пропуском переноса
//  размером 2 бита
module      carry_skip_adder_block_2b(
    input   [1:0] x,
    input   [1:0] y,
    input   carry_in,
    output  [1:0] z,
    output  carry_out
);

wire    [1:0] p;
wire    [1:0] g;
wire    [2:0] carry;
wire    p_group;

assign p = x ^ y;
assign g = x & y;
assign p_group = &p;


assign carry[0] = carry_in;

generate
    genvar i;
    for (i = 0; i <= 1; i = i + 1) begin : bit_stage
        assign carry[i+1] = g[i] | p[i] & carry[i];
    end
endgenerate

assign carry_out = p_group ? carry_in : carry[2];

assign z = p ^ carry[1:0];

endmodule


//  блок для сумматора с пропуском переноса
//  размером 4 бита
module      carry_skip_adder_block_4b(
    input   [3:0] x,
    input   [3:0] y,
    input   carry_in,
    output  [3:0] z,
    output  carry_out
);

wire    [3:0] p;
wire    [3:0] g;
wire    [4:0] carry;
wire    p_group;

assign p = x ^ y;
assign g = x & y;
assign p_group = &p;


assign carry[0] = carry_in;

generate
    genvar i;
    for (i = 0; i <= 3; i = i + 1) begin : bit_stage
        assign carry[i+1] = g[i] | p[i] & carry[i];
    end
endgenerate

assign carry_out = p_group ? carry_in : carry[4];

assign z = p ^ carry[3:0];

endmodule

//  блок для сумматора с пропуском переноса
//  размером 8 бит
module      carry_skip_adder_block_8b(
    input   [7:0] x,
    input   [7:0] y,
    input   carry_in,
    output  [7:0] z,
    output  carry_out
);

wire    [7:0] p;
wire    [7:0] g;
wire    [8:0] carry;
wire    p_group;

assign p = x ^ y;
assign g = x & y;
assign p_group = &p;


assign carry[0] = carry_in;

generate
    genvar i;
    for (i = 0; i <= 7; i = i + 1) begin : bit_stage
        assign carry[i+1] = g[i] | p[i] & carry[i];
    end
endgenerate

assign carry_out = p_group ? carry_in : carry[8];

assign z = p ^ carry[7:0];

endmodule

// ----------------------------------------------------
//  теперь сами сумматоры
//  пусть 8 бит использует 2 битные (4)
//  16 бит - 4 битные (4)
//  32 бит - 4 битные (8)
//  64 бит - 8 битные (8)
module      carry_skip_adder_8b(
    input   [7:0] x,
    input   [7:0] y,
    input   carry_in,
    output  [7:0] z,
    output  carry_out
);

//  шина переносов, ее размер равен количеству блоков + 1
wire    [4:0] carry;

assign carry[0] = carry_in;

generate
    //  внутри будет 4 блока
    genvar i;
    for (i = 0; i < 4; i = i + 1) begin : stage
        carry_skip_adder_block_2b i_add_block(
            .x(x[(2 * i + 1) : (2 * i)]),
            .y(y[(2 * i + 1) : (2 * i)]),
            .carry_in(carry[i]),
            .z(z[(2 * i + 1) : (2 * i)]),
            .carry_out(carry[i+1])
        );
    end

endgenerate

assign carry_out = carry[4];

endmodule


module      carry_skip_adder_16b(
    input   [15:0] x,
    input   [15:0] y,
    input   carry_in,
    output  [15:0] z,
    output  carry_out
);

//  шина переносов, ее размер равен количеству блоков + 1
wire    [4:0] carry;

assign carry[0] = carry_in;

generate
    //  внутри будет 4 блока
    genvar i;
    for (i = 0; i < 4; i = i + 1) begin : stage
        carry_skip_adder_block_4b i_add_block(
            .x(x[(4 * i + 3) : (4 * i)]),
            .y(y[(4 * i + 3) : (4 * i)]),
            .carry_in(carry[i]),
            .z(z[(4 * i + 3) : (4 * i)]),
            .carry_out(carry[i+1])
        );
    end

endgenerate

assign carry_out = carry[4];

endmodule


module      carry_skip_adder_32b(
    input   [31:0] x,
    input   [31:0] y,
    input   carry_in,
    output  [31:0] z,
    output  carry_out
);

//  шина переносов, ее размер равен количеству блоков + 1
wire    [8:0] carry;

assign carry[0] = carry_in;

generate
    //  внутри будет 8 блоков
    genvar i;
    for (i = 0; i < 8; i = i + 1) begin : stage
        carry_skip_adder_block_4b i_add_block(
            .x(x[(4 * i + 3) : (4 * i)]),
            .y(y[(4 * i + 3) : (4 * i)]),
            .carry_in(carry[i]),
            .z(z[(4 * i + 3) : (4 * i)]),
            .carry_out(carry[i+1])
        );
    end

endgenerate

assign carry_out = carry[8];

endmodule

module      carry_skip_adder_64b(
    input   [63:0] x,
    input   [63:0] y,
    input   carry_in,
    output  [63:0] z,
    output  carry_out
);

//  шина переносов, ее размер равен количеству блоков + 1
wire    [8:0] carry;

assign carry[0] = carry_in;

generate
    //  внутри будет 8 блоков
    genvar i;
    for (i = 0; i < 8; i = i + 1) begin : stage
        carry_skip_adder_block_8b i_add_block(
            .x(x[(8 * i + 7) : (8 * i)]),
            .y(y[(8 * i + 7) : (8 * i)]),
            .carry_in(carry[i]),
            .z(z[(8 * i + 7) : (8 * i)]),
            .carry_out(carry[i+1])
        );
    end

endgenerate

assign carry_out = carry[8];

endmodule

// ----------------------------------------------------
//  универсальные блок и сам сумматор
//  блок для сумматора с пропуском переноса
//  размером WIDTH бит
module      carry_skip_adder_block #(
    parameter WIDTH = 8
) (
    input   [WIDTH - 1:0] x,
    input   [WIDTH - 1:0] y,
    input   carry_in,
    output  [WIDTH - 1:0] z,
    output  carry_out
);

wire    [WIDTH - 1 : 0] p;
wire    [WIDTH - 1 : 0] g;
wire    [WIDTH : 0] carry;
wire    p_group;

assign p = x ^ y;
assign g = x & y;
assign p_group = &p;


assign carry[0] = carry_in;

generate
    genvar i;
    for (i = 0; i < WIDTH; i = i + 1) begin : bit_stage
        assign carry[i+1] = g[i] | p[i] & carry[i];
    end
endgenerate

assign carry_out = p_group ? carry_in : carry[WIDTH];

assign z = p ^ carry[WIDTH - 1:0];

endmodule


module      carry_skip_adder #(
    //  количество блоков
    parameter   BLOCK_COUNT = 8,
    //  разрядность одного блока
    parameter   BLOCK_SIZE = 4
) (
    input   [BLOCK_COUNT * BLOCK_SIZE - 1 : 0] x,
    input   [BLOCK_COUNT * BLOCK_SIZE - 1 : 0] y,
    input   carry_in,
    output  [BLOCK_COUNT * BLOCK_SIZE - 1 : 0] z,
    output  carry_out
);

//  шина переносов, ее размер равен количеству блоков + 1
wire    [BLOCK_COUNT : 0] carry;

assign carry[0] = carry_in;

generate
    //  внутри будет BLOCK_COUNT блоков
    genvar i;
    for (i = 0; i < BLOCK_COUNT; i = i + 1) begin : stage
        carry_skip_adder_block # (
            .WIDTH(BLOCK_SIZE)
        ) i_add_block(
            .x(x[(BLOCK_SIZE * (i + 1) - 1) : (BLOCK_SIZE * i)]),
            .y(y[(BLOCK_SIZE * (i + 1) - 1) : (BLOCK_SIZE * i)]),
            .carry_in(carry[i]),
            .z(z[(BLOCK_SIZE * (i + 1) - 1) : (BLOCK_SIZE * i)]),
            .carry_out(carry[i+1])
        );
    end

endgenerate

assign carry_out = carry[BLOCK_COUNT];

endmodule