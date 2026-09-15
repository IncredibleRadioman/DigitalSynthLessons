//  модуль 2-портовой RAM памяти с раздельным тактированием портов
module  dual_port_RAM #(
    parameter   DATA_WIDTH = 8,
    parameter   ADDR_WIDTH = 4
) (
    input       we,
    //  порт записи
    input       clk1,
    input       [(DATA_WIDTH - 1) : 0] data_in,
    input       [(ADDR_WIDTH - 1) : 0] write_addr,
    //  порт чтения
    input       clk2,
    input       [(ADDR_WIDTH - 1) : 0] read_addr,
    output      reg [(DATA_WIDTH - 1) : 0] data_out
);

//  непосредственно массив памяти
reg     [(DATA_WIDTH - 1) : 0] dp_ram [0 : (2**ADDR_WIDTH - 1)];

//  запись или чтение осуществляются синхронно
always @(posedge clk1) begin
    
    if (    we)
        //  для записи должен быть поднят сигнал разрешения записи
        dp_ram[write_addr] <= data_in;
end

always @(posedge clk2) begin
    data_out <= dp_ram[read_addr];
end

endmodule