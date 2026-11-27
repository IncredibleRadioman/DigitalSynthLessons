//  счетчик Грея стиль 2 для указателя чтения и
//  логика генерации сигнала empty
module  rptr_empty #(
    parameter   ADDRSIZE = 4
) (
    //  сигнал-команда от асинхронного компаратора указателей
    //  на установку флага empty (или снятие)
    //  active-low
    input       aempty_n,
    //  готовность приемника забрать данные из FIFO
    input       rinc,
    //  тактовый сигнал читающего домена
    input       rclk,
    //  сброс от читающего домена
    input       rrst_n,

    //  указатель чтения
    output      reg [ADDRSIZE-1:0] rptr,
    //  флаг empty
    output      reg rempty 
);

//  выход регистра с бинарным значением
reg     [ADDRSIZE-1:0] rbin;
//  входы регистров бинарного значения и кода Грея
wire    [ADDRSIZE-1:0] rbnext;
wire    [ADDRSIZE-1:0] rgnext;
//  провод между 2 триггерами в синхронизаторе для aempty_n
wire    rempty2;

//  последовательностная логика обновления регистров
//  с бинарным значением и значением в коде Грея
always  @(posedge rclk or negedge rrst_n) begin
    if (    !rrst_n) begin
        rbin <= 0;
        rptr <= 0;
    end
    else begin
        rbin <= rbnext;
        rptr <= rgnext;
    end
end

//  чтение = инкремент адреса
//  возможно только при отсутствии флага empty и готовности
//  приемника забрать данные
assign  rbnext = !rempty ? rbin + rinc : rbin;
//  след значение кода Грея получается преобразованием след
//  значения бинарного кода
assign  rgnext = (rbnext >> 1) ^ rbnext;

//  синхронизатор из 2 триггеров для aempty_n
//  этот сигнал генерируется асинхронным компаратором
//  при установке он предустанавливает триггеры
//  снятие же флага - синхронное, проходит через синхронизатор
//  синхронизатор нужен, так как снятие синхронно wclk, а не rclk
always  @(posedge rclk or negedge aempty_n) begin
    if (    !aempty_n)      {rempty, rempty2} <= 2'b11;
    else                    {rempty, rempty2} <= {rempty2, ~aempty_n};
end

endmodule