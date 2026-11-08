//  КА с 10 состояниями
//  3 блока always (здесь по рекомендации)
//  кодирование onehot
//  множество выходов и входов
module      fsm_cc8_onehot_fp (
    //  входы
    input   jmp,
    input   go,
    input   sk0,
    input   sk1,
    //  тактирование и сброс
    input   clk,
    input   rst_n,
    //  выходы
    output  reg y1, 
    output  reg y2, 
    output  reg y3
);

//  описание состояний
//  как и в fsm_cc4_fp - это индексы в регистре состояния
parameter   S0 = 0,
            S1 = 1,
            S2 = 2,
            S3 = 3,
            S4 = 4,
            S5 = 5,
            S6 = 6,
            S7 = 7,
            S8 = 8,
            S9 = 9;

//  регистр состояния и шина след состояния
//  разрядность = числу состояний
reg         [9:0] state, next;

//  последовательностный блок always
//  обновление текущего состояния
always  @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= 0;
        state[S0] <= 1'b1;
    end
    else begin
        state <= next;
    end
end


//  комбинационный блок always
//  только расчет след состояния
always  (state or jmp or go or sk0 or sk1) begin
    next = 0;
    case (1'b1)
        state[S0] :
            if (!go)                        next[S0] = 1'b1;
            else if (jmp)                   next[S3] = 1'b1;
            else                            next[S1] = 1'b1;
        state[S1] :
            if (jmp)                        next[S3] = 1'b1;
            else                            next[S2] = 1'b1;
        state[S2] :
            if (jmp)                        next[S3] = 1'b1;
            else                            next[S9] = 1'b1;
        state[S3] :
            if (jmp)                        next[S3] = 1'b1;
            else                            next[S4] = 1'b1;
        state[S4] :
            if (jmp)                        next[S3] = 1'b1;
            else if (sk0 && !jmp)           next[S6] = 1'b1;
            else                            next[S5] = 1'b1;
        state[S5] :
            if (jmp)                        next[S3] = 1'b1;
            else if (!sk1 && !sk0 && !jmp)  next[S6] = 1'b1;
            else if (!sk1 && sk0 && !jmp)   next[S7] = 1'b1;
            else if (sk1 && !sk0 && !jmp)   next[S8] = 1'b1;
            else                            next[S9] = 1'b1;
        state[S6] :
            if (jmp)                        next[S3] = 1'b1;
            else if (go && !jmp)            next[S7] = 1'b1;
            else                            next[S6] = 1'b1;
        state[S7] :
            if (jmp)                        next[S3] = 1'b1;
            else                            next[S8] = 1'b1;
        state[S8] :
            if (jmp)                        next[S3] = 1'b1;
            else                            next[S9] = 1'b1;
        state[S9] :
            if (jmp)                        next[S3] = 1'b1;
            else                            next[S0] = 1'b1;
    endcase
end

//  последовательностный блок always
//  расчет выходов
//  чтобы не было задержки они считаются от next
always  @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        y1 <= 1'b0;
        y2 <= 1'b0;
        y3 <= 1'b0;
    end
    else begin
        y1 <= 1'b0;
        y2 <= 1'b0;
        y3 <= 1'b0;
        case (1'b1) 
            next[S0], next[S2], next[S4], next[S5] : ; // выходы по умолчанию
            next[S7] :  y3 <= 1'b1;
            next[S1] :  y2 <= 1'b1;
            next[S3] : begin
                        y1 <= 1'b1;
                        y2 <= 1'b1;
            end
            next[S8] : begin
                        y2 <= 1'b1;
                        y3 <= 1'b1;
            end
            next[S6], next[S9] : begin
                        y1 <= 1'b1;
                        y2 <= 1'b1;
                        y3 <= 1'b1;
            end
        endcase
    end
end

endmodule

