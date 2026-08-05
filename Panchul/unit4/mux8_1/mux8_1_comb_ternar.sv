module  mux2_1_ternar #(
    parameter DATA_WIDTH = 8
) (
    input   [DATA_WIDTH-1 : 0] d0,
    input   [DATA_WIDTH-1 : 0] d1,
    input   sel,
    output  [DATA_WIDTH-1 : 0] y
);

assign y = sel ? d1 : d0;

endmodule

module mux4_1_ternar #(
    parameter DATA_WIDTH = 8
) (
    input   [DATA_WIDTH-1 : 0] d0,
    input   [DATA_WIDTH-1 : 0] d1,
    input   [DATA_WIDTH-1 : 0] d2,
    input   [DATA_WIDTH-1 : 0] d3,
    input   [1:0] sel,
    output  [DATA_WIDTH-1 : 0] y
);

assign y = sel[1] ?   (sel[0] ? d3 : d2) 
                    : (sel[0] ? d1 : d0);

endmodule

module  mux8_1_comb_ternar # (
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

wire    [DATA_WIDTH-1 : 0] y0123;
wire    [DATA_WIDTH-1 : 0] y4567;

mux4_1_ternar #(
    .DATA_WIDTH(DATA_WIDTH)
) mux0123 (
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .sel(sel[1:0]),
    .y(y0123)
);

mux4_1_ternar #(
    .DATA_WIDTH(DATA_WIDTH)
) mux4567 (
    .d0(d4),
    .d1(d5),
    .d2(d6),
    .d3(d7),
    .sel(sel[1:0]),
    .y(y4567)
);

mux2_1_ternar #(
    .DATA_WIDTH(DATA_WIDTH)
) out_mux (
    .d0(y0123),
    .d1(y4567),
    .sel(sel[2]),
    .y(y)
);

endmodule