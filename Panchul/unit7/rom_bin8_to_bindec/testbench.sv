`timescale 1ns/1ns

module      testbench;

reg     [7:0] a;
reg     clk;
wire    [1:0] hundreds;
wire    [3:0] tens;
wire    [3:0] ones;

initial begin
    clk = 1;
    a = 0;

    #20;
    a = 122;
    #20;
    a = 36;
    #20;
    a = 204;
    #20;
    a = 98;

end

rom_bin8_to_bindec dut(
    .a(a),
    .clk(clk),
    .hundreds(hundreds),
    .tens(tens),
    .ones(ones)
);

always begin
    #10;
    clk = ~clk;
end

initial begin
    #100;
    $finish;
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end


endmodule