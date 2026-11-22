//  модуль счетчика кода Грея для указателя записи +
//  генератор флага empty
module  rptr_empty #(
    parameter   ADDRSIZE = 4
) (
    //  синхронизированный указатель записи
    input       [ADDRSIZE : 0] rq2_wptr,
    //  сигнал готовности приемного устройства забрать данные
    input       rinc,
    //  тактирование со стороны читающей стороны
    input       rclk,
    //  сброс со стороны читающей стороны
    input       rrst_n,
    //  флаг empty
    output      reg rempty,
    //  бинарный указатель чтения для адресации FIFO
    output      [ADDRSIZE-1 : 0] raddr,
    //  указатель чтения в виде кода Грея с доп битом "круга"
    output      reg [ADDRSIZE : 0] rptr
);

//  текущее значение бинарного адреса (тоже с доп битом)
reg     [ADDRSIZE : 0] rbin;
//  след значения счетчика Грея и выход инкрементатора
reg     [ADDRSIZE : 0] rgraynext, rbinnext;

//  счетчик кода Грея в стиле 2
//  синхронное обновление текущих величин
always  @(posedge rclk or negedge rrst_n) begin
    if (    !rrst_n)        {rbin, rptr} <= 0;
    else                    {rbin, rptr} <= {rbinnext, rgraynext};
end

//  бинарный адрес чтения = значению rbin без бита "круга"
assign  raddr = rbin[ADDRSIZE - 1 : 0];

//  инкрементатор обновляет значение, если FIFO не пустое
//  и приемное устройство готово забрать данные
assign  rbinnext = rbin + (rinc & ~rempty);

//  преобразование бинарного числа в код Грея
assign  rgraynext = (rbinnext >> 1) ^ rbinnext;

//  генерация флага empty
//  сравнение указателя чтения (след значения на новый такт)
//  и синхронного значения указателя записи
//  произойдет комбинационно (немедленно)
assign  rempty_val = (rgraynext == rq2_wptr);

//  снятие флага empty - строго синхронное
always  @(posedge rclk or negedge rrst_n) begin
    if (    !rrst_n)        rempty <= 1'b1;
    else                    rempty <= rempty_val;
end

endmodule