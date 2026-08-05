module JKK
(
    input J,
    input K,
    input CLK,
    output reg Q
);

    always @(posedge clk)
    begin
        if (J && K) Q <= ~Q;
        else if (J && ~K) Q <= 1;
        else if (~J &&  K) Q <= 0;
    end

endmodule