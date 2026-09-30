//  комб блок возведения в 5 степень
//  в поведенческом стиле
module  pow_5_single_cycle_always #(
    parameter   w = 8
) (
    input       clk,
    input       rst_n,
    input       arg_vld,
    input       [(w-1) : 0] arg,
    output      res_vld,
    output      [(w-1) : 0] res
);

reg             [(w-1) : 0] mul_q;
reg             mul_vld;

always  @(posedge clk or negedge rst_n) begin
    if (    !rst_n) begin
        mul_vld <= 1'b0;
    end
    else begin
        mul_vld <= arg_vld;
    end
end

always  @(posedge clk) begin
    mul_q <= arg * arg * arg * arg * arg;
end

assign res_vld = mul_vld;
assign res = mul_q;
    
endmodule