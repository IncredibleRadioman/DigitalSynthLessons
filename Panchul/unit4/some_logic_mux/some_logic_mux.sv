module mux2_1 (
    input   d0,
    input   d1,
    input   sel,
    output  y
);

assign y = (sel & d1) | ((~sel) & d0);

endmodule

module mux4_1 (
    input   d0,
    input   d1,
    input   d2,
    input   d3,
    input   [1:0] sel,
    output  y
);

wire y01;
wire y23;

mux2_1 mux01(
    .d0(d0),
    .d1(d1),
    .sel(sel[0]),
    .y(y01)
);

mux2_1 mux23(
    .d0(d2),
    .d1(d3),
    .sel(sel[0]),
    .y(y23)
);

mux2_1 mux(
    .d0(y01),
    .d1(y23),
    .sel(sel[1]),
    .y(y)
);

endmodule

module  mux8_1 (
    input   d0,
    input   d1,
    input   d2,
    input   d3,
    input   d4,
    input   d5,
    input   d6,
    input   d7,
    input   [2:0] sel,
    output y
);

wire    y0123;
wire    y4567;

mux4_1 mux0123(
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .sel(sel[1:0]),
    .y(y0123)
);

mux4_1 mux4567(
    .d0(d4),
    .d1(d5),
    .d2(d6),
    .d3(d7),
    .sel(sel[1:0]),
    .y(y4567)
);

mux2_1 mux (
    .d0(y0123),
    .d1(y4567),
    .sel(sel[2]),
    .y(y)
);


endmodule

module some_logic_mux (
    input   a,
    input   b,
    input   c,
    output  y
);

wire    [2:0] sel;
assign sel = {a,b,c};

mux8_1 logic_mux (
    .d0(1'b0),
    .d1(1'b0),
    .d2(1'b0),
    .d3(1'b1),
    .d4(1'b1),
    .d5(1'b0),
    .d6(1'b0),
    .d7(1'b0),
    .sel(sel),
    .y(y)
);


endmodule
