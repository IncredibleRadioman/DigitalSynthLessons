module  b1_mux_3_1_case (
    input   d0,
    input   d1,
    input   d2,
    input   [1:0] sel,
    output  reg y
);

always @(*) begin
    case (  sel)
        2'b00 :     y = d0;
        2'b01 :     y = d1;
        2'b10 :     y = d2;
        default :   y = 1'bx;
    endcase
end

endmodule

module b3_mux_3_1_comb_b1_mux_3_1_case (
    input   [2:0] d0,
    input   [2:0] d1,
    input   [2:0] d2,
    input   [1:0] sel,
    output  [2:0] y
);

b1_mux_3_1_case mux_bit2(
    .d0(d0[2]),
    .d1(d1[2]),
    .d2(d2[2]),
    .sel(sel),
    .y(y[2])
);

b1_mux_3_1_case mux_bit1(
    .d0(d0[1]),
    .d1(d1[1]),
    .d2(d2[1]),
    .sel(sel),
    .y(y[1])
);

b1_mux_3_1_case mux_bit0(
    .d0(d0[0]),
    .d1(d1[0]),
    .d2(d2[0]),
    .sel(sel),
    .y(y[0])
);

endmodule