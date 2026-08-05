module  mux8_1_comb_if_mux_2_1 #(
    parameter DATA_WIDTH = 8
) (
    input   [DATA_WIDTH-1 : 0] d0,
    input   [DATA_WIDTH-1 : 0] d1,
    input   [DATA_WIDTH-1 : 0] d2,
    input   [DATA_WIDTH-1 : 0] d3,
    input   [DATA_WIDTH-1 : 0] d4,
    input   [DATA_WIDTH-1 : 0] d5,
    input   [DATA_WIDTH-1 : 0] d6,
    input   [DATA_WIDTH-1 : 0] d7,
    input   [2:0] sel,
    output  [DATA_WIDTH-1 : 0] y
);

wire    [DATA_WIDTH-1 : 0] y01;
wire    [DATA_WIDTH-1 : 0] y23;
wire    [DATA_WIDTH-1 : 0] y45;
wire    [DATA_WIDTH-1 : 0] y67;

wire    [DATA_WIDTH-1 : 0] y0123;
wire    [DATA_WIDTH-1 : 0] y4567;

mux2_1_if #(
    .DATA_WIDTH(DATA_WIDTH)
) mux01 (
    .d0(d0),
    .d1(d1),
    .sel(sel[0]),
    .y(y01)
);

mux2_1_if #(
    .DATA_WIDTH(DATA_WIDTH)
) mux23 (
    .d0(d2),
    .d1(d3),
    .sel(sel[0]),
    .y(y23)
);

mux2_1_if #(
    .DATA_WIDTH(DATA_WIDTH)
) mux45 (
    .d0(d4),
    .d1(d5),
    .sel(sel[0]),
    .y(y45)
);

mux2_1_if #(
    .DATA_WIDTH(DATA_WIDTH)
) mux67 (
    .d0(d6),
    .d1(d7),
    .sel(sel[0]),
    .y(y67)
);

mux2_1_if #(
    .DATA_WIDTH(DATA_WIDTH)
) mux0123 (
    .d0(y01),
    .d1(y23),
    .sel(sel[1]),
    .y(y0123)
);

mux2_1_if #(
    .DATA_WIDTH(DATA_WIDTH)
) mux4567 (
    .d0(y45),
    .d1(y67),
    .sel(sel[1]),
    .y(y4567)
);

mux2_1_if #(
    .DATA_WIDTH(DATA_WIDTH)
) out_mux (
    .d0(y0123),
    .d1(y4567),
    .sel(sel[2]),
    .y(y)
);

endmodule