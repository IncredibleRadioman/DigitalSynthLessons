`timescale 1ns / 1ps
module testbench;

    reg clk, d, rst_n;
    wire q;

    dff_async_rst_n dff_async_rst_n(.clk(clk),
                    .rst_n(rst_n),
                    .d(d),
                    .q(q));

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end

    //  создаем clk отдельно
    always begin
        clk = 1; #10;
        clk = 0; #10;
    end

    initial begin
        $monitor("%0d clk %b rst_n %b d %b q %b",
                $time, clk, rst_n, d, q);
        rst_n = 1; 
        #10; d = 0; rst_n = 0;
        #20; d = 1;
        #20; rst_n = 1;
        #20; d = 0;
        #25; d = 1;
        #10; rst_n = 0;
        #20; d = 0;
        #15;
        $finish;
    end

endmodule