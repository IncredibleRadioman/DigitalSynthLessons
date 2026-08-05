//  bitwise
module  bitwise_and #(
    parameter WIDTH = 8
) (
    input   [WIDTH - 1 : 0] x,
    input   [WIDTH - 1 : 0] y,
    output  [WIDTH - 1 : 0] z
);

assign z = x & y;

endmodule

module adder #(
    parameter WIDTH = 8
) (
    input   [WIDTH - 1 : 0] x,
    input   [WIDTH - 1 : 0] y,
    input   carry_in,
    output  [WIDTH - 1 : 0] z,
    output  carry_out
);

assign {carry_out, z} = x + y + carry_in;


endmodule

module  left_shifter #(
    parameter WIDTH = 8,
    parameter SHIFT = 3
) (
    input   [WIDTH-1 : 0] x,
    input   [SHIFT-1 : 0] shamt,
    output  [WIDTH-1 : 0] z
);

assign z = x << shamt;

endmodule

module  slt #(
    parameter WIDTH = 8
) (
    input   [WIDTH - 1 : 0] x,
    input   [WIDTH - 1 : 0] y,
    output  [WIDTH - 1 : 0] z
);

assign z = (x < y) ? 1'b1 : 1'b0;

endmodule


module  bn_mux_n_1_generate #(
    parameter DATA_WIDTH = 8,
    parameter SEL_WIDTH = 2
) (
    input   [((2**SEL_WIDTH)*DATA_WIDTH)-1 : 0] data,
    input   [SEL_WIDTH-1 : 0] sel,
    output  [DATA_WIDTH-1 : 0] y
);

//  массив элементов шириной [DATA_WIDTH] длиной 2^SEL_WIDTH
wire    [DATA_WIDTH-1:0] tmp_array [0 : (2**SEL_WIDTH) - 1];
genvar i;

generate
    for (i = 0; i < 2**SEL_WIDTH; i = i + 1) begin : gen_array
        assign tmp_array[i] = //заполнение элементов
        data[((i+1)*DATA_WIDTH)-1:(i*DATA_WIDTH)];
    end
endgenerate 

//  один из элементов - есть выход
assign y = tmp_array[sel];

endmodule


module  alu_structural #(
    parameter WIDTH = 4,
    parameter SHIFT = 2
) (
    input   [WIDTH - 1 : 0] x,
    input   [WIDTH - 1 : 0] y,
    input   [SHIFT - 1 : 0] shamt,
    input   [1 : 0] operation,
    input   carry_in,
    output  zero,
    output  overflow,
    output  [WIDTH - 1 : 0] result
);

wire    [4 * WIDTH - 1 : 0] t;

//  internal modules
bitwise_and #(.WIDTH(WIDTH)) i_and (
    .x(x),
    .y(y),
    .z(t[WIDTH - 1 : 0])
);

adder #(.WIDTH(WIDTH)) i_adder (
    .x(x),
    .y(y),
    .carry_in(carry_in),
    .z(t[2 * WIDTH - 1 : WIDTH]),
    .carry_out(overflow)
);

left_shifter #(
    .WIDTH(WIDTH),
    .SHIFT(SHIFT))
i_lshifter(
    .x(x),
    .shamt(shamt),
    .z(t[3 * WIDTH - 1 : 2 * WIDTH])
);

slt #(
    .WIDTH(WIDTH))
i_slt (
    .x(x),
    .y(y),
    .z(t[4 * WIDTH -1 : 3 * WIDTH])
);

bn_mux_n_1_generate #(
    .DATA_WIDTH(WIDTH),
    .SEL_WIDTH(2))
i_mux (
    .data(t),
    .sel(operation),
    .y(result)
);

assign zero = (result == 0);

endmodule