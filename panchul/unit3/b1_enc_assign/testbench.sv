`timescale 1ns / 1ps

module testbench;

    reg [15:0] binary;
    wire [3:0] binary_out;
    reg enable;

    b1_enc_assign dut
    (
        .in(binary),
        .binary_out(binary_out),
        .enable(enable)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end

    initial begin
        $monitor("%0d binary %b binary_out %b enable %b",
                $time, binary, binary_out, enable);

        enable = 1;
        binary = 0;
        #2;
        binary = 1;
        #2;
        binary = 2;
        #2;
        binary = 4;
        #2;
        binary = 8;
        #2;
        binary = 16;
        #2;
        binary = 32;
        #2;
        binary = 64;
        #2 ;
        binary = 128;
        #2;
        binary = 256;
        #2;
        binary = 512;
        #2;
        $finish;
    end

endmodule