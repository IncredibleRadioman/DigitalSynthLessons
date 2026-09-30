//  тестирование КА Мили
`timescale 1ns / 1ns

module      testbench;

//  сигналы для подключения к модулю
reg         clk;
reg         reset_n;
reg         enable;
reg         a;
wire        y;
wire        [1:0] state;

//  подключаемся к устройству
fsm_lab8_4 dut(
    .clk(clk),
    .reset_n(reset_n),
    .enable(enable),
    .a(a),
    .y(y)
);

//  подключаемся к внутреннему reg устройства
assign  state = dut.state;

initial begin
    clk = 1;
    reset_n = 0;
    enable = 1;
    a = 1;
    #10; reset_n = 1;
    repeat (4) begin
        enable = 0;
        #20; a = 0;
        enable = 1;
        #20; a = 1;
        #20;
    end
end

//  тактирование
always begin
    #10;
    clk = ~clk;
end

initial begin
    #250;
    $finish;
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

endmodule