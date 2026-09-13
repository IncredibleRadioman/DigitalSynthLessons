//  реализация очереди с помощью сдвигового регистра
module      fifo_shift_reg #(
    parameter       DATA_WIDTH = 8,
    parameter       FIFO_SIZE = 4
) (
    //  сигнал тактирования
    input       clk,
    //  сигнал синхронного сброса
    input       reset,
    //  сигнал записи в стек
    input       push,
    //  сигнал чтения из стека
    input       pop,
    //  данные на входе стека
    input       [(DATA_WIDTH - 1) : 0] write_data,
    //  данные на выходе стека
    output      reg [(DATA_WIDTH - 1) : 0] read_data
);

//  непосредственно очередь
reg             [(DATA_WIDTH - 1) : 0] fifo[0 : (FIFO_SIZE - 1)];

integer         i;

always  @(posedge clk) begin
    //  синхронный сброс
    if (    reset) begin
        for (   i=0;    i < FIFO_SIZE;  i = i + 1) begin
            fifo[i] <= {DATA_WIDTH{1'b0}};
        end
    end
    else if (   push) begin //  сигнал записи
        //  запись осуществляется всегда в конец очереди
        //  сначала сдвигаем очередь вниз
        for (   i = 0; i < (FIFO_SIZE - 1) ; i = i + 1)
            fifo[i] <= fifo[i + 1];
        //  теперь пишем в самый конец
        fifo[FIFO_SIZE - 1] <= write_data;
    end
    else if (   pop) begin // сигнал чтения
        //  чтение читает всегда голову очереди
        read_data <= fifo[0];
        //  сдвигаем очередь вниз
        for (   i = 0; i < (FIFO_SIZE - 1) ; i = i + 1)
            fifo[i] <= fifo[i + 1];
    end
end

endmodule