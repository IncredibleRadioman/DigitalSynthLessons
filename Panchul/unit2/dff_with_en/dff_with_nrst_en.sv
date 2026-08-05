//  триггер с асинхронным сбросом и сигналом разрешения
module dff_with_nrst_en
(
    input clk,
    input rst_n,
    input en,
    input d,
    output reg q
);

    always @(posedge clk or negedge rst_n)
    begin
        if (    !rst_n)
            q <= 0;
        else if (    en)
            q <= d;
    end
endmodule