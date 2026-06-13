//  умножение знаковых и беззнаковых чисел

module signed_mul_4 (
    input signed [3:0] a,b,
    output signed [7:0] res
);

    assign res = a * b;
    
endmodule

//  без указания синтезатор будет считать операнды без знака
module unsigned_mul #(
    parameter n = 8
) (
    input [    n - 1 : 0] a,b,
    output[ 2* n - 1 :0] res
);

    assign res = a* b;
    
endmodule

//  выбор, какое именно будет умножение
module signed_or_unsigned_mul #(
    parameter n = 8
) (
    input [    n - 1 : 0] a,b,
    input               sign,
    output reg [ 2* n - 1 :0] res
);

    wire signed [n-1:0] a_s;
    wire signed [n-1:0] b_s;

    assign a_s = a;
    assign b_s = b;


    always @(*) begin
        case (sign)
            0: res = a * b;
            1: res = a_s * b_s;
        endcase
    end
    
endmodule