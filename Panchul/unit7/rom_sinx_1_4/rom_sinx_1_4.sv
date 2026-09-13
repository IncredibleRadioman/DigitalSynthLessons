//  ROM-память для генерации синуса
module      rom_sinx_1_4 #(
    //  разрядность адреса
    parameter       X_WIDTH = 10,
    parameter       Y_WIDTH = 8
) (
    input       [(X_WIDTH - 1) : 0] x,
    input       clk,
    output      [(Y_WIDTH - 1) : 0] y
);

localparam real PI = 3.141592653589793;

//  сама память - поскольку 1/4 синуса только, то в 4 раза меньше
reg         [(Y_WIDTH - 1) : 0] rom_data[(2**(X_WIDTH-2) - 1):0];

//  временное хранение X_WIDTH-битного результата
reg         [(X_WIDTH - 1) : 0] addr_reg_temp;

//  регистр для хранения адреса чтения
wire         [(X_WIDTH - 3) : 0] addr_reg;

integer     i;
integer     arg;

initial begin
    //  заполняем эту четверть синуса
    for (   i = 0; i <= (2**(X_WIDTH-2) - 1) ; i = i + 1) begin
        arg = $rtoi($sin(2.0 * PI * i / $itor(2**X_WIDTH))  *  $itor(2**(Y_WIDTH - 1) - 1));
        rom_data[i] = arg[(Y_WIDTH - 1) : 0];
    end
end

//  выдача выхода
always  @(posedge clk) begin
    if (    x <= (2**(X_WIDTH-2) - 1)) begin
        //  1 четверть
        addr_reg_temp <= x;
    end
    else if (   x <= (2**(X_WIDTH-1) - 1)) begin
        //  2 четверть
        addr_reg_temp <= ((2**(X_WIDTH-1) - 1) - x);
    end
    else if (   x <= (2**(X_WIDTH-1) + (2**(X_WIDTH-2) - 1))) begin
        //  3 четверть
        addr_reg_temp <= (x - (2**(X_WIDTH-1)));
    end
    else begin
        //  4 четверть
        addr_reg_temp <= ((2**(X_WIDTH) - 1) - x);
    end

    
end

assign  addr_reg = addr_reg_temp[X_WIDTH - 3 : 0];
assign  y = (x <= (2**(X_WIDTH-1) - 1)) ? rom_data[addr_reg] : -rom_data[addr_reg];

endmodule