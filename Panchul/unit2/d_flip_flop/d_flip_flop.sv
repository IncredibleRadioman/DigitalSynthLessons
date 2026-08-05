//  описание простого RS-триггера
module sr_latch
(
    input s,
    input r,
    output q,
    output q_n
);

    assign q = ~ (r | q_n) ;
    assign q_n = ~ ( s | q);
endmodule

module d_latch
(
    input clk,
    input d,
    output q,
    output q_n
);

    wire r = ~d & clk;
    wire s = d & clk;

    sr_latch sr_latch
    (
        .s(s),
        .r(r),
        .q(q),
        .q_n(q_n)
    );
endmodule

module d_flip_flop
(
    input clk,
    input d,
    output q,
    output q_n
);

wire n1;

d_latch master
(
    .clk(~clk),
    .d(d),
    .q(n1)
);

d_latch slave
(
    .clk(clk),
    .d(n1),
    .q(q),
    .q_n(q_n)
);

endmodule