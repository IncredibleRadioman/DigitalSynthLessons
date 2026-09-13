//  кирпичик регистрового файла - регистр
module register #(
    parameter DATA_WIDTH = 4
) (
    input       ena,
    input       clk,
    input       [DATA_WIDTH - 1 : 0] d,
    output      reg [DATA_WIDTH - 1 : 0] q
);


always @(posedge clk) begin
    if (ena)
        q <= d;
end

endmodule

//  регистровый файл на 2^ADDR_WIDTH регистров
module      reg_file_param #(
    //  ширина данных
    parameter       DATA_WIDTH = 32,
    //  ширина адресной шины - она задает количество регистров
    parameter       ADDR_WIDTH = 5
) (
    input       clk,
    input       we,
    input       [(ADDR_WIDTH - 1) : 0] addr,
    input       [(DATA_WIDTH - 1) : 0] data_in,
    output      reg [(DATA_WIDTH - 1) : 0] data_out
);

//  write_en для каждого регистра
reg     [(2**ADDR_WIDTH - 1) : 0] w_we;
//  выходы каждого регистра в виде массива
wire    [(DATA_WIDTH - 1) : 0] reg_out[0 : (2**ADDR_WIDTH - 1)];

//  адрес, откуда читают
reg     [(ADDR_WIDTH - 1) : 0] addr_reg;

//  запись
//  управление write_enable каждого
always  @(*) begin
    w_we = 0;
    if (    we) begin
        w_we[addr] = 1'b1;
    end
end

always  @(posedge clk) begin
    addr_reg <= addr;
end

//  управление выходом
always  @(*) begin
    data_out = reg_out[addr_reg];
end

//  генерация и соединение регистров
generate
    genvar i;
    for (   i = 0;
            i < (2**ADDR_WIDTH);
            i = i + 1)
    begin : reg_blocks
        register #(
            .DATA_WIDTH(DATA_WIDTH)
        ) i_register (
            .ena(w_we[i]),
            .clk(clk),
            .d(data_in),
            .q(reg_out[i])
        );
    end
endgenerate


endmodule