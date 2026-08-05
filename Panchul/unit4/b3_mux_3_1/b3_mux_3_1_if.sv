module  b3_mux_3_1_if (
    input   [2:0] d0,
    input   [2:0] d1,
    input   [2:0] d2,
    input   [1:0] sel,
    output  reg [2:0] y
);

always @(*) begin
    if (        sel == 2'b00)
        y = d0;
    else if (   sel == 2'b01)
        y = d1;
    else if (   sel == 2'b10)
        y = d2;
    else
        y = 3'bxxx;
end

endmodule