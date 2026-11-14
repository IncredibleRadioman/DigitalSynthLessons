//  использование асинхронного сброса внутри модуля загружаемого счетчика
module  ctr8sr (
    //  входное значение для загрузки при ld = 1
    input   [7:0] d,
    //  сигнал загрузки d в счетчик
    input   ld,
    //  тактирование и сброс
    input   clk,
    input   rst_n,
    //  выходное значение счетчика
    output  reg [7:0] q,
    //  сигнал переноса (когда число превысило 255)
    output  reg co
);

always  @(posedge clk or negedge rst_n) begin
    if (!rst_n)     {co, q} <= 9'b0; // асинхронный сброс
    else if (ld)    {co, q} <= d; // синхронная загрузка
    else            {co, q} <= q + 1'b1; // синхронный инкремент
end

endmodule