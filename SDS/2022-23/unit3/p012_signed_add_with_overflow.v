//  сумматор, который выдает сигнал о переполнении
module add (
    input [3:0] a, b,
    output [3:0] sum,
    output overflow
);

//  переполнение будет, если оба операнда одного знака,
//  и старший разряд неверный (для порожительных равен 1,
//  для отрицательный - 0)
    assign overflow = (~sum[3] & a[3] & b[3]) |
                      (sum[3] & (~a[3]) & (~b[3]));  
    assign sum = a + b;
    
endmodule

//  оптимальность!
module add (
    input [3:0] a, b,
    output [3:0] sum,
    output overflow
);

//  знаки одинаковые и знак результата не равен 
//  знаку слагаемого
    assign overflow = (sum[3] ^ a[3]) &
                      (~(a[3] ^ b[3]));
    assign sum = a + b;
    
endmodule