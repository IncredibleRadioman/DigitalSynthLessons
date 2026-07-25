module enc_pri_32_5
(
    input   [31:0] encoder_in,
    output  reg [4:0] binary_out,
    input   enable
);

always @(*) begin
    binary_out = 0;


    if (    enable) begin

        case (  encoder_in)
            32'h1   :   binary_out = 0;
            32'h2   :   binary_out = 1;
            32'h4   :   binary_out = 2;
            32'h8   :   binary_out = 3;
            32'h10   :   binary_out = 4;
            32'h20   :   binary_out = 5;
            32'h40   :   binary_out = 6;
            32'h80   :   binary_out = 7;
            32'h100   :   binary_out = 8;
            32'h200   :   binary_out = 9;
            32'h400   :   binary_out = 10;
            32'h800   :   binary_out = 11;
            32'h1000   :   binary_out = 12;
            32'h2000  :   binary_out = 13;
            32'h4000   :   binary_out = 14;
            32'h8000   :   binary_out = 15;
            32'h10000   :   binary_out = 16;
            32'h20000   :   binary_out = 17;
            32'h40000   :   binary_out = 18;
            32'h80000   :   binary_out = 19;
            32'h100000   :   binary_out = 20;
            32'h200000   :   binary_out = 21;
            32'h400000   :   binary_out = 22;
            32'h800000   :   binary_out = 23;
            32'h1000000   :   binary_out = 24;
            32'h2000000   :   binary_out = 25;
            32'h4000000   :   binary_out = 26;
            32'h8000000   :   binary_out = 27;
            32'h10000000   :   binary_out = 28;
            32'h20000000   :   binary_out = 29;
            32'h40000000   :   binary_out = 30;
            32'h80000000   :   binary_out = 31;
        endcase
    end

end

endmodule