//  модуль синхронизатора для указателя чтения
module  sync_r2w #(
    parameter   ADDRSIZE = 4
) (
    //  текущее значение указателя, приходящее от читающего домена
    input       [ADDRSIZE:0] rptr,
    //  тактирование синхронизатора - от пишущего домена
    input       wclk,
    //  сброс синхронизатора - от пишущего домена
    input       wrst_n,
    //  синхронное значение указателя чтения
    output      reg [ADDRSIZE : 0] wq2_rptr
);

//  провод между 2 регистрами
reg             [ADDRSIZE : 0] wq1_rptr;

//  процесс синхронного прохождения указателя в пишущий домен
always  @(posedge wclk or negedge wrst_n) begin
    if (    !wrst_n)        {wq2_rptr, wq1_rptr} <= 0;
    else                    {wq2_rptr, wq1_rptr} <= {wq1_rptr, rptr};
end

endmodule