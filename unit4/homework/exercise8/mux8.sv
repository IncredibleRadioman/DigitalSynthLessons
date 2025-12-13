module mux2 #(
    parameter N = 8
) (
    input logic [N-1:0] d0, d1,
    input logic s,
    output logic [N-1:0] y
);

    assign y = s ? d1 : d0;
endmodule

module mux8 #(
    parameter N = 8
) (
    input logic [N-1:0] d0,d1,d2,d3,d4,d5,d6,d7,
    input logic [2:0] s,
    output logic [N-1:0] y
);

    logic [N-1:0] y01,y23,y45,y67;
    logic [N-1:0] y0123, y4567;
    
    mux2 mux01(d0, d1, s[0], y01);
    mux2 mux23(d2, d3, s[0], y23);
    mux2 mux45(d4, d5, s[0], y45);
    mux2 mux67(d6, d7, s[0], y67);

    mux2 mux0123(y01, y23, s[1], y0123);
    mux2 mux4567(y45, y67, s[1], y4567);

    mux2 finalmux(y0123, y4567, s[2], y);
    
endmodule