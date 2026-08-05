module b2_mux_2_1_comb_incorrect (
    input   [1:0] d0,
    input   [1:0] d1,
    input   sel,
    output  [1:0] y
);

assign y = (sel & d1) | ((~sel) & d0);

endmodule