module b7_4bit_dec_assign_shift
(
    input   [3:0] binary_in,
    output  wire [15:0] decoder_out,
    input   enable
);

    assign decoder_out = (enable) ? (1 << binary_in) : 16'b0 ;

endmodule