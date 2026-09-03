`timescale 1ns / 1ns

module testbench;

reg         clk;
reg         [5:0] addr;
wire        [3:0] data_out;
wire        [5:0] addr_out;
integer     i;

//  непосредственно устройство (подключаем к нему сигналы)
rom_parametric dut(
    .clk(clk),
    .addr(addr),
    .data_out(data_out),
    .addr_out(addr_out)
);

initial begin
    clk = 0; // начальное значение клока
    #20;    addr = 6'b000000; // задаем начальный адрес
    for (i = 0; i <= 16; i=i+1) begin
        #20;    addr = addr + 6'b000001; // сдвиг адреса
    end
end

//  тактирование
always #10 clk = ~clk;

//  завершение спустя 380 единиц времени
initial begin
    #380 $finish;
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

endmodule