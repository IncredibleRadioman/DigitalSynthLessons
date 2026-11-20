//  поведенческая модель FIFO
//  НЕ ДЛЯ СИНТЕЗА
module  beh_fifo #(
    parameter   DSIZE = 8,
    parameter   ASIZE = 5,
    parameter   MEMDEPTH = 1 << ASIZE
) (
    //  порт данных для записи
    input       [DSIZE - 1 : 0] wdata,
    //  сигнал валидности данных на входе (от отправителя)
    input       winc,
    //  тактирование порта записи
    input       wclk,
    //  сброс порта записи (сбросит указатель записи)
    input       wrst_n,
    
    //  сигнал готовности приемника на выходе (от приемной стороны)
    input       rinc,
    //  тактирование порта чтения
    input       rclk,
    //  сброс со стороны порта чтения (сбросит указатель чтения)
    input       rrst_n,
    //  выходной порт данных
    output      [DSIZE - 1 : 0] rdata,
    //  сигнал переполнения FIFO
    output      wfull,
    //  сигнал опустошения FIFO
    output      rempty
);

//  указатель записи + 3 провода - это указатель чтения, проходящий на сторону 
//  записи (для сравнения указателей, короче: синхронизированный указатель чтения на отправл стороне)
//  он "отстает" от реального => переполнение FIFO не произойдет 
reg     [ASIZE : 0] wptr, wrptr1, wrptr2, wrptr3;
//  указатель чтения + 3 провода - это указатель записи, проходящий на сторону
//  чтения (по аналогии с проводами выше)
reg     [ASIZE : 0] rptr, rwptr1, rwptr2, rwptr3;

//  старший бит - "номер круга" указателей, так можно
//  отличить full и empty

//  непосредственно FIFO
reg     [DSIZE - 1 : 0] ex_mem [0 : MEMDEPTH - 1];


//  процесс записи
always @(posedge wclk or negedge wrst_n) begin
    if (    !wrst_n)            wptr <= 0;
    else if (   winc && !wfull) begin
        //  запись в FIFO возможна только если оно не заполнено
        //  и данные на входе валидны
        ex_mem[wptr[ASIZE-1:0]] <= wdata;
        wptr                    <= wptr + 1;
    end
end

always @(posedge wclk or negedge wrst_n) begin
    //  процесс прохождения указателя чтения на сторону отправителя
    if (    !wrst_n)    {wrptr3, wrptr2, wrptr1} <= 0;
    else                {wrptr3, wrptr2, wrptr1} <= {wrptr2, wrptr1, rptr};
end

always @(posedge rclk or negedge rrst_n) begin
    if (    !rrst_n)                rptr <= 0;
    //  чтение из FIFO возможно только если оно не пустое
    //  и приемник готов забрать данные
    else if (   rinc && !rempty)    rptr <= rptr + 1;
end

always @(posedge rclk or negedge rrst_n) begin
    //  процесс прохождения указателя записи на сторону приемника  
    if (    !rrst_n)    {rwptr3, rwptr2, rwptr1} <= 0;
    else                {rwptr3, rwptr2, rwptr1} <= {rwptr2, rwptr1, wptr};
end

//  на выходе данные всегда выставлены по текущему указателю чтения
assign  rdata = ex_mem[rptr[ASIZE - 1 : 0]];
//  FIFO пустое когда указатели равны
assign  rempty = (rptr == rwptr3);
//  FIFO заполнено, когда указатели равны кроме старших битов
assign  wfull = (   (wptr[ASIZE - 1 : 0] == wrptr3[ASIZE - 1 : 0]) &&
                    (wptr[ASIZE] != wrptr3[ASIZE]));

endmodule;