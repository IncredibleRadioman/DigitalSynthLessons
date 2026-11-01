//  FSM на стороне отправителя в схеме MCP
module  asend_fsm (
    //  сигнал о том, что пришли новые данные
    input       logic asend,
    //  тактирование
    input       logic aclk,
    //  сброс
    input       logic arst_n,
    //  подтверждение от приемника
    input       logic aack,
    //  выход - запрос к передатчику (готовность принять)
    output      logic aready
);

//  2 состояния : готовность и занятость
//  соответственно делаем провода для текущего состояния
//  и следующего (стандартная тема для FSM)
enum    logic { READY = '1,
                BUSY = '0} state, next;

always @(posedge aclk or negedge arst_n) begin
    //  обычное синхронное обновление состояния КА
    if (    !arst_n) begin
        state <= READY;
    end
    else begin
        state <= next;
    end
end

always @(*) begin
//  комб логика - расчет следующего состояния
case (state) 
    READY: //   состояние готовности 
        if (    asend)  next = BUSY; // пришли данные - переходим в занятость
        else            next = READY; // иначе продолжаем ждать передатчик
    BUSY: //    состояние занятости
        if (    aack)   next = READY; // пришло подтверждени - переходим в готовность
        else            next = BUSY; // иначе - продолжаем ждать подтверждение от приемника
endcase

end

//  готовность принять определяется текущим состоянием
assign aready = state;

endmodule