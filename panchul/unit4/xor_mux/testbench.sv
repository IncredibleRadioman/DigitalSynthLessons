`timescale 1ns / 1ps

module  testbench;

reg     a;
reg     b;
wire    y;
wire    y_alt;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

xor_mux dut1 (
    .a(a),
    .b(b),
    .y(y)
);

xor_mux_2 dut2 (
    .a(a),
    .b(b),
    .y(y_alt)
);

initial begin
    a = 0;
    b = 0;
    #10;
    b = 1;
    #10;
    a = 1;
    b = 0;
    #10;
    b = 1;
    #10;
    $finish;
end

endmodule