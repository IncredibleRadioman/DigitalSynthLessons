`timescale 1ns / 1ps

module testbench;

reg         data_in;
reg         clk;
reg         rst_n;
reg         shift_en;
wire        [7:0] data_out;
wire        serial_out;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

shift_reg_en #(
    .WIDTH(8)
) dut (
    .data_in(data_in),
    .clk(clk),
    .rst_n(rst_n),
    .shift_en(shift_en),
    .data_out(data_out),
    .serial_out(serial_out)
);

initial begin
    clk = 0;
    forever begin
        #10; clk = ~clk;
    end
end

initial begin
    rst_n = 0;
    data_in = 0;
    shift_en = 0;
    #20;
    rst_n = 1;
    #55;
    shift_en = 1;
    #10;
    data_in = 1;
    #300;
    shift_en = 0;

    #100;
    $display("TEST OK");
    $finish;
end


endmodule