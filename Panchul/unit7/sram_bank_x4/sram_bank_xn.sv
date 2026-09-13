//  Memory Bank xN
module      SRAM_BANK_xN #(
    //  параметризуется разрядность номера страницы
    //  с помощью этого параметра пользователь может задать
    //  количество модулей как 2**PAGE_WIDTH
    parameter       PAGE_WIDTH = 2
) (
    input       we,
    input       clk,
    input       [(PAGE_WIDTH - 1) : 0] page,
    input       [3:0] addr,
    input       [5:0] data_in,
    output      reg [5:0] data_out
);

//  индивидуальные сигналы enable для каждого блока
reg     [(2**PAGE_WIDTH - 1) : 0] en;
//  массив выходов каждого модуля
wire     [5:0] dout [0 : (2**PAGE_WIDTH - 1)];

//  процесс декодирования страницы
always @(*) begin : decode
    //  это комб логика
    en = 0;
    en[page] = we;
end

//  блоки нужно сгенерить
generate

    //  счетчик модулей
    genvar m_number;
    for (   m_number = 0; 
            m_number < (2**PAGE_WIDTH); 
            m_number = m_number + 1) begin : sram_blocks
    
        SRAM_16x6 i_sram_16x6(
            .data_in(data_in),
            .addr(addr),
            .clk(clk),
            .data_out(dout[m_number]),
            .we(en[m_number])
        );

    end

endgenerate


//  выходной мультиплексор
always @(*) begin
    data_out = dout[page];
end

endmodule