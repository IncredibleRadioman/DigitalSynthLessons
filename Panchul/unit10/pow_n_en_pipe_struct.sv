//  сначала используемые модули
//  регистр без сброса с сигналом разрешения
module  reg_en_no_rst_n #(
    parameter   w = 8
) (
    input       [(w-1) : 0] din,
    input       clk,
    input       clk_en,
    output      reg [(w-1) : 0] dout
);

always @(posedge clk) begin
    if (    clk_en) begin
        dout <= din;
    end
end

endmodule

//  регистр со сбросом и сигналом разрешения
module  reg_en_rst_n #(
    parameter   w = 8
) (
    input       rst_n,
    input       [(w-1) : 0] din,
    input       clk,
    input       clk_en,
    output      reg [(w-1) : 0] dout
);

always @(posedge clk or negedge rst_n) begin
    if (    !rst_n) begin
        dout <= {w{1'b0}};
    end
    else if (    clk_en) begin
        dout <= din;
    end
end

endmodule

module  reg_rst_n #(
    parameter   w = 8
) (
    input       rst_n,
    input       [(w-1) : 0] din,
    input       clk,
    output      reg [(w-1) : 0] dout
);

always @(posedge clk or negedge rst_n) begin
    if (    !rst_n) begin
        dout <= {w{1'b0}};
    end
    else begin
        dout <= din;
    end
end

endmodule

module  pow_n_en_pipe_struct #(
    parameter   w = 8,
    parameter   n = 5
) (
    input       clk,
    input       rst_n,
    input       clk_en,
    input       arg_vld,
    input       [(w-1) : 0] arg,
    output      [(n-1) : 0] res_vld,
    output      [(w*n - 1) : 0] res
);

//  для начала сделаем промежуточные провода
//  входы умножителей
//  стадии с 1-й по n-1 (типа на 1-й arg^2 и т.д.)
wire            [(w - 1) : 0] mul_d [1 : (n - 1)];
//  выходы умножителей
//  номера стадий сдвигаем на 1 (они же на выходе)
wire            [(w - 1) : 0] mul_q [2 : n];

//  провода для входа arg по стадиям
wire            [(w - 1) : 0] arg_q [0 : n];
//  регистры для хранения валидов на каждой сталии
wire            arg_vld_q [0 : n];
//  регистры для хранения enable'ов на каждой стадии
wire            en_q [0 : n];


//  входные провода
assign          arg_q[0] = arg;
assign          arg_vld_q[0] = arg_vld;
assign          en_q[0] = clk_en;

//  вход умножителя на стадии 1
assign          mul_d[1] = arg_q[1] * arg_q[1];  

//  ставим вход умножителя на 1-й стадии

generate
    genvar  stage;

    //  сначала сформируем входы умножителей с 2 стадии по n-1
    for (   stage = 2; stage <= (n-1); stage = stage + 1) begin : b_mul
        assign mul_d[stage] = mul_q[stage] * arg_q[stage];
    end

    //  теперь соединим входы умножителей и выходы через регистр
    //  с разрешающим сигналом
    for (   stage = 1; stage <= (n-1); stage = stage + 1) begin : b_mul_reg
        reg_en_no_rst_n #(
            .w(w)
        ) i_mul_reg (
            .clk(clk),
            .din(mul_d[stage]),
            .clk_en(en_q[stage]),
            .dout(mul_q[stage + 1])
        );
    end

    //  сформируем цепь прохождения входа arg
    for (   stage = 0; stage <= (n-1); stage = stage + 1) begin : b_arg_reg
        reg_en_no_rst_n #(
            .w(w)
        ) i_arg_reg (
            .clk(clk),
            .din(arg_q[stage]),
            .clk_en(en_q[stage]),
            .dout(arg_q[stage + 1])
        );
    end

    //  сформируем цепь прохождения входа arg_vld
    for (   stage = 0; stage <= (n-1); stage = stage + 1) begin : b_arg_vld_reg
        reg_en_rst_n #(
            .w(1)
        ) i_arg_vld_reg (
            .clk(clk),
            .din(arg_vld_q[stage]),
            .rst_n(rst_n),
            .clk_en(en_q[stage]),
            .dout(arg_vld_q[stage + 1])
        );
    end

    //  и сформируем цепь прохождения enable
    for (   stage = 0; stage <= (n-1); stage = stage + 1) begin : b_en_reg
        reg_rst_n #(
            .w(1)
        ) i_en_reg (
            .clk(clk),
            .din(en_q[stage]),
            .dout(en_q[stage + 1])
        );
    end

    //  формируем выходы
    //  валидность
    //  и данные
    for (   stage = 1; stage <= (n-1); stage = stage + 1) begin : b_res_vld
        assign res_vld[stage] = arg_vld_q[stage + 1];
        assign res[((stage+1) * w - 1) : stage * w] = mul_q[stage + 1];
    end

endgenerate

assign res[(w-1) : 0] = arg_q[1];
assign res_vld[0] = arg_vld_q[1];

endmodule