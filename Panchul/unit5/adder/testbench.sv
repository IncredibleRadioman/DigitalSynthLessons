`timescale 1ns / 1ps

module testbench;

parameter WIDTH = 8;

reg     c_in;
reg     [WIDTH - 1 : 0] x;
reg     [WIDTH - 1 : 0] y;
wire    [WIDTH - 1 : 0] z;
wire    c_out;

adder #(
    .WIDTH(WIDTH)
) adder_dut (
    .x(x),
    .y(y),
    .carry_in(c_in),
    .z(z),
    .carry_out(c_out)
);

//  test sequence
initial begin
    x = 0;
    y = 0;
    c_in = 0;
    #8;
    $finish;
end

initial forever begin
    #1;
    x = $urandom_range(0, 2**WIDTH - 1);
    y = $urandom_range(0, 2**WIDTH - 1);

    c_in = $urandom_range(0, 1);        
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

endmodule