//  Memory Bank x4
module      SRAM_BANK_x4(
    input       we,
    input       clk,
    input       [1:0] page,
    input       [3:0] addr,
    input       [5:0] data_in,
    output      reg [5:0] data_out
);

//  индивидуальные сигналы enable для каждого блока
reg     [3:0] en;
//  выходы каждого модуля (которые далее будут подключены к mux'у для выбора)
wire    [5:0] dout0;
wire    [5:0] dout1;
wire    [5:0] dout2;
wire    [5:0] dout3;

//  декодирование битов page
always @(*) begin : decode
    //  это комб логика
    en = 4'b0000;
    en[page] = 1'b1;
end

//  описание 4 блоков SRAM16x6, из которых и будет строится итоговый банк
//  на 64 бита
SRAM_16x6 M0(
    .data_in(data_in),
    .addr(addr),
    .clk(clk),
    .data_out(dout0),
    .we(en[0])
);

SRAM_16x6 M1(
    .data_in(data_in),
    .addr(addr),
    .clk(clk),
    .data_out(dout1),
    .we(en[1])
);

SRAM_16x6 M2(
    .data_in(data_in),
    .addr(addr),
    .clk(clk),
    .data_out(dout2),
    .we(en[2])
);

SRAM_16x6 M3(
    .data_in(data_in),
    .addr(addr),
    .clk(clk),
    .data_out(dout3),
    .we(en[3])
);

//  выходной мультиплексор
always @(*) begin

    case (page)
        0 : data_out = dout0;
        1 : data_out = dout1;
        2 : data_out = dout2;
        3 : data_out = dout3;
    endcase

end

endmodule