//  счетчик Грея стиль 2 для указателя записи и
//  логика генерации сигнала full 
module  wptr_full  #(
    parameter   ADDRSIZE = 4
) (
    //  сигнал-команда от асинхронного компаратора указателей
    //  на установку флага full (или снятие)
    //  active-low
    input       afull_n,
    //  валидность данных на входе FIFO
    input       winc,
    //  тактовый сигнал пишущего домена
    input       wclk,
    //  сброс от пишущего домена
    input       wrst_n,

    //  указатель записи
    output      reg [ADDRSIZE-1:0] wptr,
    //  флаг full 
    output      reg wfull  
);

//  выход регистра с бинарным значением
reg     [ADDRSIZE-1:0] wbin;
//  входы регистров бинарного значения и кода Грея
wire    [ADDRSIZE-1:0] wbnext;
wire    [ADDRSIZE-1:0] wgnext;
//  провод между 2 триггерами в синхронизаторе для afull_n 
wire    wfull2;

//  последовательностная логика обновления регистров
//  с бинарным значением и значением в коде Грея
always  @(posedge wclk or negedge wrst_n) begin
    if (    !wrst_n) begin
        wbin <= 0;
        wptr <= 0;
    end
    else begin
        wbin <= wbnext;
        wptr <= wgnext;
    end
end

//  запись = инкремент адреса
//  возможно только при отсутствии флага full и валидности
//  данных на входе FIFO
assign  wbnext = !wfull ? wbin + winc : wbin;
//  след значение кода Грея получается преобразованием след
//  значения бинарного кода
assign  wgnext = (wbnext >> 1) ^ wbnext;

//  синхронизатор из 2 триггеров для afull_n 
//  этот сигнал генерируется асинхронным компаратором
//  при установке он предустанавливает триггеры
//  снятие же флага - синхронное, проходит через синхронизатор
//  синхронизатор нужен, так как снятие синхронно rclk, а не wclk
always  @(posedge wclk or negedge afull_n) begin
    if (    !aempty_n)      {wfull, wfull2} <= 2'b11;
    else                    {wfull, wfull2} <= {wfull2, ~afull_n};
end

endmodule