//  КА с 10 состояниями
//  3 блока always 
//  с фиксацией выходов
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

//  регистр состояния и шина след состояния
reg         [3:0] state, next;

//  последовательностный блок always
//  обновление текущего состояния
always  @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= S0;
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
        S0 :
            if (!go)                        next = S0;
            else if (jmp)                   next = S3;
            else                            next = S1;
        S1 :
            if (jmp)                        next = S3;
            else                            next = S2;
        S2 :
            if (jmp)                        next = S3;
            else                            next = S9;
        S3 :
            if (jmp)                        next = S3;
            else                            next = S4;
        S4 :
            if (jmp)                        next = S3;
            else if (sk0 && !jmp)           next = S6;
            else                            next = S5;
        S5 :
            if (jmp)                        next = S3;
            else if (!sk1 && !sk0 && !jmp)  next = S6;
            else if (!sk1 && sk0 && !jmp)   next = S7;
            else if (sk1 && !sk0 && !jmp)   next = S8;
            else                            next = S9;
        S6 :
            if (jmp)                        next = S3;
            else if (go && !jmp)            next = S7;
            else                            next = S6;
        S7 :
            if (jmp)                        next = S3;
            else                            next = S8;
        S8 :
            if (jmp)                        next = S3;
            else                            next = S9;
        S9 :
            if (jmp)                        next = S3;
            else                            next = S0;
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
            S0, S2, S4, S5 : ; // выходы по умолчанию
            S7 :  y3 <= 1'b1;
            S1 :  y2 <= 1'b1;
            S3 : begin
                        y1 <= 1'b1;
                        y2 <= 1'b1;
            end
            S8 : begin
                        y2 <= 1'b1;
                        y3 <= 1'b1;
            end
            S6, S9 : begin
                        y1 <= 1'b1;
                        y2 <= 1'b1;
                        y3 <= 1'b1;
            end
        endcase
    end
end

endmodule

