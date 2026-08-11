`timescale 1ns / 1ps

module testbench;

reg     clk;
reg     rst_n;
wire    [7:0] cnt;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

simple_counter #(
    .WIDTH(8)
) dut (
    .clk(clk),
    .rst_n(rst_n),
    .cnt(cnt)
);

//  генерация тактового сигнала
initial begin
    clk = 0;
    forever begin
        #10; 
        clk = ~clk;
    end
end

//  управление ресетом и остановка симуляции
initial begin
    rst_n = 0;
    #25;
    rst_n = 1;
    
    #1000;
    $finish;
end

endmodule