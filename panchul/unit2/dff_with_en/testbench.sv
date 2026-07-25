`timescale 1ns / 1ps
module testbench;

    reg clk, d, en;
    wire q;

    dff_with_en dff_with_en(.clk(clk),
                    .en(en),
                    .d(d),
                    .q(q));

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end

    //  создаем clk отдельно
    always begin
        #10; clk = 0;
        #10; clk = 1;
    end

    initial begin
        $monitor("%0d clk %b en %b d %b q %b",
                $time, clk, en, d, q);
        en = 0; 
        #10; d = 0; 
        #20; d = 1;
        #20; en = 1;
        #20; d = 0;
        #25; d = 1;
        #10; en = 0;
        #20; d = 0;
        #15;
        $finish;
    end

endmodule
