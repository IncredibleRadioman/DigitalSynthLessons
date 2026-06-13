//  циклические сдвиги различными способами
module circ_left_shift_par_using_concat #
(
    parameter N = 8, S = 3;
)
(
    input [N-1:0] a,
    output [N-1:0] res
);

    assign res = {a[N-S-1:0], a[N-1:N-S]};
    
endmodule

module circ_left_shift_par_using_op #
(
    parameter N = 8, S = 3;
)
(
    input [N-1:0] a,
    output [N-1:0] res
);

    assign res = {(a << S) | (a >> (N-S));
    
endmodule


module circ_right_shift_par_using_concat #
(
    parameter N = 8, S = 3;
)
(
    input [N-1:0] a,
    output [N-1:0] res
);

    assign res = {a[S-1:0], a[N-1:S]};
    
endmodule

module circ_right_shift_par_using_op #
(
    parameter N = 8, S = 3;
)
(
    input [N-1:0] a,
    output [N-1:0] res
);

    assign res = {(a >> S) | (a << (N-S));
    
endmodule