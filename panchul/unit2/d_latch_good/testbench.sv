`timescale 1ns / 1ps
module testbench;

    reg clk, d;
    wire q;

    d_latch d_latch(.clk(clk),
                      .d(d),
                      .q(q));

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end

    //  создаем clk отдельно
    always begin
        #10; clk = 1;
        #10; clk = 0;
    end

    initial begin
        $monitor("%0d clk %b d %b q %b",
                $time, clk, d, q);

        #20; d = 0;
        #10; d = 1;
        #20; d = 0;
        #15; d = 1;
        #30; d = 1;
        #5; d = 0;
        #5; d = 1;
        #10;
        $finish;
    end

endmodule