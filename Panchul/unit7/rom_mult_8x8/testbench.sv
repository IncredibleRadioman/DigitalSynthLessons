`timescale 1ns/1ns

module      testbench;

reg     [2:0] a;
reg     [2:0] b;
reg     clk;
wire    [5:0] y;

initial begin
    clk = 1;
    a = 0;
    b = 0;

    #20;
    a = 2;
    b = 7;
    #20;
    a = 3;
    b = 5;
    #20;
    a = 7;
    b = 5;
    #20;
    a = 6;
    b = 4;

end

rom_mult_8x8 dut(
    .a(a),
    .b(b),
    .clk(clk),
    .y(y)
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