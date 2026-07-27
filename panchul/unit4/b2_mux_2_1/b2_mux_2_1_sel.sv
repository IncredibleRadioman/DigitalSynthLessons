module  b2_mux_2_1_sel(
    input   [1:0] d0,
    input   [1:0] d1,
    input   sel,
    output  [1:0] y
);

assign y = sel ? d1 : d0;

endmodule