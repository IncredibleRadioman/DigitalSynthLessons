//  стиль с 2 блоками always
module  fsm_cc4_2 (
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
parameter   [1:0] IDLE = 2'b00;
parameter   [1:0] BBUSY = 2'b01;
parameter   [1:0] BWAIT = 2'b10;
parameter   [1:0] BFREE = 2'b11;

//  текущее состояние и следующее
reg     [1:0] state, next;

//  послед логика для регистра состояния
always  @(posedge clk or negedge rst_n) begin
    if (    !rst_n)     state <= IDLE; // нач состояние = IDLE
    else                state <= next;
end

//  комб логика
always  @(state or dly or done or req) begin
    //  расчет следующего состояния
    next = 2'bx;
    //  значение выхода (см. диаграмму, оно опред-ся однозначно
    //  из текущего состояния)
    gnt = 1'b0;
    case (  state)
        IDLE :  if (    req)        next = BBUSY;
                else                next = IDLE;
        BBUSY : begin
                gnt = 1'b1;
                if (    !done)      next = BBUSY;
                else if (   dly)    next = BWAIT;
                else                next = BFREE;
        end
        BWAIT : begin
                gnt = 1'b1;
                if (    !dly)       next = BFREE;
                else                next = BWAIT;
        end
        BFREE : if (    req)        next = BBUSY;
                else                next = IDLE;
    endcase

end

endmodule