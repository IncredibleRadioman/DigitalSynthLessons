//  умножитель 8x8 на базе ПЗУ
module      rom_mult_8x8 (
    input       [2:0] a,
    input       [2:0] b,
    input       clk,
    output      [5:0] y
);

integer i;
integer j;
reg [5:0] addr_gen;

//  сама память
reg         [5:0] rom_data[(2**6 - 1):0];

//  a и b формируют адрес
reg        [5:0] addr;

initial begin
    //  заполнение ячеек памяти


    for (   i = 0; i <= (2**3 - 1) ; i = i + 1) begin
        for (   j = 0; j <= (2**3 - 1); j = j + 1 ) begin
            addr_gen = {j[2:0], i[2:0]};
            rom_data[addr_gen] = i * j;
        end
    end

end

//  выдача выхода
always  @(posedge clk) begin
    addr <= {b, a};
end

assign  y = rom_data[addr];

endmodule