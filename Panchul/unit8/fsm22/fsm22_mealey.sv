//  Вариант 22
//  КА Мили с синхронными выходами
module      fsm22_mealey(
    //  тактирование
    input       clk,
    //  асинхронный сброс
    input       reset_n,
    //  сигнал разрешения работы
    input       enable,
    //  входной сигнал (2 битный)
    input       [1:0] a,
    //  выходной сигнал
    output      reg [1:0] y
);

//  возможные состояния
parameter       [1:0] S0 = 0, S1 = 1, S2 = 2, S3 = 3;
//  варианты входного сигнала
parameter       [1:0] A0 = 0, A1 = 1, A2 = 2, A3 = 3;
//  варианты выхода
parameter       [1:0] Y0 = 0, Y1 = 1, Y2 = 2;
//  текущее состояние
reg             [1:0] state;
//  следующее состояние
reg             [1:0] next_state;
//  шина


//  логика вычисления следующего состояния
always @(*) begin

case    (   state)
S0 : begin
    case (  a)
    A0, A1, A2 :
        next_state = S1;
    A3:
        next_state = S3;
    endcase
end
S1 : begin
    case (  a)
    A0, A1 :
        next_state = S2;
    A2 :
        next_state = S3;
    A3 :
        next_state = S0;
    endcase
end
S2 : begin
    case (  a)
    A0, A2, A3 :
        next_state = S2;
    A1 :
        next_state = S3;
    endcase
end
S3 : begin
    case (  a)
    A0 :
        next_state = S2;
    A1, A3 :
        next_state = S0;
    A2 :
        next_state = S3;
    endcase
end
default :
    next_state = S0;
endcase

end

//  регистр
always @(posedge clk or negedge reset_n) begin
    if (    !reset_n) begin
        state <= S0;
    end
    else if (   enable) begin
        state <= next_state;
    end
end

//  выходная логика - по заданию она синхронная
always @(posedge clk) begin
case (  state) 
S0 :
    case (  a) 
        A0, A1, A2 :
            y <= Y1;
        A3 :
            y <= Y0;
    endcase
S1 :
    case (  a)
        A0, A1, A2 :
            y <= Y0;
        A3 :
            y <= Y2;
    endcase
S2 :
    y <= Y0;
S3 :
    case (  a)
        A0, A2 :
            y <= Y0;
        A1, A3 :
            y <= Y2;
    endcase
endcase

end

endmodule