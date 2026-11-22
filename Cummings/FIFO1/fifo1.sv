//  модуль верхнего уровня для FIFO Style #1
module fifo1 #(
    //  этот параметр задает размер слов в FIFO
    parameter   DSIZE = 8,
    //  этот параметр задает количество слов в FIFO
    parameter   ASIZE = 4
) (
    //  записывающая сторона
    //  входной сигнал данных
    input       [DSIZE - 1 : 0] wdata,
    //  валидность данных на входе со стороны отправляющего устройства
    input       winc,
    //  тактирование пишушщей стороны
    input       wclk,
    //  сброс со стороны пишущей стороны
    input       wrst_n,
    //  флаг full
    output      wfull,

    //  читающая сторона
    //  готовность принять данные со стороны приемного устройства
    input       rinc,
    //  тактирование читающей стороны
    input       rclk,
    //  сброс со стороны читающей стороны
    input       rrst_n,
    //  выходной сигнал данных
    output      [DSIZE - 1 : 0] rdata,
    //  флаг empty
    output      rempty
);
    
//  бинарные адреса для записи и чтения FIFO (формируются счетчиком Грея)
wire            [ASIZE - 1 : 0] waddr, raddr;
//  указатели чтения и записи в виде кода Грея (с доп битом "круга") и синхронные указатели 
//  проходящие в противоположный домен
wire            [ASIZE - 1 : 0] wptr, rptr, wq2_rptr, rq2_wptr;

//  синхронизатор для указателя чтения, проходящего на пишущую сторону
sync_r2w        sync_r2w(   .wq2_rptr(wq2_rptr),
                            .rptr(rptr),
                            .wclk(wclk),
                            .wrst_n(wrst_n));
    
//  синхронизатор для указателя записи, проходящего на читающую сторону
sync_w2r        sync_w2r(   .rq2_wptr(rq2_wptr),
                            .wptr(wptr),
                            .rclk(rclk),
                            .rrst_n(rrst_n));

//  Dual-Port RAM - это и есть буфер FIFO
//  wclken - разрешает запись в память
fifomem #(DSIZE, ASIZE) fifomem(
                            .rdata(rdata),
                            .wdata(wdata),
                            .waddr(waddr),
                            .raddr(raddr),
                            .wclken(winc),
                            .wfull(wfull),
                            .wclk(wclk));
);

//  счетчик кода Грея для указателя чтения + генератор флага empty
rptr_empty #(ASIZE)     rptr_empty(
                            .rempty(rempty),
                            .raddr(raddr),
                            .rptr(rptr),
                            .rq2_wptr(rq2_wptr),
                            .rinc(rinc),
                            .rclk(rclk),
                            .rrst_n(rrst_n)
);

//  счетчик кода Грея для указателя записи + генератор флага full 
wptr_full #(ASIZE)      wptr_full(
                            .wfull(wfull),
                            .waddr(waddr),
                            .wptr(wptr),
                            .wq2_rptr(wq2_rptr),
                            .winc(winc),
                            .wclk(wclk),
                            .wrst_n(wrst_n)
);

endmodule