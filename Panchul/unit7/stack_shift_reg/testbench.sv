`timescale 1ns / 1ns

module      testbench;

//  регистры для теста
reg         clk;
reg         reset;
reg         push;
reg         pop;
reg         [7:0] write_data;
wire        [7:0] read_data;

stack_shift_reg #(
    .STACK_SIZE(4),
    .DATA_WIDTH(8)
) dut (
    .clk(clk),
    .reset(reset),
    .push(push),
    .pop(pop),
    .write_data(write_data),
    .read_data(read_data)
);

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

initial begin
    //  начальные значения
    clk = 1;
    reset = 1;
    push = 1;
    pop = 0;
    write_data = 8'b00000000;

    //  запись
    #20;    write_data = 8'b00000001;
    #10;    reset = 0;
    #20;    write_data = 8'b00000010;
    #20;    write_data = 8'b00000011;
    #20;    write_data = 8'b00000100;
    #20;    write_data = 8'b00000101;
    #20;    write_data = 8'b00000110;
    push = 0;
    pop = 1;
    #20;    write_data = 8'b00000111;
    #20;    write_data = 8'b00001000;
    #20;    write_data = 8'b00001001;
    #20;    write_data = 8'b00001011;

end

//  тактирование
always  #10 clk = ~clk;

//  окончание
initial begin
    #220;
    $finish;
end

endmodule