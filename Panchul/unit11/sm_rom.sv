//  описание простой ROM-памяти, которая
//  заполняется из файла
module      sm_rom #(
    parameter   SIZE = 4
) (
    //  адрес
    input       [31:0] a,
    //  выход, отдает данные по адресу данных
    output      [31:0] rd
);

//  непосредственно объект, что хранит данные
reg             [31:0] rom [SIZE - 1 : 0];


//  чтение упрощено для модели
assign          rd = rom[a];

//  операция заполнения
initial begin
    $readmemh("program.hex", rom);
end

endmodule