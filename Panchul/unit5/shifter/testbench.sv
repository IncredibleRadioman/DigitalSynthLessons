`timescale 1ns / 1ps

module  testbench;

reg     [7:0] x;
reg     [2:0] shamt;
wire    [7:0] y_lsh;
wire    [7:0] y_rsh;
wire    [7:0] y_lrot;
wire    [7:0] y_rrot;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

left_shifter #(
    .WIDTH(8),
    .SHIFT(3))
dut1 (
    .x(x),
    .shamt(shamt),
    .z(y_lsh)
);

right_shifter #(
    .WIDTH(8),
    .SHIFT(3))
dut2 (
    .x(x),
    .shamt(shamt),
    .z(y_rsh)
);

left_rotator #(
    .WIDTH(8),
    .SHIFT(3))
dut3 (
    .x(x),
    .shamt(shamt),
    .z(y_lrot)
);

right_rotator #(
    .WIDTH(8),
    .SHIFT(3))
dut4 (
    .x(x),
    .shamt(shamt),
    .z(y_rrot)
);

initial begin
    x = 8'b00000000;
    shamt = 3'b000;
    #10;
    x = 8'b11100111;
    shamt = 3'b100;
    #10;
    x = 8'b10011100;
    #10;
    x = 8'b11101000;
    shamt = 3'b111;
    #10;
    x = 8'b00010110;
    shamt = 3'b100;
    #10;
    x = 8'b00000000;
    shamt = 3'b001;
    #10;
    x = 8'b11111000;
    shamt = 3'b011;
    #10;
    x = 8'b00010001;
    shamt = 3'b010;
    #10;
    $finish;
end

endmodule