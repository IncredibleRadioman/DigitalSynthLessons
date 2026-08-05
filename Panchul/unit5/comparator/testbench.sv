`timescale 1ns / 1ps

module testbench;

parameter WIDTH = 8;

reg     [WIDTH - 1 : 0] x;
reg     [WIDTH - 1 : 0] y;

wire    eq;
wire    neq;
wire    lt;
wire    lte;
wire    gt;
wire    gte;

comparator #(.WIDTH(WIDTH)) dut (
    .x(x),
    .y(y),
    .eq(eq),
    .neq(neq),
    .lt(lt),
    .lte(lte),
    .gt(gt),
    .gte(gte)
);

//  test sequence
initial begin
    x = 0;
    y = 0;
    #8;
    $finish;
end

initial forever begin
    #1;
    x = $urandom_range(0, 2**WIDTH - 1);
    y = $urandom_range(0, 2**WIDTH - 1);      
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

endmodule