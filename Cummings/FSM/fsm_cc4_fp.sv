//  КА с 4 состояниями
//  2 блоками always
//  и onehot кодированием
module      fsm_cc4_fp (   
    //  входы
    input   dly,
    input   done,
    input   req,
    //  тактирование и сброс
    input   clk,
    input   rst_n,
    //  выход
    output  reg cnt
);

//  описание состояний
//  теперь это индексы в регистре состояния
//  а не кодирование состояний
parameter   [3:0]   IDLE = 0,
                    BBUSY = 1,
                    BWAIT = 2,
                    BFREE = 3;

//  регистр состояния и шина входа (след состояние)
//  их разрядность = числу состояний (это onehot)
reg         [3:0]   state, next;

//  последовательностный блок always
always  @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        //  сброс
        //  сначала обнулим все биты
        state <= 4'b0;
        //  потом поднимем бит состояния по умолчанию
        //  согласно стандарту - последний <= победит
        state[IDLE] <= 1'b1;
    end
    else begin
        state <= next;
    end
end

//  комбинационный блок always
//  расчет след состояния и выхода
always  @(state or dly or done or req) begin
    //  по умолчанию обнуляем все биты
    next = 4'b0;
    //  задаем значение выхода по умолчанию
    //  (как уже говорилось - это спасает от появления защелок
    //  и уменьшает количество кода)
    gnt = 1'b0;
    //  тот самый инверсный case
    //  он перебирает величины и смотрит их равенство заданной
    //  величине
    case (1'b1) // теперь указываем - 
    //  какие из величин надо на равенство 1 проверить
    //  по сути - также запускаем алгоритм расчета от текущего 
    //  состояния. Новое состояние - также поднимаем конкретный бит
        state[IDLE] :
            if (    req)                next[BBUSY] = 1'b1;
            else                        next[IDLE] = 1'b1;
        state[BBUSY] : begin
            gnt = 1'b1;
            if (    !done)              next[BBUSY] = 1'b1;
            else if (   dly)            next[BWAIT] = 1'b1;
            else                        next[BFREE] = 1'b1;
        end
        state[BWAIT] : begin
            gnt = 1'b1;
            if (    !dly)               next[BFREE] = 1'b1;
            else                        next[BWAIT] = 1'b1;
        end
        state[BFREE] : begin
            if (    req)                next[BBUSY] = 1'b1;
            else                        next[IDLE] = 1'b1;
        end
    endcase
end


endmodule
