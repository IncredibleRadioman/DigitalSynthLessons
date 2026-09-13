`timescale 1ns / 1ps

module      testbench;

reg         [9:0] x;
reg         clk;
wire        [(8 - 1) : 0] y_sinx;
wire        [(8 - 1) : 0] y_sinx_x;
wire        [(8 - 1) : 0] y_gauss;
wire        [(8 - 1) : 0] y_exp;
integer     i;

rom_functs #(
    .X_WIDTH(10),
    .Y_WIDTH(8)
) dut (
    .x(x),
    .clk(clk),
    .y_sinx(y_sinx),
    .y_sinx_x(y_sinx_x),
    .y_gauss(y_gauss),
    .y_exp(y_exp)
);

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

initial begin
    clk = 1;
    x = 0;
    #5;
    for (   i = 0 ; i < (2**10 - 1); i = i + 1) begin
        #20;
        if (    (i % 10) == 0) begin
            $display("i = %d\n", i);
        end
        x = x + 1;
    end

    $finish;


end

//  тактирование
always begin
    #10;
    clk = ~clk;
end

endmodule