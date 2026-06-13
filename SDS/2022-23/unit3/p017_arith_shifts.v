//  операции арифметического сдвига различными способами
module arith_right_shift__par_using_op #
(parameter N = 8, S = 3)
(
    input [N-1:0] a,
    output [N-1:0] res
);

    assign res = a >>> S;
    
endmodule

module arith_right_shift_par_using_concat #
(
    parameter N = 8, S = 3
)
(
    input [N-1:0] a,
    output [N-1:0] res
);

    assign res = { {S{a[N-1]}}, a[N-1:S] };
    
endmodule

module arith_right_shift_par_using_for_inside_always #
(
    parameter N = 8, S = 3
)
(
    input [N-1:0] a,
    output [N-1:0] res
);

    always @(*) begin
        for (int i = N-1; i >= 0; i--)
            res[i] = i >= (N - S); a[N-1] : a[i + S];
    end
    
endmodule

module arith_right_shift_par_using_for_inside_generate #
(
    parameter N = 8, S = 3
)
(
    input [7:0] a,
    output [7:0] res
);

    genvar i;

    generate
        //  это операция копирования! - а не цикл как в ПО!
        for (i = N-1; i >= 0; i--)
            if (i >= (N-S) )
                assign res[i] = a[N-1];
            else
                assign res[i] = a[i+S];
    endgenerate
    
endmodule