module mux (
    input d0, d1,
    input sel,
    output y
);

    assign y = sel ? d1 : d0;
    
endmodule

//  AND на mux'е
module and_mux(
    input d0, d1,
    output q
);

    mux and_gate
    (
        .d0(1'b0),
        .d1(d0)),
        .sel(d1),
        .y(q)
    );

endmodule