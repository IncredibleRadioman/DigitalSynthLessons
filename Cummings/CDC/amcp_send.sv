//  описание передающей стороны в схеме MCP целиком
module  amcp_send (
    //  входные данные
    input       logic [7:0] adatain,
    //  сигнал об их валидности
    input       logic asend,
    //  вход d импульсного генератора в отправителе
    //  это подтверждающий сигнал из приемника
    input       logic aq2_ack,
    //  тактирование
    input       logic aclk,
    //  сброс
    input       logic arst_n,
    //  данные, что мы выставляем на выходе регистра
    //  они будут загружены в приемник
    output      logic [7:0] adata,
    //  это мы отправляем в приемник
    //  что данные были загружены в регистр 
    //  и ожидают загрузки приемником
    output      logic a_en,
    //  это отправляем внешнему передатчику - мы готовы принять
    //  новую порцию данных
    //  можешь выставлять ее
    output      logic aready
);

//  подтверждающий импульс от импульсного генератора
//  пойдет дальше в КА, которая регулирует загрузку
logic   aack;

//  импульсный генератор
plsgen  pg1 (   .pulse(aack),
                .q(),
                .d(aq2_ack),
                .clk(aclk),
                .rst_n(arst_n));

//  FSM на стороне отправителя
asend_fsm   fsm (   .asend(asend),
                    .aclk(aclk),
                    .arst_n(arst_n),
                    .aack(aack),
                    .aready(aready));

//  рукопожатие на входе
assign anxt_data = aready & asend;

//  обновление a_en по рукопожатию, это пойдет в приемную сторону
always @(posedge aclk or negdedge arst_n) begin

    if      (    !arst_n)   a_en <= '0;
    //  этот сигнал - он туда-сюда, приемник
    //  фиксирует именно его изменение
    else if (   anxt_data)  a_en <= ~a_en;

end

//  загрузка в регистр по рукопожатию
always @(posedge aclk or negdedge arst_n) begin

    if      (    !arst_n)   adata <= '0;
    //  этот сигнал - он туда-сюда, приемник
    //  фиксирует именно его изменение
    else if (   anxt_data)  adata <= adatain;

end


endmodule