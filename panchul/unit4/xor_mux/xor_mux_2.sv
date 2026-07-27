module mux2_1 (
    input   d0,
    input   d1,
    input   sel,
    output  y
);

assign y = (sel & d1) | ((~sel) & d0);

endmodule


module xor_mux_2 (
    input   a,
    input   b,
    output  y
);

mux2_1 mux (
    .d0(a),
    .d1(~a),
    .sel(b),
    .y(y)
);

endmodule