module mux (
    input d0, d1,
    input sel,
    output y
);

    assign y = sel ? d1 : d0;
    
endmodule

//  OR на mux'е
module or_mux(
    input d0, d1,
    output q
);

    mux or_gate
    (
        .d0(d0),
        .d1(1'b1)),
        .sel(d1),
        .y(q)
    );

endmodule