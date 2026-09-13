//  дешифратор для 7-сегментного индикатора с точкой
//  в виде ROM-памяти
module      rom_sevenseg_point (
    input       [3:0] a,
    //  clock
    input       clk,
    //  сигнал точки
    input       point,
    //  сигнал гашения
    input       reset,
    output      [7:0] y
);

//  непосредственно память
reg     [7:0] rom_data [0 : 2**5-1];

//  адрес
reg     [4:0] addr;

integer i;
integer p;
reg     [7:0] data;

function [7:0] decode;
    input   [3:0] digit;
    input   point;
    reg     [6:0] segments;
    begin
        case (digit)
            0 :         segments = 7'b1110111;
            1 :         segments = 7'b0100100;
            2 :         segments = 7'b1101011;
            3 :         segments = 7'b1101101;
            4 :         segments = 7'b0111100;
            5 :         segments = 7'b1011101;
            6 :         segments = 7'b1011111;
            7 :         segments = 7'b1100100;
            8 :         segments = 7'b1111111;
            9 :         segments = 7'b1111101;
            default :   segments = 7'b0000000;
        endcase

        decode = {segments, point};
    end
endfunction

//  заполнение памяти
initial begin
    for (   i = 0; i <= (2**4 - 1); i = i + 1) begin
        for (   p = 0; p <= 1; p = p + 1) begin
            data = decode(i[3:0], p[0]);
            rom_data[{i[3:0], p[0]}] = data;
        end
    end
end

//  синхронно обновляю адрес
always @(posedge clk) begin
    addr <= {a, point};
end

//  выдача результата
assign  y = (reset == 1'b1) ? 8'b00000000 : rom_data[addr];

endmodule