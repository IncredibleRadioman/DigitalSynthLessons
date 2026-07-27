`timescale 1ns / 1ps

module testbench;

reg [1:0] d0;
reg [1:0] d1;
reg sel;

wire [1:0] y_case;
wire [1:0] y_if;
wire [1:0] y_sel;
wire [1:0] y_comb_incorrect;
wire [1:0] y_comb_correct1;
wire [1:0] y_comb_correct2;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

b2_mux_2_1_case dut1 (
    .d0(d0),
    .d1(d1),
    .sel(sel),
    .y(y_case)
);

b2_mux_2_1_if dut2 (
    .d0(d0),
    .d1(d1),
    .sel(sel),
    .y(y_if)
);

b2_mux_2_1_sel dut3 (
    .d0(d0),
    .d1(d1),
    .sel(sel),
    .y(y_sel)
);

b2_mux_2_1_comb_incorrect dut4 (
    .d0(d0),
    .d1(d1),
    .sel(sel),
    .y(y_comb_incorrect)
);

b2_mux_2_1_comb_correct1 dut5 (
    .d0(d0),
    .d1(d1),
    .sel(sel),
    .y(y_comb_correct1)
);

b2_mux_2_1_comb_correct2 dut6 (
    .d0(d0),
    .d1(d1),
    .sel(sel),
    .y(y_comb_correct2)
);

initial begin
    $monitor(
    "%0d d0 %b d1 %b sel %b y_case %b y_if %b y_sel %b y_comb_incorrect %b y_comb_correct1 %b y_comb_correct2 %b",
    $time, d0, d1, sel, y_case, y_if, y_sel, y_comb_incorrect, y_comb_correct1, y_comb_correct2
    );

    d0 = 2'b00;
    d1 = 2'b11;

    #5;
    sel = 1'b0;
    #10;
    sel = 1'b1;
    #10;
    d1 = 2'b10;
    #5;
    d1 = 2'b01;
    #5;
    $finish;

end


endmodule