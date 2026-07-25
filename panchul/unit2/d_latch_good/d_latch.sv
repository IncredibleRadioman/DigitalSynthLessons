module d_latch
(
    input clk,
    input d,
    output reg q
);

always @(clk or d) //   защелка управлятеся УРОВНЕМ
    if (    clk)
        q <= d;
endmodule