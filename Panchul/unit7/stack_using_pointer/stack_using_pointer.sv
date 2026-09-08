//  модуль стека с использованием указателя

module      stack_using_pointer #(
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

//  сам стек
reg                 [(DATA_WIDTH - 1) : 0] stack[0 : (2**PTR_WIDTH - 1)];
//  указатель на вершину
reg                 [(PTR_WIDTH - 1) : 0] pointer;

always      @(  posedge clk or negedge rst_n) begin

    if (    !rst_n)
        //  по сбросу указатель должен указывать на основание стека
        pointer <= {PTR_WIDTH{1'b0}};
    else begin
        case (  {push, pop}) 
            2'b10 : begin
                //  запись в стек
                if (    pointer < (2**PTR_WIDTH - 1)) begin
                    //  если есть куда писать
                    stack[pointer] <= write_data;
                    pointer <= pointer + 1;
                end
                else begin
                    //  указывает на вершину стека
                    //  новые данные затирают значение в верхнем регистре
                    stack[pointer] <= write_data;
                end
            end

            2'b01 : begin
                //  чтение из стека
                if (    pointer != 0) begin
                    //  если есть что читать
                    read_data <= stack[pointer - 1];
                    pointer <= pointer - 1;
                end
                else begin
                    //  указывает на основание
                    //  данных нет, выдаем 0
                    read_data <= {DATA_WIDTH{1'b0}};
                end
            end

            default : begin
                //  либо нет записи
                //  либо ошибка сигналов
                //  выдаем значение адресуемое указателем стека
                read_data <= stack[pointer];
            end

        endcase
    end

end

endmodule