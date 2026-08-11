//  пусть необходимо использовать временную переменную и не сохранять
//  ее значение между фронтами тактового сигнала
//  полученная схема - 1 D-триггер и комб логику на его входе
module one_dff (
    input       q,
    input       w,
    input       e,
    input       clock,
    output      reg result
);

reg         tmp;

always @(posedge clock) begin
    tmp = q & w;
    if (e)
        tmp = q | w;
    result <= tmp;
    
end
    
endmodule

//  если не указать значение tmp по умолчанию => будет 2 D-триггера
module unwanted_dff (
    input       q,
    input       w,
    input       e,
    input       clock,
    output      reg result
);

reg         tmp;

always @(posedge clock) begin
    if (e)
        tmp = q | w;
    result <= tmp;
    
end
    
endmodule

//  в модуле логика разделена - никаких неявных триггеров
module      two_blocks(
    input       q,
    input       w,
    input       e,
    input       clock,
    output      reg result
);

reg         tmp;

always @(*) begin
    //  комб логика
    tmp = q & w;
    if (e)
        tmp = q | w;
end

always @(posedge clock) begin
    //  посл логика
    result <= tmp;
end

endmodule