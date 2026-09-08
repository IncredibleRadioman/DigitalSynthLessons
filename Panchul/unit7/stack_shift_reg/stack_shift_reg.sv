//  реализация стека с помощью сдвигового регистра
module      stack_shift_reg #(
    parameter   DATA_WIDTH = 8,
    parameter   STACK_SIZE = 4
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

//  непосредственно стек
reg             [(DATA_WIDTH - 1) : 0] stack[0 : (STACK_SIZE - 1)];

integer         i;

always  @(posedge clk) begin

    if (    reset) //   сигнал синхронного сброса
    begin
        for (   i = 0; i < STACK_SIZE; i = i + 1)
            stack[i] <= {DATA_WIDTH{1'b0}};
    end
    else if (   push) // сигнал записи
    begin
        //  сдвигаем стек вверх
        for (   i = 0; i < (STACK_SIZE - 1) ; i = i + 1)
            stack[i+1] <= stack[i];
        //  запись в вершину стека
        stack[0] <= write_data;
    end
    else if (   pop) // сигнал чтения 
    begin
        //  считываем вершину стека
        read_data <= stack[0];
        //  сдвигаем стек вниз
        for (   i = 0; i < (STACK_SIZE - 1) ; i = i + 1)
            stack[i] <= stack[i + 1];
        //  обнуляем "дно" стека
        stack[STACK_SIZE - 1] <= {DATA_WIDTH{1'b0}};
    end

end

endmodule