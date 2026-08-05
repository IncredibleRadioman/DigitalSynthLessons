module  b2_mux_2_1_comb_correct2 (
    input   [1:0] d0,
    input   [1:0] d1,
    input   sel,
    output  [1:0] y
);

wire [1:0] select;
assign select = {2{sel}};
assign y = (select & d1) | (~select & d0);

endmodule