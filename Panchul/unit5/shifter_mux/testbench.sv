`timescale 1ns / 1ps

`define     TEST_NUMBER 10

module      testbench;

reg     [7:0] data_8b_in;
reg     [2:0] shift_8b;

reg     [15:0] data_16b_in;
reg     [3:0] shift_16b;

reg     [31:0] data_32b_in;
reg     [4:0] shift_32b;

wire    [7:0] data_lsh_8b_out;
wire    [15:0] data_lsh_16b_out;
wire    [31:0] data_lsh_32b_out;

reg     [7:0] ideal_data_lsh_8b_out;
reg     [15:0] ideal_data_lsh_16b_out;
reg     [31:0] ideal_data_lsh_32b_out;

wire    [7:0] data_rsh_8b_out;
wire    [15:0] data_rsh_16b_out;
wire    [31:0] data_rsh_32b_out;

reg     [7:0] ideal_data_rsh_8b_out;
reg     [15:0] ideal_data_rsh_16b_out;
reg     [31:0] ideal_data_rsh_32b_out;

wire    [7:0] data_arsh_8b_out;
wire    [15:0] data_arsh_16b_out;
wire    [31:0] data_arsh_32b_out;

reg     [7:0] ideal_data_arsh_8b_out;
reg     [15:0] ideal_data_arsh_16b_out;
reg     [31:0] ideal_data_arsh_32b_out;

reg     [31:0] i;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

// ---------------------------------
left_shifter_mux_8b lsh_8b(
    .data_in(data_8b_in),
    .shift(shift_8b),
    .data_out(data_lsh_8b_out)
);

left_shifter_mux_16b lsh_16b(
    .data_in(data_16b_in),
    .shift(shift_16b),
    .data_out(data_lsh_16b_out)
);

left_shifter_mux_32b lsh_32b(
    .data_in(data_32b_in),
    .shift(shift_32b),
    .data_out(data_lsh_32b_out)
);

// -----------------------------------
right_shifter_mux_8b rsh_8b(
    .data_in(data_8b_in),
    .shift(shift_8b),
    .data_out(data_rsh_8b_out)
);

right_shifter_mux_16b rsh_16b(
    .data_in(data_16b_in),
    .shift(shift_16b),
    .data_out(data_rsh_16b_out)
);

right_shifter_mux_32b rsh_32b(
    .data_in(data_32b_in),
    .shift(shift_32b),
    .data_out(data_rsh_32b_out)
);

// ---------------------------------
right_arith_shifter_mux_8b arsh_8b(
    .data_in(data_8b_in),
    .shift(shift_8b),
    .data_out(data_arsh_8b_out)
);

right_arith_shifter_mux_16b arsh_16b(
    .data_in(data_16b_in),
    .shift(shift_16b),
    .data_out(data_arsh_16b_out)
);

right_arith_shifter_mux_32b arsh_32b(
    .data_in(data_32b_in),
    .shift(shift_32b),
    .data_out(data_arsh_32b_out)
);

initial begin
    for(i = 0; i <= 9; i = i + 1) begin
        data_8b_in = $urandom_range(1 << 8 - 1, 0);
        data_16b_in = $urandom_range(1 << 16 - 1, 0);
        data_32b_in = $urandom_range(1 << 32 - 1, 0);

        shift_8b = $urandom_range(1 << 3 - 1, 0);
        shift_16b = $urandom_range(1 << 4 - 1, 0);
        shift_32b = $urandom_range(1 << 5 - 1, 0);

        ideal_data_lsh_8b_out = data_8b_in << shift_8b;
        ideal_data_lsh_16b_out = data_16b_in << shift_16b;
        ideal_data_lsh_32b_out = data_32b_in << shift_32b;

        ideal_data_rsh_8b_out = data_8b_in >> shift_8b;
        ideal_data_rsh_16b_out = data_16b_in >> shift_16b;
        ideal_data_rsh_32b_out = data_32b_in >> shift_32b;

        ideal_data_arsh_8b_out = data_8b_in >>> shift_8b;
        ideal_data_arsh_16b_out = data_16b_in >>> shift_16b;
        ideal_data_arsh_32b_out = data_32b_in >>> shift_32b;

        #5;

        //  сравнение результатов
        if (ideal_data_lsh_8b_out != data_lsh_8b_out) begin
            $display("%d << %d = %d != %d\n", 
                data_8b_in, 
                shift_8b, 
                data_lsh_8b_out, 
                ideal_data_lsh_8b_out);
            $finish;
        end

        if (ideal_data_lsh_16b_out != data_lsh_16b_out) begin
            $display("%d << %d = %d != %d\n", 
                data_16b_in, 
                shift_16b, 
                data_lsh_16b_out, 
                ideal_data_lsh_16b_out);
            $finish;
        end

        if (ideal_data_lsh_32b_out != data_lsh_32b_out) begin
            $display("%d << %d = %d != %d\n", 
                data_32b_in, 
                shift_32b, 
                data_lsh_32b_out, 
                ideal_data_lsh_32b_out);
            $finish;
        end

        // ///
        if (ideal_data_rsh_8b_out != data_rsh_8b_out) begin
            $display("%d >> %d = %d != %d\n", 
                data_8b_in, 
                shift_8b, 
                data_rsh_8b_out, 
                ideal_data_rsh_8b_out);
            $finish;
        end

        if (ideal_data_rsh_16b_out != data_rsh_16b_out) begin
            $display("%d >> %d = %d != %d\n", 
                data_16b_in, 
                shift_16b, 
                data_rsh_16b_out, 
                ideal_data_rsh_16b_out);
            $finish;
        end

        if (ideal_data_rsh_32b_out != data_rsh_32b_out) begin
            $display("%d << %d = %d != %d\n", 
                data_32b_in, 
                shift_32b, 
                data_rsh_32b_out, 
                ideal_data_rsh_32b_out);
            $finish;
        end

        // ///
        if (ideal_data_arsh_8b_out != data_arsh_8b_out) begin
            $display("%d >>> %d = %d != %d\n", 
                data_8b_in, 
                shift_8b, 
                data_arsh_8b_out, 
                ideal_data_arsh_8b_out);
            $finish;
        end

        if (ideal_data_arsh_16b_out != data_arsh_16b_out) begin
            $display("%d >> %d = %d != %d\n", 
                data_16b_in, 
                shift_16b, 
                data_arsh_16b_out, 
                ideal_data_arsh_16b_out);
            $finish;
        end

        if (ideal_data_arsh_32b_out != data_arsh_32b_out) begin
            $display("%d << %d = %d != %d\n", 
                data_32b_in, 
                shift_32b, 
                data_arsh_32b_out, 
                ideal_data_arsh_32b_out);
            $finish;
        end

        #10;
    end
    $display("Tests have been finished\n");
    $finish;
end

endmodule