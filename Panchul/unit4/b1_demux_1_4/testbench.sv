`timescale 1ns / 1ps

module  testbench;

reg     [1:0] sel;
reg     [7:0] din_case;
reg     [1:0] din_block;

wire    [7:0] dout0_case;
wire    [7:0] dout1_case;
wire    [7:0] dout2_case;
wire    [7:0] dout3_case;

wire    [1:0] dout0_block;
wire    [1:0] dout1_block;
wire    [1:0] dout2_block;
wire    [1:0] dout3_block;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

b2_demux_1_4_block dut1 (
    .din(din_block),
    .sel(sel),
    .dout0(dout0_block),
    .dout1(dout1_block),
    .dout2(dout2_block),
    .dout3(dout3_block)
);

bn_demux_1_4_case #(.DATA_WIDTH(8)) dut2 (
    .din(din_case),
    .sel(sel),
    .dout0(dout0_case),
    .dout1(dout1_case),
    .dout2(dout2_case),
    .dout3(dout3_case)
);

initial begin
    din_case = 8'b11111111;
    din_block = 2'b11;
    #5;
    sel = 0;
    #10;
    sel = 1;
    #10;
    sel = 2;
    #10;
    sel = 3;
    #10;
    din_case = 8'b10101010;
    din_block = 2'b10;
    #10;
    din_case = 8'b01010101;
    din_block = 2'b01;
    #10;
    $finish;
end


endmodule