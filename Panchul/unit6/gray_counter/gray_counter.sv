module      gray_counter # (
    parameter   WIDTH = 4
) (
    input       clk,
    input       rst_n,
    output      wire [WIDTH - 1 : 0] cnt
);

reg         [WIDTH - 1 : 0] tmp;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        tmp <= 0;
    else
        tmp <= tmp + 1'b1;
end

assign cnt = tmp ^ (tmp >> 1);

endmodule