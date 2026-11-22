//  модуль синхронизатора для указателя записи
module  sync_w2r #(
    parameter   ADDRSIZE = 4
) (
    //  текущее значение указателя, приходящее от пишущего домена
    input       [ADDRSIZE:0] wptr,
    //  тактирование синхронизатора - от читающего домена
    input       rclk,
    //  сброс синхронизатора - от читающего домена
    input       rrst_n,
    //  синхронное значение указателя записи
    output      reg [ADDRSIZE : 0] rq2_wptr
);

//  провод между 2 регистрами
reg             [ADDRSIZE : 0] rq1_wptr;

//  процесс синхронного прохождения указателя в читающий домен
always  @(posedge rclk or negedge rrst_n) begin
    if (    !rrst_n)        {rq2_wptr, rq1_wptr} <= 0;
    else                    {rq2_wptr, rq1_wptr} <= {rq1_wptr, wptr};
end

endmodule