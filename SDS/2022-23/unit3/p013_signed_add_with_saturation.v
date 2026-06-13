//  помимо переполнения есть сатурация
module add (
    input [3:0] a, b,
    output [3:0] sum
);

    wire saturation_flag;
    wire [3:0] temp_sum;

    assign temp_sum = a + b;
    //  знаки одинаковые и знак результата не равен 
    //  знаку слагаемого
    assign saturation_flag = (temp_sum[3] ^ a[3]) &
                      (~(a[3] ^ b[3]));
    //  если было переполнение, то в зависимости от знака
    //  выдаем или максимальное положительное
    //  или минимальное отрицательное
    assign sum = saturation_flag ? (temp_sum[3] ? 4'h7 : -4'd8) 
        : temp_sum;
    
endmodule