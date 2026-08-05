module  b3_mux_2_1_if (
    input   [2:0] d0,
    input   [2:0] d1,
    input   sel,
    output  reg [2:0] y
);

always @(*) begin
    if (        sel == 1'b0)
        y = d0;
    else if (   sel == 1'b1)
        y = d1;
    else
        y = 3'bxxx;
end

endmodule

module b3_mux_3_1_comb_mux_2_1_if (
    input   [2:0] d0,
    input   [2:0] d1,
    input   [2:0] d2,
    input   [1:0] sel,
    output  [2:0] y
);

wire    [2:0] y01;

b3_mux_2_1_if mux01 (
    .d0(d0),
    .d1(d1),
    .sel(sel[0]),
    .y(y01)
);

b3_mux_2_1_if out_mux (
    .d0(y01),
    .d1(d2),
    .sel(sel[1]),
    .y(y)
);

endmodule