`timescale 1ns / 1ps
module testbench;

    reg clk, d;
    wire q, q_n;

    d_flip_flop d_flip_flop(.clk(clk),
                      .d(d),
                      .q(q),
                      .q_n(q_n));

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end

    //  создаем clk отдельно
    always begin
        clk = 1;
        #10; 
        clk = 0;
        #10;
    end

    initial begin
        $monitor("%0d clk %b d %b q %b q_n %b",
                $time, clk, d, q, q_n);

        d = 0;
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