//  FSM на стороне приемника в MCP
module  back_fsm (
    //  сигнал о том, что данные были загружены приемником-получателем
    input   logic bload,
    //  сигнал о том, что данные валидны (то есть прошли в приемный домен)
    input   logic b_en,
    //  тактирование
    input   logic bclk,
    //  сброс
    input   logic brst_n,
    //  сообщение приемнику, что он может забирать данные
    output  logic bvalid
);

//  2 состояния : готов отдать данные и жду новые
enum    logic { READY = '1
                WAIT = '0} state, next;

always @(posedge bclk or negdedge brst_n) begin

//  стандартное обновление состояния КА
if (    !brst_n)    state <= WAIT;
else                state <= next;

end

always @(*) begin

//  комб логика - расчет нового состояния
case (state)
    READY: //   готов отдать данные
        // приемник забирает - перехожу в ожидание новых
        if (    bload)      next <= WAIT; 
        //  иначе - продолжаю их удерживать
        else                next <= READY;
    WAIT:   //  жду новые данные
        //  они пришли - перехожу в готовность отдать
        if (    b_en)       next <= READY;
        //  иначе - продолжаю ждать новые данные
        else                next <= WAIT;

endcase

end

//  валидность данных для приемника определяется текущим состоянием
assign bvalid = state;

endmodule