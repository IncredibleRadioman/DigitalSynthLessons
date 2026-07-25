`timescale 1ns / 1ps
module testbench;

    reg clk, rst_n;
    reg [4:0] d;
    wire [4:0] q;


    dff_async_rst_n_param #
    (   .WIDTH(4),
        .RESET(4'ha)
    ) 
    dut(
        .clk(clk),
        .rst_n(rst_n),
        .d(d),
        .q(q)
    );

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

        d = 4'h0;

        $monitor("%0d clk %b rst_n %b d %b q %b",
                $time, clk, rst_n, d, q);
        rst_n = 1; 
        #10; rst_n = 0; // 0
        #10; d = d + 1; // 1
        #10; d = d + 1; // 2
        #10; d = d + 1; // 3
        #10; d = d + 1; rst_n = 1; // 4
        #10; d = d + 1; // 5
        #10; d = d + 1; // 6
        #10; d = d + 1; // 7
        #5; d = d + 1; // 8
        #5; d = d + 1; // 9
        #5; d = d + 1; // a
        #5; d = d + 1; // b
        #5; d = d + 1; rst_n = 0; // c
        #5; d = d + 1; // d
        #5; d = d + 1; // e
        #5; d = d + 1; // f
        #5; d = d + 1; // 0
        $finish;
    end

endmodule