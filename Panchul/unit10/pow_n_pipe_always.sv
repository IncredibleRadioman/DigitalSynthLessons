// параметризованный модуль, выполняющий возведение w-разрядного
// числа в степень n
module  pow_n_pipe_always #(
    parameter       w = 8,
    parameter       n = 5
) (
    input           clk,
    input           rst_n,
    input           arg_vld,
    input           [(w-1) : 0] arg,
    output          reg [(n-1) : 0] res_vld,
    output          reg [(w*n - 1) : 0] res
);

reg                 [(w-1) : 0] arg_reg [1 : (n-1)];
reg                 [(w-1) : 0] pow [2 : n];
reg                 [1 : n] arg_vld_reg;

integer             i;

always @(posedge clk or negedge rst_n) begin
    if (    !rst_n) begin
        for (i = 1; i <= n; i = i + 1) begin
            arg_vld_reg[i] <= 1'b1;
        end
    end 
    else begin
        arg_vld_reg[1] <= arg_vld;
        for (i = 1; i <= (n-1); i = i + 1) begin
            arg_vld_reg[i+1] <= arg_vld_reg[i];
        end
    end
end

always @(posedge clk) begin
    arg_reg[1] <= arg;
    for (i = 1; i < (n-2); i = i + 1) begin
        arg_reg[i+1] <= arg_reg[i];
    end

    pow[2] <= arg_reg[1] * arg_reg[1];

    for (i = 2; i < (n-1); i = i + 1) begin
        pow[i+1] <= pow[i] * arg_reg[i];
    end
end

always @(*) begin
    for (i = 1; i < n; i = i + 1) begin
        res_vld[n-i] = arg_vld_reg[i];
    end

    res[(n-1) * w +: w] = arg_reg[1];
    for (i = 2; i <=n; i = i + 1) begin
        res[(n-i) * w +: w] = pow[i];
    end
end

endmodule