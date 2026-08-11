`timescale 1ns / 1ps

module      testbench;

reg         clk;
reg         rst_n;
reg         load;
reg         [16 - 1 : 0] data_load;
wire        [16 - 1 : 0] cnt;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

preload_counter #(
    .WIDTH(16)
) dut (
    .clk(clk),
    .rst_n(rst_n),
    .load(load),
    .data_load(data_load),
    .cnt(cnt)
);

initial begin
    clk = 0;
    forever begin
        #10; clk = ~clk;
    end
end

initial begin
    rst_n = 1;
    load = 0;
    data_load = 16'h0000;
    #15;
    rst_n = 0;
    #27;
    rst_n = 1;
    #3;
    #78;
    data_load = 16'h0ca9;
    #4;
    load = 1'b1;
    #10;
    load = 1'b0;

    #58;
    data_load = 16'h7877;
    #7;
    load = 1'b1;

    #10;
    load = 1'b0;

    #30;
    $display("TEST OK");
    $finish;
    
end



endmodule