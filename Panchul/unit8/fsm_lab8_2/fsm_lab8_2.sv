//  Пример КА Мура с регистровыми выходами
module      fsm_lab_8_2 (
    //  тактирование
    input       clk,
    //  асинхронный сброс
    input       reset_n,
    //  сигнал разрешения работы
    input       enable,
    //  входной сигнал
    input       a,
    //  выходной сигнал
    output      reg y
);

//  описание возможных состояний
parameter       [1:0] S0 = 0, S1 = 1, S2 = 2;
//  текущее состояние
reg             [1:0] state;
//  следующее состояние
reg             [1:0] next_state;
    
//  описание послед части (регистра состояния)
always @(posedge clk or negedge reset_n) begin
    if (    !reset_n) begin
        //  при сбросе переход в состояние по умолчанию
        state <= S0;
    end
    else if (   enable) begin
        //  в штатном режиме (при разрешении работы)
        //  обновляется текущее состояние
        state <= next_state;
    end
end

//  логика вычисления следующего состояния
//  это комбинационная часть
always @(*) begin
    //  согласно графу, отталкиваемся от текущего состояния
    case (  state) 
    S0 :
        if (    a) begin
            next_state = S1;
        end 
        else begin
            next_state = S0;
        end
    S1 :
        if (    a) begin
            next_state = S2;
        end 
        else begin
            next_state = S1;
        end
    S2 :
        if (    a) begin
            next_state = S0;
        end 
        else begin
            next_state = S2;
        end
    default :
        //  страховка от нештатной ситуации
        next_state = S0;
    endcase
end

//  регистровый выход
always  @(posedge clk) begin

case (  state)
    S0          : y <= 0;
    S1          : y <= 1;
    S2          : y <= 1;
    default     : y <= 0;
endcase

end

endmodule