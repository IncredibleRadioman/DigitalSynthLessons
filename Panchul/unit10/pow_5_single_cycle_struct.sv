//  регистр со сбросом (но 1 битный)
module  reg_rst_n (
    input       clk,
    input       rst_n,
    input       din,
    output      reg dout
);

always  @(posedge clk or negedge rst_n) begin
    if (    !rst_n) begin
        dout <= 1'b0;
    end
    else begin
        dout <= din;
    end
end
endmodule

//  регистр без сброса (параметризованный)
module  reg_no_rst #(
    parameter   WIDTH = 8
) (
    input       clk,
    input       [(WIDTH - 1) : 0] din,
    output      reg [(WIDTH - 1) : 0] dout
);

always  @(posedge clk) begin
    dout <= din;
end

endmodule

//  комб блок возведения в 5 степень
module  pow_5_single_cycle_struct #(
    parameter   w = 8
) (
    input       clk,
    input       rst_n,
    input       arg_vld,
    input       [(w-1) : 0] arg,
    output      res_vld,
    output      [(w-1) : 0] res
);

wire            arg_vld_q;
wire            [(w-1) : 0] arg_q;
reg_rst_n       i_arg_vld (
    .clk(clk),
    .rst_n(rst_n),
    .din(arg_vld),
    .dout(arg_vld_q)
);

reg_no_rst      #(.WIDTH(w)) i_arg (
    .clk(clk),
    .din(arg),
    .dout(arg_q)
);

wire            res_vld_d = arg_vld_q;
wire            [(w - 1) : 0] res_d = arg_q * arg_q * arg_q * arg_q * arg_q;
reg_rst_n       i_res_vld(
    .clk(clk),
    .rst_n(rst_n),
    .din(res_vld_d),
    .dout(res_vld)
);

reg_no_rst      #(w) i_res (
    clk,
    res_d,
    res
);
    
endmodule