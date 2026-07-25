module dec_4_16
(
    input   [3:0] binary_in,
    output  wire [15:0] decoder_out,
    input   enable
);

    assign decoder_out = (enable) ? (1 << binary_in) : 16'b0 ;

endmodule

module dec_6_64
(
    input   [5:0] binary_in,
    output  wire [63:0] decoder_out,
    input enable
);

wire [3:0] en_signals;

assign en_signals = (1 << binary_in[5:4]);


dec_4_16 dec_0_15
(
    .binary_in(binary_in[3:0]),
    .decoder_out(decoder_out[15:0]),
    .enable(en_signals[0])
);

dec_4_16 dec_16_31
(
    .binary_in(binary_in[3:0]),
    .decoder_out(decoder_out[31:16]),
    .enable(en_signals[1])
);

dec_4_16 dec_32_47
(
    .binary_in(binary_in[3:0]),
    .decoder_out(decoder_out[47:32]),
    .enable(en_signals[2])
);

dec_4_16 dec_48_63
(
    .binary_in(binary_in[3:0]),
    .decoder_out(decoder_out[63:48]),
    .enable(en_signals[3])
);

endmodule