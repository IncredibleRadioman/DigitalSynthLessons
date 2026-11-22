//  модуль счетчика кода Грея для указателя чтения +
//  генератор флага full 
module  wptr_full #(
    parameter   ADDRSIZE = 4
) (
    //  синхронное значение указателя чтения
    input       wq2_rptr,
    //  сигнал валидности данных со стороны отправляющего устройства
    input       winc,
    //  тактирование со стороны пишущей стороны
    input       wclk,
    //  сброс со стороны пишущей стороны
    input       wrst_n,
    //  флаг full
    output      reg wfull,
    //  бинарный указатель записи для адресации FIFO
    output      [ADDRSIZE-1 : 0] waddr,
    //  указатель записи в виде кода Грея с доп битом "круга"
    output      reg [ADDRSIZE : 0] wptr
);

//  текущее значение бинарного адреса (тоже с доп битом)
reg     [ADDRSIZE : 0] wbin;
//  след значения счетчика Грея и выход инкрементатора
reg     [ADDRSIZE : 0] wgraynext, wbinnext;

//  счетчик кода Грея в стиле 2
//  синхронное обновление текущих величин
always  @(posedge wclk or negedge wrst_n) begin
    if (    !wrst_n)        {wbin, wptr} <= 0;
    else                    {wbin, wptr} <= {wbinnext, wgraynext};
end

//  бинарный адрес записи = значению wbin без бита "круга"
assign  waddr = wbin[ADDRSIZE - 1 : 0];

//  инкрементатор обновляет значение, если FIFO не заполнено
//  и данные со стороны пишущего устройства валидны
assign  wbinnext = wbin + (winc & ~wfull);

//  преобразование бинарного числа в код Грея
assign  wgraynext = (wbinnext >> 1) ^ wbinnext;

//  генерация флага full 
//  сравнение указателя записи (след значения на новый такт)
//  и синхронного значения указателя чтения
//  произойдет комбинационно (немедленно)
assign wfull_val = 
    (wgraynext  == {~wq2_rptr[ADDRSIZE : ADDRSIZE - 1], wq2_rptr[ADDRSIZE - 2 : 0]});

//  снятие флага full - строго синхронное
always  @(posedge wclk or negedge wrst_n) begin
    if (    !wrst_n)        wfull <= 1'b0;
    else                    wfull <= wfull_val;
end

endmodule