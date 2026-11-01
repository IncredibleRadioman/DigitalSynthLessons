//  реализация счетчика Грея стиль 1
module graycntr #(
    parameter SIZE = 5
)(
    //  тактирование
    input       logic clk,
    //  сигнал разрешения инкрементирования
    //  при 0 - счетчик будет хранить свое значение
    input       logic inc,
    //  сингал асинхронного сброса active low
    input       logic rst_n,
    //  выход регистра, что хранит текущий код Грея
    output      logic [SIZE-1 : 0] gray 
);

//  внутренние провода (см. статью раздел 5.7.5)
//  следующее значение кода Грея (запишется по фронту тактового импульса)
logic           [SIZE - 1 : 0] gnext;
//  следующее значение бинарного кода (выход сумматора)
logic           [SIZE - 1 : 0] bnext;
//  выход преобразователя Грея-бинарный (текущее значение бинарного кода)
logic           [SIZE - 1 : 0] bin;

//  последовательностная логика - чисто обновление текущего кода Грея
always @(posedge clk or negedge rst_n) begin
    if (    !rst_n) begin
        //  при асинхронном сбросе значение регистра обнуляется
        gray <= 0;
    end
    else begin
        //  если сброса нет - обновляем каждый такт
        gray <= g_next;
    end
end

//  комбинационная логика - преобразования 
always @(*) begin 
    //  первым идет Gray-binary
    for (int i=0; i < SIZE; i++) begin
        bin[i] = ^(gray >> i); // см. раздел 5.7.3
    end
    //  выход сумматора
    //  если inc = 0 - счетчик не будет увел-ся
    bnext = bin + inc;
    //  далее binary-Gray 
    gnext = (bnext >> 1) ^ bnext; //    см. раздел 5.7.4
end
    
endmodule

//  реализация счетчика Кода Грея - стиль 2
module  graycntr2 #(
    parameter   SIZE = 5
) (
    //  тактирование
    input       logic clk,
    //  дополнительный сигнал, =1 - запрет инкремента
    input       logic full,
    //  сигнал разрешения инкрементирования
    input       logic inc,
    //  асинхронный сброс
    input       logic rst_n,
    //  выход регистра, хранящего код Грея
    output      logic [SIZE - 1 : 0] gray
);

//  внутренние провода (см. статью раздел 5.7.5)
//  следующее значение кода Грея (запишется по фронту тактового импульса)
logic           [SIZE - 1 : 0] gnext;
//  следующее значение бинарного кода (выход сумматора)
logic           [SIZE - 1 : 0] bnext;
//  выход преобразователя Грея-бинарный (текущее значение бинарного кода)
logic           [SIZE - 1 : 0] bin;

//  последовательностная логика теперь пишется для 2 регистров
always @(posedge clk or negedge rst_n) begin

    if (    !rst_n) begin
        //  асинхронный сброс
        {bin, gray} <= '0;
    end
    else begin
        {bin, gray} <= {bnext, gnext};
    end

end

//  комбинационная логика
assign bnext = !full ? bin + inc : bin;
assign gnext = (bnext >> 1) ^ bnext;

endmodule