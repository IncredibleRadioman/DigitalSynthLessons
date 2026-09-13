//  модуль стека с использованием указателя
//  дополнительно содержит сигналы "пустой" и "полон"
module      stack_with_errors #(
    parameter   DATA_WIDTH = 8,
    parameter   PTR_WIDTH = 2
) (
    //  тактирование
    input       clk,
    //  асинхронный сигнал сброса
    input       rst_n,
    //  сигнал записи
    input       push,
    //  сигнал чтения
    input       pop,
    //  данные на запись
    input       [(DATA_WIDTH - 1) : 0] write_data,
    //  прочитанные данные
    output      reg [(DATA_WIDTH - 1) : 0] read_data,

    //  сигнал "пустой"
    output      stack_empty,
    //  сигнал "полный"
    output      stack_full,
    //  сигнал ошибки записи или чтение
    output      reg stack_error
);

//  сам стек
reg             [(DATA_WIDTH - 1) : 0] stack[0 : (2**PTR_WIDTH - 1)];
//  указатель на вершину
reg             [(PTR_WIDTH - 1) : 0] pointer;

always  @(posedge clk or negedge rst_n) begin
    if (    !rst_n) begin
        //  по сбросу указатель указывает на основание
        pointer <= {PTR_WIDTH{1'b0}};
        //  по сбросу ошибки нет
        stack_error <= 1'b0;
    end
    else begin
        case (  {push, pop}) 
            2'b10 : begin
                //  запись в стек
                if (    pointer < (2**PTR_WIDTH - 1)) begin
                    //  если есть куда писать
                    stack[pointer] <= write_data;
                    pointer <= pointer + 1;
                    stack_error <= 1'b0;
                end
                else begin
                    //  указывает на вершину стека
                    //  новые данные затирают значение в верхнем регистре
                    stack[pointer] <= write_data;
                    stack_error <= 1'b1;
                end
            end

            2'b01 : begin
                //  чтение из стека
                if (    pointer != 0) begin
                    //  если есть что читать
                    read_data <= stack[pointer - 1];
                    pointer <= pointer - 1;
                    stack_error <= 1'b0;
                end
                else begin
                    //  указывает на основание
                    //  данных нет, выдаем 0
                    read_data <= {DATA_WIDTH{1'b0}};
                    stack_error <= 1'b1;
                end
            end

            default : begin
                //  либо нет записи
                //  либо ошибка сигналов
                //  выдаем значение адресуемое указателем стека
                read_data <= stack[pointer];
                stack_error <= 1'b0;
            end
        endcase
    end
end

//  сигнал пустой
assign stack_empty = (pointer == {PTR_WIDTH{1'b0}});
//  сигнал полон
assign stack_full = (pointer == (2**PTR_WIDTH - 1));

endmodule