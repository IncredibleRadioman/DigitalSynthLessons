//  ROM-память для генерации синуса
module      rom_sinx #(
    parameter       X_WIDTH = 10,
    parameter       Y_WIDTH = 8
) (
    input       [(X_WIDTH - 1) : 0] x,
    input       clk,
    output      [(Y_WIDTH - 1) : 0] y
);

localparam real PI = 3.141592653589793;

//  сама память
reg         [(Y_WIDTH - 1) : 0] rom_data[(2**X_WIDTH - 1):0];
//  регистр для хранения адреса чтения
reg         [(X_WIDTH - 1) : 0] addr_reg;

integer     i;
integer     arg;

initial begin
    for (   i = 0; i <= (2**X_WIDTH - 1) ; i = i + 1) begin
        arg = $rtoi($sin(2.0 * PI * i / $itor(2**X_WIDTH))  *  $itor(2**(Y_WIDTH - 1) - 1));
        rom_data[i] = arg[(Y_WIDTH - 1) : 0];
    end
end

//  выдача выхода
always  @(posedge clk) begin
    addr_reg <= x;
end

assign  y = rom_data[addr_reg];

endmodule