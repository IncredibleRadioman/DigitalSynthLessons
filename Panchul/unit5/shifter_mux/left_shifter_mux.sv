//  модуль сдвига влево на мультиплексора
//  логического и арифметического (это одно и то же)
//  на 8 бит
module      left_shifter_mux_8b (
    input   [7:0] data_in,
    input   [2:0] shift,
    output  reg [7:0] data_out
);

always @(*) begin
    case (shift)
        3'b001 :        data_out = {data_in[6:0], 1'b0};
        3'b010 :        data_out = {data_in[5:0], 2'b0};
        3'b011 :        data_out = {data_in[4:0], 3'b0};
        3'b100 :        data_out = {data_in[3:0], 4'b0};
        3'b101 :        data_out = {data_in[2:0], 5'b0};
        3'b110 :        data_out = {data_in[1:0], 6'b0};
        3'b111 :        data_out = {data_in[0], 7'b0};
        default :       data_out = data_in;
    endcase
end

endmodule

//  модуль сдвига влево на мультиплексора
//  логического и арифметического (это одно и то же)
//  на 16 бит
module      left_shifter_mux_16b (
    input   [15:0] data_in,
    input   [3:0] shift,
    output  reg [15:0] data_out
);

always @(*) begin
    case (shift)
        4'b0001 :           data_out = {data_in[14:0], 1'b0};
        4'b0010 :           data_out = {data_in[13:0], 2'b0};
        4'b0011 :           data_out = {data_in[12:0], 3'b0};
        4'b0100 :           data_out = {data_in[11:0], 4'b0};
        4'b0101 :           data_out = {data_in[10:0], 5'b0};
        4'b0110 :           data_out = {data_in[9:0], 6'b0};
        4'b0111 :           data_out = {data_in[8:0], 7'b0};
        4'b1000 :           data_out = {data_in[7:0], 8'b0};
        4'b1001 :           data_out = {data_in[6:0], 9'b0};
        4'b1010 :           data_out = {data_in[5:0], 10'b0};
        4'b1011 :           data_out = {data_in[4:0], 11'b0};
        4'b1100 :           data_out = {data_in[3:0], 12'b0};
        4'b1101 :           data_out = {data_in[2:0], 13'b0};
        4'b1110 :           data_out = {data_in[1:0], 14'b0};
        4'b1111 :           data_out = {data_in[0], 15'b0};
        default :                   
                            data_out = data_in;
    endcase
end

endmodule

//  модуль сдвига влево на мультиплексора
//  логического и арифметического (это одно и то же)
//  на 32 бит
module      left_shifter_mux_32b (
    input   [31:0] data_in,
    input   [4:0] shift,
    output  reg [31:0] data_out
);

always @(*) begin
    case (shift)
        5'b00001 :           data_out = {data_in[30:0], 1'b0};
        5'b00010 :           data_out = {data_in[29:0], 2'b0};
        5'b00011 :           data_out = {data_in[28:0], 3'b0};
        5'b00100 :           data_out = {data_in[27:0], 4'b0};
        5'b00101 :           data_out = {data_in[26:0], 5'b0};
        5'b00110 :           data_out = {data_in[25:0], 6'b0};
        5'b00111 :           data_out = {data_in[24:0], 7'b0};
        5'b01000 :           data_out = {data_in[23:0], 8'b0};
        5'b01001 :           data_out = {data_in[22:0], 9'b0};
        5'b01010 :           data_out = {data_in[21:0], 10'b0};
        5'b01011 :           data_out = {data_in[20:0], 11'b0};
        5'b01100 :           data_out = {data_in[19:0], 12'b0};
        5'b01101 :           data_out = {data_in[18:0], 13'b0};
        5'b01110 :           data_out = {data_in[17:0], 14'b0};
        5'b01111 :           data_out = {data_in[16:0], 15'b0};
        5'b10000 :           data_out = {data_in[15:0], 16'b0};
        5'b10001 :           data_out = {data_in[14:0], 17'b0};
        5'b10010 :           data_out = {data_in[13:0], 18'b0};
        5'b10011 :           data_out = {data_in[12:0], 19'b0};
        5'b10100 :           data_out = {data_in[11:0], 20'b0};
        5'b10101 :           data_out = {data_in[10:0], 21'b0};
        5'b10110 :           data_out = {data_in[9:0], 22'b0};
        5'b10111 :           data_out = {data_in[8:0], 23'b0};
        5'b11000 :           data_out = {data_in[7:0], 24'b0};
        5'b11001 :           data_out = {data_in[6:0], 25'b0};
        5'b11010 :           data_out = {data_in[5:0], 26'b0};
        5'b11011 :           data_out = {data_in[4:0], 27'b0};
        5'b11100 :           data_out = {data_in[3:0], 28'b0};
        5'b11101 :           data_out = {data_in[2:0], 29'b0};
        5'b11110 :           data_out = {data_in[1:0], 30'b0};
        5'b11111 :           data_out = {data_in[0], 31'b0};
        default :                   
                            data_out = data_in;
    endcase
end

endmodule