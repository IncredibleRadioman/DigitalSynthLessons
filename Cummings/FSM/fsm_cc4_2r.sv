//  КА с 4 состояниями
//  с 3 блоками always
//  3-й блок фиксирует выходы
module      fsm_cc4_2r(
    //  входы
    input   dly,
    input   done,
    input   req,
    //  тактирование и сброс
    input   clk,
    input   rst_n,
    //  выход
    output  reg gnt
);

//  всего в схеме 4 состояния
//  здесь используется бинарное кодирование
parameter   [1:0] IDLE = 2'b00;
parameter   [1:0] BBUSY = 2'b01;
parameter   [1:0] BWAIT = 2'b10;
parameter   [1:0] BFREE = 2'b11;

//  регистр состояния и шина след состояния
reg         [1:0] state, next;

//  последовательностный блок always
//  обновление текущего состояния
always  @(posedge clk or negedge rst_n) begin
    if (!rst_n)     state <= IDLE;
    else            state <= next;
end

//  комбинационный блок always
//  расчет след состояния
always  @(state or dly or done or req) begin
    //  значение по умолчанию
    next = 2'bx;
    case (state)
        IDLE :
            if (req)        next = BBUSY;
            else            next = IDLE;
        BBUSY :
            if (!done)      next = BBUSY;
            else if (dly)   next = BWAIT;
            else            next = BFREE;
        BWAIT :
            if (!dly)       next = BFREE;
            else            next = BWAIT;
        BFREE :
            if (req)        next = BBUSY;
            else            next = IDLE;
    endcase
end

//  последовательностный блок always
//  расчет выхода с фиксацией
always  @(posedge clk or negedge rst_n) begin
    if (!rst_n) gnt <= 1'b0;
    else begin
        gnt <= 1'b0;
        case (next) 
            IDLE, BFREE : ; // значение по умолчанию
            BBUSY, BWAIT : gnt <= 1'b1;
        endcase
    end
end

endmodule