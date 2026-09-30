//  комб блок возведения в 5 степень
//  в поведенческом стиле
module  pow_5_multi_cycle_always #(
    parameter   w = 8
) (
    input       clk,
    input       rst_n,
    input       arg_vld,
    input       [(w-1) : 0] arg,
    output      res_vld,
    output      [(w-1) : 0] res
);

//  текущий результат уможения
reg             [(w-1) : 0] mul_q_stage1;
reg             [(w-1) : 0] mul_q_stage2;
reg             [(w-1) : 0] mul_q_stage3;
reg             [(w-1) : 0] mul_q_stage4;
reg             [(w-1) : 0] mul_q_stage5;
//  сдвиговый регистр для отслеживания стадии
reg             [4:0] shift;

always  @(posedge clk or negedge rst_n) begin
    if (    !rst_n) begin
        shift <= 4'b0000;
    end
    else begin
        if (    arg_vld) begin
            shift <= 4'b1000;
        end
        else begin
            shift <= (shift >> 1);
        end
    end
end

always  @(posedge clk) begin
    mul_q_stage1 <= arg * arg;
    mul_q_stage2 <= mul_q_stage1 * arg;
    mul_q_stage3 <= mul_q_stage2 * arg;
    mul_q_stage4 <= mul_q_stage3 * arg;
end

assign res_vld = shift[0];
assign res = mul_q_stage4;
    
endmodule