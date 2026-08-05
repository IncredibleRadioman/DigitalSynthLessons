`timescale 1ns / 1ps

module testbench;

reg [1:0] a;
reg [1:0] b;
reg [1:0] c;
reg [1:0] d;
reg [1:0] sel;

wire [1:0] y_sel;
wire [1:0] y_block;
wire [1:0] y_block_alt;
wire [1:0] y_case;


initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

b2_mux_4_1_sel dut0(
    .d0(a),
    .d1(b),
    .d2(c),
    .d3(d),
    .sel(sel),
    .y(y_sel)
);

b2_mux_4_1_block dut1(
    .d0(a),
    .d1(b),
    .d2(c),
    .d3(d),
    .sel(sel),
    .y(y_block)
);

b2_mux_4_1_block_alt dut2(
    .d0(a),
    .d1(b),
    .d2(c),
    .d3(d),
    .sel(sel),
    .y(y_block_alt)
);

b2_mux_4_1_case dut3(
    .d0(a),
    .d1(b),
    .d2(c),
    .d3(d),
    .sel(sel),
    .y(y_case)
);

initial begin
    a = 2'b00;
    b = 2'b01;
    c = 2'b10;
    d = 2'b11;

    #5;
    sel = 2'b00;
    #10;
    sel = 2'b01;
    #10;
    sel = 2'b10;
    #10;
    sel = 2'b11;
    #10;
    d = 2'b10;
    #5;
    d = 2'b01;
    #5;
    $finish;
end

endmodule