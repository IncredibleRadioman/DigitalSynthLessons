module mux2 #(
    parameter N = 8
) (
    input logic [N-1:0] d0, d1,
    input logic s,
    output logic [N-1:0] y
);

    assign y = s ? d1 : d0;

endmodule

module mux4 #(
    parameter N = 8
) (
    input logic [N-1:0] d0,d1,d2,d3,
    input logic [1:0] s,
    output logic [N-1:0] y
);

    logic [N-1:0] y0,y1;
    
    mux2 #(N) lowmux(d0, d1, s[0], y0);
    mux2 #(N) himux(d2, d3, s[0], y1);

    mux2 #(N) finalmux(y0, y1, s[1], y);
    
endmodule