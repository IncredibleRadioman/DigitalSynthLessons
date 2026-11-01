//  стандартный синхронизатор 2 flip-flop
module      sync2(
    //  вход данных
    input   logic d,
    //  тактирование
    input   logic clk,
    //  сброс
    input   logic rst_n,
    //  выход данных
    output  logic q       
);

//  выход  первого flip-flop
logic       q1;

always @(posedge clk or negdedge rst_n) begin

if (    !rst_n) begin
    {q, q1} <= '0;
end
else begin
    {q, q1} <= {q1, d};
end

end

endmodule