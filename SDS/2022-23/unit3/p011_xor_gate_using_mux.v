module mux (
    input d0, d1,
    input sel,
    output y
);

    assign y = sel ? d1 : d0;
    
endmodule

//  XOR на mux'е
module xor_mux(
    input d0, d1,
    output q
);

    wire not_d0;

    mux not_gate
    (
        .d0(1'b1),
        .d1(1'b0)
        .sel(d0),
        .y(not_d0)
    );

    mux xor_gate
    (
        .d0(d0),
        .d1(not_d0)),
        .sel(d1),
        .y(q)
    );

endmodule