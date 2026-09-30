//  Пример автомата Мили
module      fsm_lab8_4(
    //  тактирование
    input       clk,
    //  асинхронный сброс
    input       reset_n,
    //  сигнал разрешения работы
    input       enable,
    //  входной сигнал
    input       a,
    //  выходной сигнал
    output      y
);

//  описание состояний
parameter       [1:0] S0 = 2'b00, S1 = 2'b01, S2 = 2'b11, S3 = 2'b10;
//  текущее состояние
reg             [1:0] state;
//  следующее состояние
reg             [1:0] next_state;

//  обновление регистра-состояния
always  @(posedge clk or negedge reset_n) begin

if (    !reset_n) begin
    //  при сбросе переходим в состояние по умолчанию
    state <= S0;
end
else if (   enable) begin
    //  иначе при разрешающем сигнале обновляем текущее состояние
    state <= next_state;
end

end

//  логика следующего состояния
always @(*) begin

case (  state)
    S0 :
        if (    a) begin
            next_state = S0;
        end
        else begin
            next_state = S1;
        end
    S1 :
        if (    a) begin
            next_state = S1;
        end
        else begin
            next_state = S2;
        end
    S2 :
        if (    a) begin
            next_state = S0;
        end
        else begin
            next_state = S3;
        end
    S3 :
        if (    a) begin
            next_state = S2;
        end
        else begin
            next_state = S0;
        end
    default :
        next_state = S0;
endcase

end

//  выходная логика - зависит и от входа!
assign      y = (a & (state == S1));

endmodule