module  b1_mux_4_1_case (
    input   d0, d1, d2, d3,
    input   [1:0] sel,
    output  reg y
);

always @(*) begin
    case (sel)
        2'b00 : y = d0;
        2'b01 : y = d1;
        2'b10 : y = d2;
        2'b11 : y = d3;
    endcase

end

endmodule


module  b2_mux_4_1_block_alt (
    input   [1:0] d0, d1, d2, d3,
    input   [1:0] sel,
    output  [1:0] y
);

b1_mux_4_1_case hi(
    .d0(d0[1]),
    .d1(d1[1]),
    .d2(d2[1]),
    .d3(d3[1]),
    .sel(sel),
    .y(y[1])
);

b1_mux_4_1_case lo(
    .d0(d0[0]),
    .d1(d1[0]),
    .d2(d2[0]),
    .d3(d3[0]),
    .sel(sel),
    .y(y[0])
);

endmodule