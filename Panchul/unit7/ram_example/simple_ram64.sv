//  реализация простого ОЗУ на 64 элемента по 4 бита
module      simple_ram64(
    input       [3:0] data_in,
    input       [5:0] addr,
    input       we,
    input       clk,
    output      [3:0] data_out,
    output      [5:0] addr_out
);

//  массив памяти 
reg     [3:0] ram[0 : 2**6 - 1];
//  регистр, который хранит адрес регистра, с которого в данный момент выполняется чтение
reg     [5:0] addr_reg;

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