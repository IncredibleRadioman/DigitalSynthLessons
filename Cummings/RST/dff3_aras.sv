//  aсинхронно сбрасываемый триггер
//  c 2 асинхронными сигналами reset и set
module  sync_resetFFstyle (
    //  вход данных
    input   d,
    //  тактирование и сброс
    input   clk,
    input   rst_n,
    input   set_n,
    //  выход триггера
    output  reg q
);

always  @(posedge clk or negedge rst_n or negedge set_n) begin
    if          (    !rst_n)        q <= 1'b0; // асинхронный reset
    else if     (    !set_n)        q <= 1'b1; // асинхронный set
    else                            q <= d;
end

//  в разделе 5.2 статьи подробно описана проблема с несрабатыванием блока при снятии ресета
//  ниже приведен спец код для симулятора, что исправляет данную проблему

//  synopsys translate_on
always  @(rst_n or set_n) begin
    if (    rst_n && !set_n)        force q = 1;
    else                            release q;
end
//  synopsys translate_off

endmodule