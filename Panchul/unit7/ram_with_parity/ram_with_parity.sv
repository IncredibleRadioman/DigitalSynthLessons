//  параметризованное ОЗУ с битом контроля четности
module      ram_with_parity #(
    parameter       DATA_WIDTH = 8,
    parameter       ADDR_WIDTH = 6
) (
    input       [(DATA_WIDTH - 1) : 0] data_in,
    input       [(ADDR_WIDTH - 1) : 0] addr,
    input       we,
    input       clk,
    output      [(DATA_WIDTH - 1) : 0] data_out,
    output      [(ADDR_WIDTH - 1) : 0] addr_out,
    output      parity_error
);

//  массив памяти 
//  разрядность +1 для бита четности
reg     [(DATA_WIDTH) : 0] ram[0 : 2**ADDR_WIDTH - 1];
//  регистр, который хранит адрес регистра, с которого в данный момент выполняется чтение
reg     [(ADDR_WIDTH - 1) : 0] addr_reg;
//  выход памяти
wire    [(DATA_WIDTH) : 0] ram_out;

always @(posedge clk) begin

    if (    we) begin
        //  операция записи
        //  записываем сами данные и бит четности
        ram[addr] <= {^data_in ,data_in};
    end

    //  обновляем регистр, который хранит текущий адрес (синхронно по тактовому сигналу)
    addr_reg <= addr;

end

//  операция чтения
assign      ram_out = ram[addr_reg];

//  вычленяем полезные данные
assign      data_out = ram_out[(DATA_WIDTH - 1) : 0];
//  выводим адрес, данные с которого выдаются на выход
assign      addr_out = addr_reg;

//  ошибка четности
assign      parity_error = ( (^data_out) != ram_out[DATA_WIDTH] );

endmodule