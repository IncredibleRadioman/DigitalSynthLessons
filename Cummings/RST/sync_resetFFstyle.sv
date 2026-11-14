//  синхронно сбрасываемый триггер
module  sync_resetFFstyle (
    //  вход данных
    input   d,
    //  тактирование и сброс
    input   clk,
    input   rst_n,
    //  выход триггера
    output  reg q
);

always  @(posedge clk) begin
    if (    !rst_n)     q <= 1'b0;
    else                q <= d;
end

endmodule