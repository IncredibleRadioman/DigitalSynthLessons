//  модуль импульсного генератора для построений MCP
module  plsgen (
    //  вход данных
    input       logic d,
    //  тактирование
    input       logic clk,
    //  сброс
    input       logic rst_n,
    //  импульс, =1 когда вход изменился
    output      logic pulse,
    //  текущее состояние - хранит прошлый вход
    output      logic q
);

always @(posedge clk or negdedge rst_n) begin
    if (    !rst_n) begin
        q <= '0;
    end
    else begin
        q <= d;
    end

end

//  импульс генерируется при изменении d 
//  (когда вход не равен выходу триггера)
assign pulse = q ^ d;

endmodule