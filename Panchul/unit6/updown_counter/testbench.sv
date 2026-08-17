`timescale 1ns / 1ps

module testbench;

reg         clk;
reg         rst_n;
reg         up_down;
wire        [7:0] cnt;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

updown_counter #(
    .WIDTH(8)
) dut (
    .clk(clk),
    .rst_n(rst_n),
    .up_down(up_down),
    .cnt(cnt)
);

initial begin
    clk = 0;
    forever begin
        #10;
        clk = ~clk;
    end
end

initial begin
    rst_n = 0;
    up_down = 0;
    #25;
    rst_n = 1;
    #47;
    up_down = 1;
    #56;
    up_down = 0;
    #71;
    $display("TEST OK");
    $finish;
end

endmodule