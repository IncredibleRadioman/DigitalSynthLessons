//  непосредственно тестирование регистрового файла
`timescale 1ns / 1ns

module      testbench;

//  входные и выходные сигналы
reg     clk;
reg     we;
reg     [1:0] addr;
reg     [3:0] data_in;
wire    [3:0] data_out;

reg_file    #(
    .DATA_WIDTH(4)
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
    addr = 2'b00;
    data_in = 4'b1111;

    #5;

    repeat(3) begin
        #20;
        addr = addr + 2'b01;
    end

    #40;
    we = 1'b0;
    addr = 2'b00;
    data_in = 4'b0000;

    repeat(3) begin
        #20;
        addr = addr + 2'b01;
    end

end

//  тактовый сигнал
always #10 clk = ~clk;

//  запуск, 200 тактов и стоп
initial begin
    #200;
    $finish;
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

endmodule