`timescale 1ns / 1ps
module testbench;

    reg s, r;
    wire q, q_n;

    sr_latch sr_latch(.s(s),
                      .r(r),
                      .q(q),
                      .q_n(q_n));

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end

    initial begin
        $monitor("%0d s %b r %b q %b q_n %b",
                $time, s, r, q, q_n);

        #10; s = 0; r = 0;
        #10; s = 1; r = 0;
        #10; s = 0; r = 0;
        #10; s = 0; r = 1;
        #10; s = 0; r = 0;
        #10; s = 1; r = 0;
        #10; s = 0; r = 0;
        #10;
        $finish;
    end

endmodule