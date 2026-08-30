`timescale 1ns / 1ns

//  тестирование простого 4И в виде ROM-таблицы
module  testbench;

reg     [3:0] x;
wire    y;

rom_and4    dut(
    .x(x),
    .y(y)
);

initial begin
    x = 4'b0000;
    repeat (15) begin
        //  пробегаем по всем вариантам
        #10;
        x = x + 4'b0001;
    end
end

initial begin
    #160;
    $finish;
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end



endmodule