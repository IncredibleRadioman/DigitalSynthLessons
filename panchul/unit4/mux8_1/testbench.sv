`timescale 1ns / 1ps

module  testbench;

reg     [8-1 : 0] d0;
reg     [8-1 : 0] d1;
reg     [8-1 : 0] d2;
reg     [8-1 : 0] d3;
reg     [8-1 : 0] d4;
reg     [8-1 : 0] d5;
reg     [8-1 : 0] d6;
reg     [8-1 : 0] d7;
reg     [2:0] sel;
wire    [8-1 : 0] y;
wire    [8-1 : 0] y_if;
wire    [8-1 : 0] y_case;
wire    [8-1 : 0] y_comb_ternar;
wire    [8-1 : 0] y_comb_if;
wire    [8-1 : 0] y_comb_case;
wire    [8-1 : 0] y_comb_ternar_mux2_1;
wire    [8-1 : 0] y_comb_if_mux2_1;
wire    [8-1 : 0] y_comb_case_mux2_1;


initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

mux8_1_ternar #(
    .DATA_WIDTH(8)
) dut1 (
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

mux8_1_if #(
    .DATA_WIDTH(8)
) dut2 (
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

mux8_1_case #(
    .DATA_WIDTH(8)
) dut3 (
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .d4(d4),
    .d5(d5),
    .d6(d6),
    .d7(d7),
    .sel(sel),
    .y(y_case)
);

mux8_1_comb_ternar #(
    .DATA_WIDTH(8)
) dut4 (
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .d4(d4),
    .d5(d5),
    .d6(d6),
    .d7(d7),
    .sel(sel),
    .y(y_comb_ternar)
);

mux8_1_comb_if #(
    .DATA_WIDTH(8)
) dut5 (
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .d4(d4),
    .d5(d5),
    .d6(d6),
    .d7(d7),
    .sel(sel),
    .y(y_comb_if)
);

mux8_1_comb_case #(
    .DATA_WIDTH(8)
) dut6 (
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .d4(d4),
    .d5(d5),
    .d6(d6),
    .d7(d7),
    .sel(sel),
    .y(y_comb_case)
);

mux8_1_comb_ternar_mux_2_1 #(
    .DATA_WIDTH(8)
) dut7 (
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .d4(d4),
    .d5(d5),
    .d6(d6),
    .d7(d7),
    .sel(sel),
    .y(y_comb_ternar_mux2_1)
);

mux8_1_comb_if_mux_2_1 #(
    .DATA_WIDTH(8)
) dut8 (
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .d4(d4),
    .d5(d5),
    .d6(d6),
    .d7(d7),
    .sel(sel),
    .y(y_comb_if_mux2_1)
);

mux8_1_comb_case_mux_2_1 #(
    .DATA_WIDTH(8)
) dut9 (
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .d4(d4),
    .d5(d5),
    .d6(d6),
    .d7(d7),
    .sel(sel),
    .y(y_comb_case_mux2_1)
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
    #10;
    sel = 0;
    #10;
    sel = 1;
    #10;
    sel = 2;
    #10;
    sel = 3;
    #10;
    sel = 4;
    #10;
    sel = 5;
    #10;
    sel = 6;
    #10;
    sel = 7;
    #10;
    $finish;
end

endmodule