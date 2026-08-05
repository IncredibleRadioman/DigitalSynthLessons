module b2_mux_2_1_if (
    input   [1:0] d0,
    input   [1:0] d1,
    input   sel,
    output  reg [1:0] y
);

always @(*) begin
    if (sel)
        y = d1;
    else
        y = d0;
end

endmodule