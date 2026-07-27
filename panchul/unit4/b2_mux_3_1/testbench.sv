`timescale 1ns / 1ps

module  testbench;

reg     [1:0] a;
reg     [1:0] b;
reg     [1:0] c;
reg     [1:0] sel;

wire    [1:0] y_case_latch;
wire    [1:0] y_case_correct;
wire    [1:0] y_casex_correct;
wire    [1:0] y_if_latch;
wire    [1:0] y_if_correct;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

b2_mux_3_1_case_latch dut1(
    .d0(a),
    .d1(b),
    .d2(c),
    .sel(sel),
    .y(y_case_latch)
);

b2_mux_3_1_case_correct dut2(
    .d0(a),
    .d1(b),
    .d2(c),
    .sel(sel),
    .y(y_case_correct)
);

b2_mux_3_1_casex_correct dut3(
    .d0(a),
    .d1(b),
    .d2(c),
    .sel(sel),
    .y(y_casex_correct)
);

b2_mux_3_1_if_latch dut4(
    .d0(a),
    .d1(b),
    .d2(c),
    .sel(sel),
    .y(y_if_latch)
);

b2_mux_3_1_if_correct dut5(
    .d0(a),
    .d1(b),
    .d2(c),
    .sel(sel),
    .y(y_if_correct)
);

initial begin
    a = 2'b00;
    b = 2'b01;
    c = 2'b10;

    #5;
    sel = 2'b00;
    #10;
    sel = 2'b01;
    #10;
    sel = 2'b10;
    #10;
    sel = 2'b11;
    #10;
    sel = 2'b00;
    #10;
    sel = 2'b11;
    #10;
    $finish;

end

endmodule