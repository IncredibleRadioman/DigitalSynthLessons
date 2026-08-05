module b5_pri_enc_assign
(
    input   [15:0] encoder_in,
    output  [3:0] binary_out,
    input enable
);

assign binary_out = (enable) ? (
    (encoder_in[15] == 1'b1) ? 15 :
    (encoder_in[14] == 1'b1) ? 14 :
    (encoder_in[13] == 1'b1) ? 13 :
    (encoder_in[12] == 1'b1) ? 12 :
    (encoder_in[11] == 1'b1) ? 11 :
    (encoder_in[10] == 1'b1) ? 10 :
    (encoder_in[9] == 1'b1) ? 9 :
    (encoder_in[8] == 1'b1) ? 8 :
    (encoder_in[7] == 1'b1) ? 7 :
    (encoder_in[6] == 1'b1) ? 6 :
    (encoder_in[5] == 1'b1) ? 5 :
    (encoder_in[4] == 1'b1) ? 4 :
    (encoder_in[3] == 1'b1) ? 3 :
    (encoder_in[2] == 1'b1) ? 2 :
    (encoder_in[1] == 1'b1) ? 1 :
    (encoder_in[0] == 1'b1) ? 0 : 4'bxxxx):0;


endmodule