//  ОЗУ с возможностью записать сразу 2 ячейки
module      ram_byteena #(
    parameter   DATA_WIDTH = 4,
    parameter   ADDR_WIDTH = 6
) (
    input       [(2 * DATA_WIDTH - 1) : 0] data_in,
    input       [(ADDR_WIDTH - 1) : 0] addr,
    //  сигнал позволяет записать сразу 2 ячейки (или только старшую)
    //  он и является сигналом разрешения записи
    //  сигнал строго унарный!!!
    input       [1:0] byteena,
    input       clk,
    output      [(DATA_WIDTH - 1) : 0] data_out,
    output      [(ADDR_WIDTH - 1) : 0] addr_out
);

//  массив памяти (нечетные адреса)
reg     [(DATA_WIDTH - 1) : 0] ram_odd[0 : 2**(ADDR_WIDTH - 1) - 1];
//  массив памяти (четные адреса)
reg     [(DATA_WIDTH - 1) : 0] ram_even[0 : 2**(ADDR_WIDTH - 1) - 1];

//  регистр, который хранит адрес регистра, с которого в данный момент выполняется чтение
reg     [(ADDR_WIDTH - 1) : 0] addr_reg;

//  адрес в каждом из банков
wire    [(ADDR_WIDTH - 2) : 0] bank_addr;
assign  bank_addr = addr[(ADDR_WIDTH - 1) : 1];

wire    [(ADDR_WIDTH - 2) : 0] bank_addr_rd;
assign  bank_addr_rd = addr_out[(ADDR_WIDTH - 1) : 1];

always @(posedge clk) begin

    if (    byteena == 2'b10) begin
        //  запись 16 бит
        ram_odd[bank_addr] <= data_in[(2 * DATA_WIDTH - 1) : DATA_WIDTH];
        ram_even[bank_addr] <= data_in[(DATA_WIDTH - 1) : 0];
    end

    if (    byteena == 2'b01) begin
        //  запись 8 бит
        if (    addr[0])
            ram_odd[bank_addr] <= data_in[(DATA_WIDTH - 1) : 0];
        else
            ram_even[bank_addr] <= data_in[(DATA_WIDTH - 1) : 0];
    end

    //  обновляем регистр, который хранит текущий адрес (синхронно по тактовому сигналу)
    addr_reg <= addr;

end


//  операция чтения
assign      data_out = addr_reg[0] ? ram_odd[bank_addr_rd] : ram_even[bank_addr_rd];
//  выводим адрес, данные с которого выдаются на выход
assign      addr_out = addr_reg;

endmodule