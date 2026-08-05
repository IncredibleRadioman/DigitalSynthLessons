module dff_async_rst_n
(
    input clk,
    input rst_n,
    input d,
    output reg q
);

    always @(posedge clk or negedge rst_n) // теперь ресет в списке 
    //  чув-ти и реакция на него есть независимо от clk
        if (!rst_n)
            q <= 0; // вход d игнорируется
        else
            q <= d;

endmodule