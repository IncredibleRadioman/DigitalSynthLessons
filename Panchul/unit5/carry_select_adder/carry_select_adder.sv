//  блок для сумматора с выбором переноса
//  размером 2 бита
module      carry_select_adder_block_2b(
    input   [1:0] x,
    input   [1:0] y,
    input   carry_in,
    output  [1:0] z,
    output  carry_out
);

wire    [1:0] sum_0;
wire    [1:0] sum_1;
wire    cout_1;
wire    cout_0;


assign {cout_0, sum_0} = x + y;
assign {cout_1, sum_1} = x + y + 1'b1;


assign carry_out = carry_in ? cout_1 : cout_0;
assign z = carry_in ? sum_1 : sum_0;

endmodule

//  блок для сумматора с выбором переноса
//  размером 4 бита
module      carry_select_adder_block_4b(
    input   [3:0] x,
    input   [3:0] y,
    input   carry_in,
    output  [3:0] z,
    output  carry_out
);

wire    [3:0] sum_0;
wire    [3:0] sum_1;
wire    cout_1;
wire    cout_0;


assign {cout_0, sum_0} = x + y;
assign {cout_1, sum_1} = x + y + 1'b1;


assign carry_out = carry_in ? cout_1 : cout_0;
assign z = carry_in ? sum_1 : sum_0;

endmodule

//  блок для сумматора с выбором переноса
//  размером 8 бит
module      carry_select_adder_block_8b(
    input   [7:0] x,
    input   [7:0] y,
    input   carry_in,
    output  [7:0] z,
    output  carry_out
);

wire    [7:0] sum_0;
wire    [7:0] sum_1;
wire    cout_1;
wire    cout_0;


assign {cout_0, sum_0} = x + y;
assign {cout_1, sum_1} = x + y + 1'b1;


assign carry_out = carry_in ? cout_1 : cout_0;
assign z = carry_in ? sum_1 : sum_0;

endmodule

//  блок для сумматора с выбором переноса
//  размером WIDTH бит
module      carry_select_adder_block #(
    parameter   WIDTH = 8
) (
    input   [WIDTH - 1 : 0] x,
    input   [WIDTH - 1 : 0] y,
    input   carry_in,
    output  [WIDTH - 1 : 0] z,
    output  carry_out
);

wire    [WIDTH - 1 : 0] sum_0;
wire    [WIDTH - 1 : 0] sum_1;
wire    cout_1;
wire    cout_0;


assign {cout_0, sum_0} = x + y;
assign {cout_1, sum_1} = x + y + 1'b1;


assign carry_out = carry_in ? cout_1 : cout_0;
assign z = carry_in ? sum_1 : sum_0;

endmodule

// ----------------------------------------------------
//  теперь сами сумматоры
//  пусть 8 бит использует 2 битные (4)
//  16 бит - 4 битные (4)
//  32 бит - 4 битные (8)
//  64 бит - 8 битные (8)


// ----------------------------------------------------
//  универсальный сумматор c выбором переноса
module      carry_select_adder #(
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
        carry_select_adder_block # (
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