//  NOT на mux'е
module mux (
    input d0, d1,
    input sel,
    output y
);

    assign y = sel ? d1 : d0;
    
endmodule

module not_mux (
    input d,
    output q
);

mux not_gate
(
    .d0(1'b1),
    .d1(1'b0)
    .sel(d),
    .y(q)
);
    
endmodule