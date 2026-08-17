`timescale 1ns / 1ps

module testbench;

reg         clk;
reg         rst_n;
wire        [3:0] cnt;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

gray_counter #(
    .WIDTH(4)
) dut (
    .clk(clk),
    .rst_n(rst_n),
    .cnt(cnt)
);

initial begin
    clk = 0;
    forever begin
        #5; clk = ~clk;
    end
end

initial begin
    rst_n = 0;
    #31;
    rst_n = 1;
    #500;
    $display("TEST OK");
    $finish;
end

endmodule