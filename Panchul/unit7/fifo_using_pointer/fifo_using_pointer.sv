//  модуль очереди с использованием указателя
module      fifo_using_pointer #(
    parameter       DATA_WIDTH = 8,
    parameter       PTR_WIDTH = 2
) (
    //  тактирование
    input           clk,
    //  асинхронный сигнал сброса
    input           rst_n,
    //  сигнал записи
    input           push,
    //  сигнал чтения
    input           pop,
    //  данные на запись
    input           [(DATA_WIDTH - 1) : 0] write_data,
    //  прочитанные данные
    output          reg [(DATA_WIDTH - 1) : 0] read_data
);

//  сама очередь
reg                 [(DATA_WIDTH - 1) : 0] fifo[0 : (2**PTR_WIDTH - 1)];
//  указатель на место записи
reg                 [(PTR_WIDTH - 1) : 0] write_pointer;
//  указатель на место чтения
reg                 [(PTR_WIDTH - 1) : 0] read_pointer;

always      @(  posedge clk or negedge rst_n) begin
    if (    !rst_n) begin
        //  по сбросу указатели должны указывать на голову очереди
        write_pointer <= {PTR_WIDTH{1'b0}};
        read_pointer <= {PTR_WIDTH{1'b0}};
    end
    else begin
        if (    push) begin
            //  запись в очередь
            fifo[write_pointer] <= write_data;
            write_pointer <= write_pointer + 1;
        end

        if (    pop) begin
            //  чтение из очереди
            read_data <= fifo[read_pointer];
            read_pointer <= read_pointer + 1;
        end
    end
end

endmodule