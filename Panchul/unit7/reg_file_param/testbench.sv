//  непосредственно тестирование регистрового файла
`timescale 1ns / 1ns

module      testbench;

//  входные и выходные сигналы
reg     clk;
reg     we;
reg     [4:0] addr;
reg     [31:0] data_in;
wire    [31:0] data_out;

reg_file_param    #(
    .DATA_WIDTH(32),
    .ADDR_WIDTH(5)
) dut (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
);

initial begin

    clk = 1;
    we = 1'b1;
    addr = 0;
    data_in = 0;

    #5;

    repeat(7) begin
        #20;
        addr = addr + 1;
        data_in = data_in + 1;
    end

    #40;
    we = 1'b0;
    addr = 0;
    data_in = 0;

    repeat(7) begin
        #20;
        addr = addr + 1;
    end

end

//  тактовый сигнал
always #10 clk = ~clk;

//  запуск, 200 тактов и стоп
initial begin
    #400;
    $finish;
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

endmodule