`timescale 1ns / 1ps

module testbench;

reg     a;
reg     b;
wire    y_or_not;
wire    y_or;
wire    y_and_not;
wire    y_and;
wire    y_not;
wire    y_and_mux_2_1;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

or_not_mux dut1(
    .a(a),
    .b(b),
    .y(y_or_not)
);

or_mux dut2(
    .a(a),
    .b(b),
    .y(y_or)
);

and_not_mux dut3(
    .a(a),
    .b(b),
    .y(y_and_not)
);

and_mux dut4(
    .a(a),
    .b(b),
    .y(y_and)
);

not_mux dut5(
    .a(a),
    .y(y_not)
);

and_mux_2_1 dut6(
    .a(a),
    .b(b),
    .y(y_and_mux_2_1)
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