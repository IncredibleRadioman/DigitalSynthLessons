`timescale 1ns / 1ps

module testbench;

reg [1:0] key;
wire [9:0] led;

lab1 dut(key, led);

initial begin
    key = 2'b00;
    #10;
    key = 2'b01;
    #10;
    key = 2'b10;
    #10;
    key = 2'b11;
    #10;
    $finish;
end

initial
    $monitor("key = %b led = %b", key, led);

initial begin
    $dumpfile("wave.vcd");        // Имя файла, куда запишутся графики
    $dumpvars;
end

endmodule