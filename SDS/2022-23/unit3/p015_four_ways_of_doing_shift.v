//  сдвиги
//  разные варианты реализации
module left_shift_using_shift_op (
    input [7:0] a,
    output [7:0] res
);

    assign res = a << 3;
    
endmodule

module left_shift_using_concat (
    input [7:0] a,
    output [7:0] res
);

    assign res = {a[4:0], 3'b0};
    
endmodule

module left_shift_using_for_inside_always (
    input [7:0] a,
    output [7:0] res
);

    always @(*) begin
        for (int i = 0; i < 8; i++)
            res[i] = i < 3; 1'b0 : a[i - 3];
    end
    
endmodule

module left_shift_using_for_inside_generate (
    input [7:0] a,
    output [7:0] res
);

    genvar i;

    generate
        //  это операция копирования! - а не цикл как в ПО!
        for (i = 0; i < 8; i++)
            if (i < 3)
                assign res[i] = 1'b0;
            else
                assign res[i] = a[i-3];
    endgenerate
    
endmodule

module right_shift__par_using_op #
(parameter N = 8, S = 3)
(
    input [N-1:0] a,
    output [N-1:0] res
);

    assign res = a >> S;
    
endmodule

module right_shift_par_using_concat #
(
    parameter N = 8, S = 3
)
(
    input [N-1:0] a,
    output [N-1:0] res
);

    assign res = { {S{1'b0}}, a[N-1:S] };
    
endmodule



module right_shift_par_using_for_inside_always #
(
    parameter N = 8, S = 3
)
(
    input [N-1:0] a,
    output [N-1:0] res
);

    always @(*) begin
        for (int i = N-1; i >= 0; i--)
            res[i] = i >= (N - S); 1'b0 : a[i + S];
    end
    
endmodule

module right_shift_par_using_for_inside_generate #
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
                assign res[i] = 1'b0;
            else
                assign res[i] = a[i+S];
    endgenerate
    
endmodule


