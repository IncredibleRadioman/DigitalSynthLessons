//  КА с 10 состояниями
//  2 блока always
module  fsm_cc7_2 (
    //  входные сигналы
    input       jmp,
    input       go,
    //  тактирование и сброс
    input       clk,
    input       rst_n,
    //  выходной сигнал
    output      reg y1
);

//  объявление состояний
parameter   S0 = 4'b0000,
            S1 = 4'b0001,
            S2 = 4'b0010,
            S3 = 4'b0011,
            S4 = 4'b0100,
            S5 = 4'b0101,
            S6 = 4'b0110,
            S7 = 4'b0111,
            S8 = 4'b1000,
            S9 = 4'b1001;

//  объявление текущего и следующего состояния
reg         [3:0] state, next;

//  последовательностный блок always
//  обновление состояния и сброс
always  @(posedge clk or negedge rst_n) begin
    if (    !rst_n)     state <= S0;
    else                state <= next;
end

//  комбинационный блок always
always @(state or go or jmp) begin
    //  здесь по умолчанию next задается в X
    //  см. статью - это хорошая практика для отладки
    next = 4'bx;
    //  выход по умолчанию - наличие значения по умолчанию
    //  предотвращает появление защелки
    y1 = 1'b0;

    //  блок case - расчет нового состояния
    case (  state) 
        //  присваивание next выровнено - это ХОРОШАЯ ПРАКТИКА
        S0 :    if (!go)            next = S0;
                else if (jmp)       next = S3;
                else                next = S1;
        S1 :    if (jmp)            next = S3;
                else                next = S2;
        S2 :                        next = S3;
        S3 :    begin
                y1 = 1'b1;
                if (jmp)            next = S3;
                else                next = S4;
                end
        S4 :    if (jmp)            next = S3;
                else                next = S5;
        S5 :    if (jmp)            next = S3;
                else                next = S6;
        S6 :    if (jmp)            next = S3;
                else                next = S7;
        S7 :    if (jmp)            next = S3;
                else                next = S8;
        S8 :    if (jmp)            next = S3;
                else                next = S9;
        S9 :    if (jmp)            next = S3;
                else                next = S0;

    endcase

end

endmodule