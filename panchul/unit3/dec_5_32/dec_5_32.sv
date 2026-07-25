module dec_5_32_shift
(
    input   [4:0] binary_in,
    output  wire [31:0] decoder_out,
    input   enable
);

    assign decoder_out = (enable) ? (1 << binary_in) : 32'b0 ;

endmodule

module dec_5_32_if
(
    input   [4:0] binary_in,
    output  reg [31:0] decoder_out,
    input   enable
);

always @(*) begin
    decoder_out = 0;
    if (enable) begin
        case (  binary_in)
            5'h0 : decoder_out = 32'h1;
            5'h1 : decoder_out = 32'h2;
            5'h2 : decoder_out = 32'h4;
            5'h3 : decoder_out = 32'h8;
            5'h4 : decoder_out = 32'h10;
            5'h5 : decoder_out = 32'h20;
            5'h6 : decoder_out = 32'h40;
            5'h7 : decoder_out = 32'h80;
            5'h8 : decoder_out = 32'h100;
            5'h9 : decoder_out = 32'h200;
            5'hA : decoder_out = 32'h400;
            5'hB : decoder_out = 32'h800;
            5'hC : decoder_out = 32'h1000;
            5'hD : decoder_out = 32'h2000;
            5'hE : decoder_out = 32'h4000;
            5'hF : decoder_out = 32'h8000;
            5'h10 : decoder_out = 32'h10000;
            5'h11 : decoder_out = 32'h20000;
            5'h12 : decoder_out = 32'h40000;
            5'h13 : decoder_out = 32'h80000;
            5'h14 : decoder_out = 32'h100000;
            5'h15 : decoder_out = 32'h200000;
            5'h16 : decoder_out = 32'h400000;
            5'h17 : decoder_out = 32'h800000;
            5'h18 : decoder_out = 32'h1000000;
            5'h19 : decoder_out = 32'h2000000;
            5'h1A : decoder_out = 32'h4000000;
            5'h1B : decoder_out = 32'h8000000;
            5'h1C : decoder_out = 32'h10000000;
            5'h1D : decoder_out = 32'h20000000;
            5'h1E : decoder_out = 32'h40000000;
            5'h1F : decoder_out = 32'h80000000;
        endcase
    end
end

endmodule