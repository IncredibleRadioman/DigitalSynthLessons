`timescale 1ns / 1ps

module      testbench;

reg     [31:0] x;
reg     [31:0] y;
reg     carry_in;
wire    [31:0] z;
wire    carry_out;

reg     [31:0] z_ideal;
reg     carry_out_ideal;

reg     [31:0] i;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

prefix_adder_KS #
(
    .LEVELS(5)
) dut (
    .x(x),
    .y(y),
    .carry_in(carry_in),
    .z(z),
    .carry_out(carry_out)
);

initial begin
    for (i = 0; i < 50; i++) begin
        x = $random;
        y = $random;
        carry_in = $urandom_range(1, 0);

        {carry_out_ideal, z_ideal} = x + y + carry_in;

        #5;

        if ((carry_out_ideal != carry_out) ||
            (z_ideal != z)) begin
            $display("TEST FAILED\n");
            $finish;
        end

        #10;
    end

    $display("TEST OK\n");
    $finish;
end


endmodule