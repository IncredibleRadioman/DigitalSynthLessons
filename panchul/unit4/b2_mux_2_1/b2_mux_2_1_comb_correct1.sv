module b2_mux_2_1_comb_correct1 (
    input   [1:0] d0,
    input   [1:0] d1,
    input   sel,
    output  [1:0] y
);

assign y[0] = (sel & d1[0]) | ((~sel) & d0[0]);
assign y[1] = (sel & d1[1]) | ((~sel) & d0[1]);

endmodule