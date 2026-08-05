`timescale 1ns / 1ps

module testbench;

reg     [7:0] x;
reg     [7:0] y;
reg     [2:0] shamt;
reg     [1:0] operation;
wire    [7:0] result_alu;
wire    zero;


wire    [7:0] result_alu_str;
wire    zero_str;
wire    overflow_str;   


initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

alu #(
    .WIDTH(8),
    .SHIFT(3)) 
dut1 (
    .x(x),
    .y(y),
    .shamt(shamt),
    .operation(operation),
    .zero(zero),
    .result(result_alu)
);

alu_structural #(
    .WIDTH(8),
    .SHIFT(3)) 
dut2 (
    .x(x),
    .y(y),
    .shamt(shamt),
    .operation(operation),
    .carry_in(1'b0),
    .zero(zero_str),
    .overflow(overflow_str),
    .result(result_alu_str)
);

initial begin
    x = 8'b00000000;
    y = 8'b00000000;
    shamt = 3'b000;
    operation = 2'b00;
    #10;
    x = 8'b01100111;
    y = 8'b11111100;
    shamt = 3'b100;
    #10;
    x = 8'b00011100;
    y = 8'b01101000;
    shamt = 3'b111;
    operation = 2'b01;
    #10;
    x = 8'b00010110;
    y = 8'b01000100;
    shamt = 3'b000;
    #10;
    x = 8'b01011001;
    y = 8'b01111000;
    shamt = 3'b011;
    operation = 2'b10;
    #10;
    x = 8'b00010001;
    y = 8'b00100010;
    shamt = 3'b100;
    #10;
    x = 8'b00100101;
    y = 8'b01011110;
    shamt = 3'b110;
    operation = 2'b11;
    #10;
    x = 8'b00010000;
    y = 8'b00010111;
    #10;
    $finish;
end

endmodule