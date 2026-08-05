module  b1_mux_3_1_ternar (
    input   d0,
    input   d1,
    input   d2,
    input   [1:0] sel,
    output  y
);

assign y =  (sel == 2'b00) ? d0 :
            (sel == 2'b01) ? d1 :
            (sel == 2'b10) ? d2 :
            1'bx;

endmodule

module b3_mux_3_1_comb_b1_mux_3_1_ternar (
    input   [2:0] d0,
    input   [2:0] d1,
    input   [2:0] d2,
    input   [1:0] sel,
    output  [2:0] y
);

b1_mux_3_1_ternar mux_bit2(
    .d0(d0[2]),
    .d1(d1[2]),
    .d2(d2[2]),
    .sel(sel),
    .y(y[2])
);

b1_mux_3_1_ternar mux_bit1(
    .d0(d0[1]),
    .d1(d1[1]),
    .d2(d2[1]),
    .sel(sel),
    .y(y[1])
);

b1_mux_3_1_ternar mux_bit0(
    .d0(d0[0]),
    .d1(d1[0]),
    .d2(d2[0]),
    .sel(sel),
    .y(y[0])
);

endmodule