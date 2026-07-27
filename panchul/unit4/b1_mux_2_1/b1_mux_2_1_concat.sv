module b1_mux_2_1_concat
(
    input   d0,
    input   d1,
    input   sel,
    output  y
);

wire [1:0] dataIn;

assign dataIn = {d1, d0};
assign y = dataIn[sel];

endmodule