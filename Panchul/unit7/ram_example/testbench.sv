`timescale 1ns / 1ns

module      testbench;

reg     [3:0] data_in;
reg     [5:0] addr;
reg     we;
reg     clk;
wire    [3:0] data_out;
wire    [5:0] addr_out;

ram_parametric #(
    .DATA_WIDTH(4),
    .ADDR_WIDTH(6)
) dut (
    .data_in(data_in),
    .addr(addr),
    .we(we),
    .clk(clk),
    .data_out(data_out),
    .addr_out(addr_out)
);

initial begin
    clk = 0;
    we = 0;
    addr = 6'b000000;
    data_in = 4'b0000;

    //  запись в память
    #20; we = 1;

    for (addr = 0; addr < 6; addr = addr + 1) begin
        #20;
        data_in = data_in + 1;
    end

    //  чтение данных из памяти
    #20; we = 0;

    for (addr = 0; addr < 6; addr = addr + 1) begin
        #20;
    end

end

//  генерация клока
always #10 clk = ~clk;

initial begin
    #300;
    $finish;
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end


endmodule