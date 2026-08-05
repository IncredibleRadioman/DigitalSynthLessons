module  b2_mux_2_1_case (
    input   [1:0] d0,
    input   [1:0] d1,
    input   sel,
    output  reg [1:0] y
);

always @(*) begin
    case (sel)
        0 : y = d0;
        1 : y = d1;
    endcase
end

endmodule