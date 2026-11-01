//  модуль синхронизатора
//  с условиями для синтеза и симуляции

module sync2_sim #(parameter SIZE = 1)
(
    input   logic [SIZE - 1 : 0] d,
    input   logic clk,
    input   logic rst_n,
    output  logic [SIZE - 1 : 0] q2               
);

`ifdef SYNTHESIS
//  это вып-ся при синтезе - простой 2-flip-flop
always @(posedge clk or negdedge rst_n) begin

    if (    !rst_n) begin
        {q2, q1} <= '0;
    end
    else begin
        {q2, q1} <= {q1, d};
    end
end

`else

logic       [SIZE - 1 : 0] y1;
logic       [SIZE - 1 : 0] q1a;
logic       [SIZE - 1 : 0] q1b;
//  та самая вносимая задержка
logic       [SIZE - 1 : 0] DLY = '0;

//  y1 - это вход 2-го триггера
//  имитация того, что биты могут придти в разное время
assign      y1 = (~DLY & q1a) | (DLY & q1b);

always @(posedge clk or negdedge rst_n) begin

    if (    !rst_n) begin
        {q2, q1b, q1a} <= '0;
    end
    else begin
        {q2, q1b, q1a} <= {y1, q1a, d};
    end
end

`endif

endmodule