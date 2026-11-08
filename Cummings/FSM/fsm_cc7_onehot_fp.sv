//  КА с 10 состояниями
//  2 блоками always
//  и кодированием onehot
module      fsm_cc7_onehot_fp (
    //  входы
    input   jmp,
    input   go,
    //  тактирование и сброс
    input   clk,
    input   rst_n,
    //  выход
    output  reg y1
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
always  @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        //  сбрасываем все биты
        //  и поднимаем бит состояния по умолчанию
        state <= 0;
        state[S0] <= 1'b1;
    end
    else begin
        state <= next;
    end
end

//  комбинационный блок always
always  @(state or go or jmp) begin
    //  задаем состояния по умолчанию
    next = 10'b0;
    y1 = 1'b0;
    //  используем инверсный case
    case (1'b1)
        state[S0] :
            if (!go)                next[S0] = 1'b1;
            else if (jmp)           next[S3] = 1'b1;
            else                    next[S1] = 1'b1;
        state[S1] :
            if (jmp)                next[S3] = 1'b1;
            else                    next[S2] = 1'b1;
        state[S2] :                 next[S3] = 1'b1;
        state[S3] : begin
            y1 = 1'b1;
            if (jmp)                next[S3] = 1'b1;
            else                    next[S4] = 1'b1;
        end
        state[S4] : 
            if (jmp)                next[S3] = 1'b1;
            else                    next[S5] = 1'b1;
        state[S5] :
            if (jmp)                next[S3] = 1'b1;
            else                    next[S6] = 1'b1;
        state[S6] :
            if (jmp)                next[S3] = 1'b1;
            else                    next[S7] = 1'b1;
        state[S7] :
            if (jmp)                next[S3] = 1'b1;
            else                    next[S8] = 1'b1;
        state[S8] :
            if (jmp)                next[S3] = 1'b1;
            else                    next[S9] = 1'b1;
        state[S9] :
            if (jmp)                next[S3] = 1'b1;
            else                    next[S0] = 1'b1;
    endcase
end

endmodule