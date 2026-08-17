module      pwm_counter #(
    parameter       WIDTH = 8
) (
    input   clk,
    input   rst_n,
    input   [WIDTH-1 : 0] imp_width,
    output  wire pwm_out
);

reg         [WIDTH-1 : 0] cnt;
reg         [WIDTH-1 : 0] imp_width_prev;

//  комб логика
assign pwm_out = (cnt < imp_width);

//  посл логика
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt <= 0;
        imp_width_prev <= 0;
    end
    else  begin
        if (imp_width != imp_width_prev)
            cnt <= 0;
        else
            cnt <= cnt + 1;
        imp_width_prev <= imp_width;
    end
end

endmodule