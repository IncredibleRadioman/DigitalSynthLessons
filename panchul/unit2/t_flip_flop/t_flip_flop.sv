module d_flip_flop
(
    input clk,
    input d,
    input rst_n,
    output reg q,
    output reg q_n
);

    always @(posedge clk or negedge rst_n) // управляется ФРОНТОМ
    begin
        if (    !rst_n) begin
            q <= 0;
            q_n <= 1;
        end
        else begin
            q <= d;
            q_n <= ~d;
        end
    end   
    

endmodule

module t_flip_flop
(
    input clk,
    input rst_n,
    output q
);

    wire q_n;

    d_flip_flop d 
    (
        .clk(clk),
        .d(q_n),
        .rst_n(rst_n),
        .q(q),
        .q_n(q_n)
    );

endmodule