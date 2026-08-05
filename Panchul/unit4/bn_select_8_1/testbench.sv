`timescale 1ns / 1ps

module testbench;

reg     [7:0] d0;
reg     [7:0] d1;
reg     [7:0] d2;
reg     [7:0] d3;
reg     [7:0] d4;
reg     [7:0] d5;
reg     [7:0] d6;
reg     [7:0] d7;
reg     [7:0] sel;

wire    [7:0] y;
wire    [7:0] y_if;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

bn_select_8_1_case dut1 (
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .d4(d4),
    .d5(d5),
    .d6(d6),
    .d7(d7),
    .sel(sel),
    .y(y)
);

bn_select_8_1_if dut2 (
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .d4(d4),
    .d5(d5),
    .d6(d6),
    .d7(d7),
    .sel(sel),
    .y(y_if)
);

initial begin
    d0 = 0;
    d1 = 1;
    d2 = 2;
    d3 = 3;
    d4 = 4;
    d5 = 5;
    d6 = 6;
    d7 = 7;
    #5;
    sel = 8'b00000001;
    #10;
    sel = 8'b00000010;
    #10;
    sel = 8'b00000100;
    #10;
    sel = 8'b00001000;
    #10;
    sel = 8'b00010000;
    #10;
    sel = 8'b00100000;
    #10;
    sel = 8'b01000000;
    #10;
    sel = 8'b10000000;
    #10;
    d7 = 123;
    #10;
    d7 = 77;
    #10;
    $finish;
end

endmodule