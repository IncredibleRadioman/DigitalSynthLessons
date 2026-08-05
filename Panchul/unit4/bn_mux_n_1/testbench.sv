//  проверка полностью параметризованного селектора
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

wire    [63:0]  data;

assign data = {d7, d6, d5, d4, d3, d2, d1, d0};

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

bn_select_n_1_and_or #(
    .DATA_WIDTH(8),
    .INPUT_CHANNELS(8)
) dut (
    .data(data),
    .sel(sel),
    .y(y)
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