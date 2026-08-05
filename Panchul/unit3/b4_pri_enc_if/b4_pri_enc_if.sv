//  приоритетный шифратор, который возвращает
//  номер МЛАДШЕЙ единицы
module b4_pri_enc_if
(
    input   [15:0] encoder_in,
    output  reg [3:0] binary_out,
    input   enable
);

always @(*) begin

    binary_out = 0;
    if (    enable) begin

        if (    encoder_in[0] == 1'b1)
            binary_out = 0;
        else if (   encoder_in[1] == 1'b1)
            binary_out = 1;
        else if (   encoder_in[2] == 1'b1)
            binary_out = 2;
        else if (   encoder_in[3] == 1'b1)
            binary_out = 3;
        else if (   encoder_in[4] == 1'b1)
            binary_out = 4;
        else if (   encoder_in[5] == 1'b1)
            binary_out = 5;
        else if (   encoder_in[6] == 1'b1)
            binary_out = 6;
        else if (   encoder_in[7] == 1'b1)
            binary_out = 7;
        else if (   encoder_in[8] == 1'b1)
            binary_out = 8;
        else if (   encoder_in[9] == 1'b1)
            binary_out = 9;
        else if (   encoder_in[10] == 1'b1)
            binary_out = 10;
        else if (   encoder_in[11] == 1'b1)
            binary_out = 11;
        else if (   encoder_in[12] == 1'b1)
            binary_out = 12;
        else if (   encoder_in[13] == 1'b1)
            binary_out = 13;
        else if (   encoder_in[14] == 1'b1)
            binary_out = 14;
        else if (   encoder_in[15] == 1'b1)
            binary_out = 15;

    end

end

endmodule