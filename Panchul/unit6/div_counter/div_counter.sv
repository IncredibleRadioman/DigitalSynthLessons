module      div_counter #(
    parameter       CNT_DIV = 10
) (
    input       clk_in,
    input       rst_n,
    output      reg clk_out
);

//  внутренний регистр-счетчика
reg     [$clog2(CNT_DIV)-1 : 0] cnt;

//  комб логика
always @(*) begin
    clk_out = (cnt == 0);
end

//  посл логика
always @(posedge clk_in or negedge rst_n) begin
    if (!rst_n)
        cnt <= CNT_DIV - 1;
    else begin
        if  (cnt == 0)
            cnt <= CNT_DIV - 1;
        else
            cnt <= cnt - 1;
    end
end

endmodule