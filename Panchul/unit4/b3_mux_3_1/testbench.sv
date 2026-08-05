`timescale 1ns / 1ps

module  testbench;

reg     [2:0] d0;
reg     [2:0] d1;
reg     [2:0] d2;
reg     [1:0] sel;
wire    [2:0] y;
wire    [2:0] y_if;
wire    [2:0] y_case;
wire    [2:0] y_comb_mux_2_1_if;
wire    [2:0] y_comb_mux_2_1_case;
wire    [2:0] y_comb_b1_mux_3_1_case;
wire    [2:0] y_comb_b1_mux_3_1_if;
wire    [2:0] y_comb_b1_mux_3_1_ternar;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

b3_mux_3_1_ternar dut1(
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .sel(sel),
    .y(y)
);

b3_mux_3_1_if dut2(
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .sel(sel),
    .y(y_if)
);

b3_mux_3_1_case dut3(
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .sel(sel),
    .y(y_case)
);

b3_mux_3_1_comb_mux_2_1_if dut4(
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .sel(sel),
    .y(y_comb_mux_2_1_if)
);

b3_mux_3_1_comb_mux_2_1_case dut5(
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .sel(sel),
    .y(y_comb_mux_2_1_case)
);

b3_mux_3_1_comb_b1_mux_3_1_case dut6(
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .sel(sel),
    .y(y_comb_b1_mux_3_1_case)
);

b3_mux_3_1_comb_b1_mux_3_1_if dut7(
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .sel(sel),
    .y(y_comb_b1_mux_3_1_if)
);

b3_mux_3_1_comb_b1_mux_3_1_ternar dut8(
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .sel(sel),
    .y(y_comb_b1_mux_3_1_ternar)
);

initial begin
    d0 = 0;
    d1 = 1;
    d2 = 2;
    #10;
    sel = 0;
    #10;
    sel = 1;
    #10;
    sel = 2;
    #10;
    sel = 3;
    #10;
    $finish;
end


endmodule