//  описание простой JK-защелки
module jk_latch
(
    input clk,
    input j,
    input k,
    output q,
    output q_n
);

    wire nand1;
    wire nand2;

    assign nand1 = ~ (j & clk & q_n);
    assign nand2 = ~ (k & clk & q);

    assign q = ~ (nand1 & q_n);
    assign q_n = ~ (nand2 & q);
    
endmodule