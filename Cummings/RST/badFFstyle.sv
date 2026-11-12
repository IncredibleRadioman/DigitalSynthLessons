//  схема из 2 триггеров
//  первый - синхронно сбрасываемый
//  второй - ведомый - не сбрасываемый
//  ПЛОХОЙ СТИЛЬ НАПИСАНИЯ
module  badFFstyle(
    //  входной сигнал данных
    input   d,
    //  тактирование и сброс
    input   clk,
    input   rst_n,
    //  выходной сигнал
    output  reg q2
);
//  выход первого триггера
reg         q1;

always  @(posedge clk) begin
    if (    !rst_n) begin
        q1 <= 1'b0;
    end
    else begin
        q1 <= d;
        q2 <= q1;
    end
end

endmodule