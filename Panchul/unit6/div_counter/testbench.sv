`timescale 1ns / 1ps

module      testbench;

reg         clk_in;
reg         rst_n;
wire        clk_out;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

div_counter #(
    .CNT_DIV(5)
) dut (
    .clk_in(clk_in),
    .rst_n(rst_n),
    .clk_out(clk_out)
);

initial begin
    clk_in = 0;
    forever begin
        #10; clk_in = ~clk_in;
    end
end

initial begin
    rst_n = 0;
    #32;
    rst_n = 1;
    #500;
    $display("TEST OK");
    $finish;
end

endmodule