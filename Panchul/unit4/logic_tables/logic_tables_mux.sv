module  mux_4_1 (
    input   d0,
    input   d1,
    input   d2,
    input   d3,
    input   [1:0] sel,
    output  reg y
);

always @(*) begin
    case (  sel)
        2'b00 :     y = d0;
        2'b01 :     y = d1;
        2'b10 :     y = d2;
        2'b11 :     y = d3;
        default :   y = 1'bx;
    endcase
end

endmodule

module  mux_2_1 (
    input   d0,
    input   d1,
    input   sel,
    output  reg y
);

always @(*) begin
    case (  sel)
        2'b0 :      y = d0;
        2'b1 :      y = d1;
        default :   y = 1'bx;
    endcase
end

endmodule

module  or_not_mux (
    input   a,
    input   b,
    output  y
);

wire    [1:0] sel;
assign sel = {a, b};

mux_4_1 mux(
    .d0(1'b1),
    .d1(1'b0),
    .d2(1'b0),
    .d3(1'b0),
    .sel(sel),
    .y(y)
);

endmodule

module  or_mux (
    input   a,
    input   b,
    output  y
);

wire    [1:0] sel;
assign sel = {a, b};

mux_4_1 mux(
    .d0(1'b0),
    .d1(1'b1),
    .d2(1'b1),
    .d3(1'b1),
    .sel(sel),
    .y(y)
);

endmodule

module  and_not_mux (
    input   a,
    input   b,
    output  y
);

wire    [1:0] sel;
assign sel = {a, b};

mux_4_1 mux(
    .d0(1'b1),
    .d1(1'b1),
    .d2(1'b1),
    .d3(1'b0),
    .sel(sel),
    .y(y)
);

endmodule

module  and_mux (
    input   a,
    input   b,
    output  y
);

wire    [1:0] sel;
assign sel = {a, b};

mux_4_1 mux(
    .d0(1'b0),
    .d1(1'b0),
    .d2(1'b0),
    .d3(1'b1),
    .sel(sel),
    .y(y)
);

endmodule

module  not_mux (
    input   a,
    output  y
);

mux_2_1 mux(
    .d0(1'b1),
    .d1(1'b0),
    .sel(a),
    .y(y)
);

endmodule

module  and_mux_2_1 (
    input   a,
    input   b,
    output  y
);

mux_2_1 mux (
    .d0(1'b0),
    .d1(a),
    .sel(b),
    .y(y)
);

endmodule