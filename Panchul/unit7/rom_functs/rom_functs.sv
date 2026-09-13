//  ROM-память для генерации sinx, sinx / x, gauss, exp
module      rom_functs #(
    parameter       X_WIDTH = 10,
    parameter       Y_WIDTH = 8
) (
    input       [(X_WIDTH - 1) : 0] x,
    input       clk,
    //  выходы для каждой из функции
    output      [(Y_WIDTH - 1) : 0] y_sinx,
    output      [(Y_WIDTH - 1) : 0] y_sinx_x,
    output      [(Y_WIDTH - 1) : 0] y_gauss,
    output      [(Y_WIDTH - 1) : 0] y_exp
);

localparam real PI = 3.141592653589793;

//  сама память
reg         [(Y_WIDTH - 1) : 0] rom_data_sinx[(2**X_WIDTH - 1):0];
reg         [(Y_WIDTH - 1) : 0] rom_data_sinx_x[(2**X_WIDTH - 1):0];
reg         [(Y_WIDTH - 1) : 0] rom_data_gauss[(2**X_WIDTH - 1):0];
reg         [(Y_WIDTH - 1) : 0] rom_data_exp[(2**X_WIDTH - 1):0];


//  регистр для хранения адреса чтения
reg         [(X_WIDTH - 1) : 0] addr_reg;

integer     i;
integer     arg_sinx;
integer     arg_sinx_x;
integer     arg_gauss;
integer     arg_exp;

initial begin
    for (   i = 0; i <= (2**X_WIDTH - 1) ; i = i + 1) begin
        //  заполнение sinx
        arg_sinx = $rtoi($sin(2.0 * PI * i / $itor(2**X_WIDTH))  *  $itor(2**(Y_WIDTH - 1) - 1));
        rom_data_sinx[i] = arg_sinx[(Y_WIDTH - 1) : 0];
        //  заполнение sinx/x
        if (    i == 0) begin
            arg_sinx_x = $rtoi(1.0  *  $itor(2**(Y_WIDTH - 1) - 1));
        end
        else begin
            arg_sinx_x = $rtoi($sin(2.0 * PI * i / $itor(2**X_WIDTH)) / $itor(i) );
        end
        rom_data_sinx_x[i] = arg_sinx_x[(Y_WIDTH - 1) : 0];

        //  заолнение функции Гаусса
        arg_gauss = $rtoi(  $exp(-1.0 * i * i / 2.0) * $itor(2**(Y_WIDTH - 1) - 1));
        rom_data_gauss[i] = arg_gauss[(Y_WIDTH - 1) : 0];
        //  заполнение экспоненты
        arg_exp = $rtoi(  $exp(1.0 * i / $itor(2**X_WIDTH)) / $exp(1.0) * $itor(2**(Y_WIDTH - 1) - 1));
        rom_data_exp[i] = arg_exp[(Y_WIDTH - 1) : 0];
    end
end

//  выдача выхода
always  @(posedge clk) begin
    addr_reg = x;
end

assign  y_sinx = rom_data_sinx[addr_reg];
assign  y_sinx_x = rom_data_sinx_x[addr_reg];
assign  y_gauss = rom_data_gauss[addr_reg];
assign  y_exp = rom_data_exp[addr_reg];

endmodule