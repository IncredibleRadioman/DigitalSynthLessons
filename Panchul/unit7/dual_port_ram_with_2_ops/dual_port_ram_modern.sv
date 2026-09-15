//  двухпортовая RAM-память
//  оба порта позволяют выполнять и запись, и чтение
module          dual_port_RAM #(
    parameter       DATA_WIDTH = 8,
    parameter       ADDR_WIDTH = 4
) (
    input           clk,
    //  ПОРТ 1
    //  сигнал разрешения записи
    input           we1,
    //  входные данные
    input           [(DATA_WIDTH - 1) : 0] data1_in,
    //  адрес записи
    input           [(ADDR_WIDTH - 1) : 0] addr1,
    //  выходные данные
    output          reg [(DATA_WIDTH - 1) : 0] data1_out,
    

    //  ПОРТ 2
    //  сигнал разрешения записи
    input           we2,
    //  входные данные
    input           [(DATA_WIDTH - 1) : 0] data2_in,
    //  адрес записи/чтения
    input           [(ADDR_WIDTH - 1) : 0] addr2,
    //  выходные данные
    output          reg [(DATA_WIDTH - 1) : 0] data2_out,
    
    //  ошибка коллизии
    output          collision_error
);

//  непосредственно массив памяти
reg     [(DATA_WIDTH - 1) : 0] dp_ram [0 : (2**ADDR_WIDTH - 1)];

//  запись или чтение осуществляется синхронно
always @(   posedge clk) begin

    //  ПОРТ    1
    //  запись (с арбитражем)
    if (    we1) begin
        //  при записи нужен bypass
        dp_ram[addr1] <= data1_in;
        data1_out <= data1_in;
    end
    else    begin
        //  только чтение 
        data1_out <= dp_ram[addr1];
    end
    


    //  ПОРТ    2
    if (    we2) begin
        dp_ram[addr2] <= data2_in;
        data2_out <= data2_in;
    end
    else    begin
    //  чтение 
    data2_out <= dp_ram[addr2];
    end

end

assign collision_error = (addr1 == addr2) && (we1 || we2);

endmodule