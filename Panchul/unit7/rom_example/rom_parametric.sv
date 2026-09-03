module rom_parametric #(
    parameter DATA_WIDTH = 4,
    parameter ADDR_WIDTH = 6
) (
    input       clk,
    input       [(ADDR_WIDTH - 1) : 0] addr,
    output      [(DATA_WIDTH - 1) : 0] data_out,
    output      [(ADDR_WIDTH - 1) : 0] addr_out
);

//  массив ROM
reg     [DATA_WIDTH - 1 : 0] rom[0 : 2**ADDR_WIDTH - 1];
//  регистр, который хранит текущий адрес
reg     [ADDR_WIDTH - 1 : 0] addr_reg;

//  чтение ROM из файла
initial begin
    $readmemh("rom.txt", rom);
end

//  процесс чтения
always @(   posedge clk) begin
    //  обновление адресного регистра
    addr_reg <= addr;
end

//  выдаем результаты чтения и адрес, откуда данные прочитаны
assign      data_out = rom[addr_reg];
assign      addr_out = addr_reg;
    
endmodule