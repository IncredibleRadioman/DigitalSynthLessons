`timescale 1ns / 1ps

module      testbench;

reg         clk_in;
reg         rst_n;
reg         [7:0] imp_width;
wire        pwm_out;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

pwm_counter #(
    .WIDTH(8)
) dut (
    .clk(clk_in),
    .rst_n(rst_n),
    .imp_width(imp_width),
    .pwm_out(pwm_out)
);

initial begin
    clk_in = 0;
    forever begin
        #5; clk_in = ~clk_in;
    end
end

initial begin
    rst_n = 0;
    imp_width = 8'h8c;
    #31;
    rst_n = 1;
    #5000;
    imp_width = 8'h17;
    #5000;

    $display("TEST OK");
    $finish;
end

endmodule