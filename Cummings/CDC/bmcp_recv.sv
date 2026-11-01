//  описание приемной стороны в схеме MCP целиком
module  bmcp_recv (
    //  асинхронные входные данные
    input       logic [7:0] adata,
    //  сигнал от приемника о том, что он загрузил данные
    input       logic bload,
    //  это сигнал aen на схеме MCP, но Каммингс назвал его иначе
    //  короче, вход d генератора импульсов в приемнике
    input       logic bq2_en,
    //  тактирование
    input       logic bclk,
    //  сброс
    input       logic brst_n

    //  выходные данные
    output      logic [7:0] bdata,
    //  валидность выходных данных
    output      logic bvalid,
    //  сигнал подтверждения приема
    output      logic b_ack
);

//  сигнал b_en, выход pulse от генератора импульсов
//  короче, он говорит - данные ПРИШЛИ!
logic       b_en;

//  модуль импульсного генератора
plsgen  pg1 (   .pulse(b_en),
                .q(),
                .d(bq2_en),
                .clk(bclk),
                .rst_n(brst_n) );

//  модуль FSM на приемной стороне
back_fsm fsm (
    .bload(bload),
    .b_en(b_en),
    .bclk(bclk),
    .brst_n(brst_n),
    .bvalid(bvalid)
);

//  данные были успешно загружены приемником
//  факт рукопожатия
//  см. схему в 12.2, я его показал
assign bload_data = bvalid & bload;


//  переключение триггера с выходом b_ack
//  он отправляет подтверждение
always @(posedge bclk or negdedge brst_n) begin

    if      (    !brst_n)   b_ack <= '0;
    //  если произошло рукопожатие, то сменить состояние
    //  этот сигнал - он туда-сюда, передатчик
    //  фиксирует именно его изменение
    else if (   bload_data) b_ack <= ~b_ack;

end

//  обновление регистра с данными
//  если и приемник готов, и данные валидны
//  то загружаем
always @(posedge bclk or negedge brst_n) begin
    if      (    !brst_n)   b_ack <= '0;
    //  если произошло рукопожатие, все готовы и валидны
    //  можем загружать данные
    else if (   bload_data) bdata <= adata;
end


endmodule