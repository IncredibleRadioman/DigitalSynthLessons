module dff_sync_rst_n
(
    input clk,
    input rst,
    input d,
    output reg q
);

    always @(posedge clk)
        if (rst)
            q <= 0; // вход d игнорируется
        else
            q <= d;

endmodule