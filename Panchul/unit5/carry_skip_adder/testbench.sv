`timescale 1ns / 1ps

module testbench;

reg     [7:0] x_8b;
reg     [7:0] y_8b;
reg     carry_in_8b;
wire    [7:0] z_8b;
wire    carry_out_8b;
reg    [7:0] ideal_z_8b;
reg    ideal_carry_out_8b;

reg     [15:0] x_16b;
reg     [15:0] y_16b;
reg     carry_in_16b;
wire    [15:0] z_16b;
wire    carry_out_16b;
reg    [15:0] ideal_z_16b;
reg    ideal_carry_out_16b;

reg     [31:0] x_32b;
reg     [31:0] y_32b;
reg     carry_in_32b;
wire    [31:0] z_32b;
wire    carry_out_32b;
reg    [31:0] ideal_z_32b;
reg    ideal_carry_out_32b;

wire    [31:0] z_par_b;
wire    carry_out_par_b;

reg     [63:0] x_64b;
reg     [63:0] y_64b;
reg     carry_in_64b;
wire    [63:0] z_64b;
wire    carry_out_64b;
reg    [63:0] ideal_z_64b;
reg    ideal_carry_out_64b;

reg     [31:0] i;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

carry_skip_adder_8b adder_8b(
    .x(x_8b),
    .y(y_8b),
    .carry_in(carry_in_8b),
    .z(z_8b),
    .carry_out(carry_out_8b)
);

carry_skip_adder_16b adder_16b(
    .x(x_16b),
    .y(y_16b),
    .carry_in(carry_in_16b),
    .z(z_16b),
    .carry_out(carry_out_16b)
);

carry_skip_adder_32b adder_32b(
    .x(x_32b),
    .y(y_32b),
    .carry_in(carry_in_32b),
    .z(z_32b),
    .carry_out(carry_out_32b)
);

carry_skip_adder #(
    .BLOCK_COUNT(8),
    .BLOCK_SIZE(4)
) adder_par (
    .x(x_32b),
    .y(y_32b),
    .carry_in(carry_in_32b),
    .z(z_par_b),
    .carry_out(carry_out_par_b)
);

carry_skip_adder_64b adder_64b(
    .x(x_64b),
    .y(y_64b),
    .carry_in(carry_in_64b),
    .z(z_64b),
    .carry_out(carry_out_64b)
);

initial begin
    for (i = 0; i < 50; i = i + 1) begin
        x_8b = $urandom_range((1 << 8) - 1, 0);
        y_8b = $urandom_range((1 << 8) - 1, 0);
        carry_in_8b = $urandom_range(1, 0);

        x_16b = $urandom_range((1 << 16) - 1, 0);
        y_16b = $urandom_range((1 << 16) - 1, 0);
        carry_in_16b = $urandom_range(1, 0);

        x_32b = $random;
        y_32b = $random;
        carry_in_32b = $urandom_range(1, 0);
        
        x_64b = {$random, $random};
        y_64b = {$random, $random};
        carry_in_64b = $urandom_range(1, 0);

        {ideal_carry_out_8b, ideal_z_8b} = x_8b + y_8b + carry_in_8b;
        {ideal_carry_out_16b, ideal_z_16b} = x_16b + y_16b + carry_in_16b;
        {ideal_carry_out_32b, ideal_z_32b} = x_32b + y_32b + carry_in_32b;
        {ideal_carry_out_64b, ideal_z_64b} = x_64b + y_64b + carry_in_64b;

        #5;
        if ((ideal_carry_out_8b != carry_out_8b) ||
            (ideal_z_8b != z_8b)) begin
            $display("ERROR: %d + %d + %b = {%b, %d} != {%b, %d}\n", 
                x_8b, 
                y_8b, 
                carry_in_8b,
                carry_out_8b, 
                z_8b,
                ideal_carry_out_8b,
                ideal_z_8b);
            $finish;
        end

        if ((ideal_carry_out_16b != carry_out_16b) ||
            (ideal_z_16b != z_16b)) begin
            $display("ERROR: %d + %d + %b = {%b, %d} != {%b, %d}\n", 
                x_16b, 
                y_16b, 
                carry_in_16b,
                carry_out_16b, 
                z_16b,
                ideal_carry_out_16b,
                ideal_z_16b);
            $finish;
        end

        if ((ideal_carry_out_32b != carry_out_32b) ||
            (ideal_z_32b != z_32b)) begin
            $display("ERROR: %d + %d + %b = {%b, %d} != {%b, %d}\n", 
                x_32b, 
                y_32b, 
                carry_in_32b,
                carry_out_32b, 
                z_32b,
                ideal_carry_out_32b,
                ideal_z_32b);
            $finish;
        end

        if ((ideal_carry_out_64b != carry_out_64b) ||
            (ideal_z_64b != z_64b)) begin
            $display("ERROR: %d + %d + %b = {%b, %d} != {%b, %d}\n", 
                x_64b, 
                y_64b, 
                carry_in_64b,
                carry_out_64b, 
                z_64b,
                ideal_carry_out_64b,
                ideal_z_64b);
            $finish;
        end

        if ((ideal_carry_out_32b != carry_out_par_b) ||
            (ideal_z_32b != z_par_b)) begin
            $display("ERROR: %d + %d + %b = {%b, %d} != {%b, %d}\n", 
                x_32b, 
                y_32b, 
                carry_in_32b,
                carry_out_par_b, 
                z_par_b,
                ideal_carry_out_32b,
                ideal_z_32b);
            $finish;

        end

        #10;

    end
    $display("TEST OK\n");
    $finish;
end

endmodule