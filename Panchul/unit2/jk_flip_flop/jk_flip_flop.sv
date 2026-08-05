module jk_flip_flop
(
    input clk,
    input j,
    input k,
    output q,
    output q_n
);

    wire g1;
    wire g2;
    
    wire q1;
    wire nq1;

    wire g5;
    wire g6;

    assign g1 = ~ (j & clk & q_n);
    assign g2 = ~ (k & clk & q);

    assign q1 = ~ (g1 & nq1);
    assign nq1 = ~ (q1 & g2);

    assign g5 = ~ (g1 & q1);
    assign g6 = ~ (nq1 & g2);

    assign q = ~ (g5 & q_n);
    assign q_n = ~ (g6 & q);


endmodule