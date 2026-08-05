module  mux4_1 (
    input   d0,
    input   d1,
    input   d2,
    input   d3,
    input   [1:0] sel,
    output  reg y
);

always @(*) begin
    case (  sel)
        2'b00 : y = d0;
        2'b01 : y = d1;
        2'b10 : y = d2;
        2'b11 : y = d3;
    endcase
end

endmodule

module  xor_mux (
    input   a,
    input   b,
    output  y
);

wire    [1:0] sel;
assign sel = {a, b};

mux4_1 mux(
    .d0(1'b0),
    .d1(1'b1),
    .d2(1'b1),
    .d3(1'b0),
    .sel(sel),
    .y(y)
);

endmodule