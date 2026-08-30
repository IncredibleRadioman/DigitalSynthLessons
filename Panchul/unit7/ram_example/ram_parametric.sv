//  параметризованное ОЗУ
module      ram_parametric #(
    parameter   DATA_WIDTH = 4,
    parameter   ADDR_WIDTH = 6
) (
    input       [(DATA_WIDTH - 1) : 0] data_in,
    input       [(ADDR_WIDTH - 1) : 0] addr,
    input       we,
    input       clk,
    output      [(DATA_WIDTH - 1) : 0] data_out,
    output      [(ADDR_WIDTH - 1) : 0] addr_out
);

//  массив памяти 
reg     [(DATA_WIDTH - 1) : 0] ram[0 : 2**ADDR_WIDTH - 1];
//  регистр, который хранит адрес регистра, с которого в данный момент выполняется чтение
reg     [(ADDR_WIDTH - 1) : 0] addr_reg;

always @(posedge clk) begin

    if (    we) begin
        //  операция записи
        ram[addr] <= data_in;
    end

    //  обновляем регистр, который хранит текущий адрес (синхронно по тактовому сигналу)
    addr_reg <= addr;

end

//  операция чтения
assign      data_out = ram[addr_reg];
//  выводим адрес, данные с которого выдаются на выход
assign      addr_out = addr_reg;


endmodule