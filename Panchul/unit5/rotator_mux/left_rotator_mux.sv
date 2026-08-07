//  модуль циклического сдвига влево на мультиплексора
//  на 8 бит
module      left_rotator_mux_8b (
    input   [7:0] data_in,
    input   [2:0] shift,
    output  reg [7:0] data_out
);

always @(*) begin
    case (shift)
        3'b001 :        data_out = {data_in[6:0], data_in[7]};
        3'b010 :        data_out = {data_in[5:0], data_in[7:6]};
        3'b011 :        data_out = {data_in[4:0], data_in[7:5]};
        3'b100 :        data_out = {data_in[3:0], data_in[7:4]};
        3'b101 :        data_out = {data_in[2:0], data_in[7:3]};
        3'b110 :        data_out = {data_in[1:0], data_in[7:2]};
        3'b111 :        data_out = {data_in[0], data_in[7:1]};
        default :       data_out = data_in;
    endcase
end

endmodule

//  модуль циклического сдвига влево на мультиплексора
//  на 16 бит
module      left_rotator_mux_16b (
    input   [15:0] data_in,
    input   [3:0] shift,
    output  reg [15:0] data_out
);

always @(*) begin
    case (shift)
        4'b0001 :           data_out = {data_in[14:0], data_in[15]};
        4'b0010 :           data_out = {data_in[13:0], data_in[15:14]};
        4'b0011 :           data_out = {data_in[12:0], data_in[15:13]};
        4'b0100 :           data_out = {data_in[11:0], data_in[15:12]};
        4'b0101 :           data_out = {data_in[10:0], data_in[15:11]};
        4'b0110 :           data_out = {data_in[9:0], data_in[15:10]};
        4'b0111 :           data_out = {data_in[8:0], data_in[15:9]};
        4'b1000 :           data_out = {data_in[7:0], data_in[15:8]};
        4'b1001 :           data_out = {data_in[6:0], data_in[15:7]};
        4'b1010 :           data_out = {data_in[5:0], data_in[15:6]};
        4'b1011 :           data_out = {data_in[4:0], data_in[15:5]};
        4'b1100 :           data_out = {data_in[3:0], data_in[15:4]};
        4'b1101 :           data_out = {data_in[2:0], data_in[15:3]};
        4'b1110 :           data_out = {data_in[1:0], data_in[15:2]};
        4'b1111 :           data_out = {data_in[0], data_in[15:1]};
        default :                   
                            data_out = data_in;
    endcase
end

endmodule

//  модуль циклического сдвига влево на мультиплексора
//  на 32 бит
module      left_shifter_mux_32b (
    input   [31:0] data_in,
    input   [3:0] shift,
    output  reg [31:0] data_out
);

always @(*) begin
    case (shift)
        5'b00001 :           data_out = {data_in[30:0], data_in[31]};
        5'b00010 :           data_out = {data_in[29:0], data_in[31:30]};
        5'b00011 :           data_out = {data_in[28:0], data_in[31:29]};
        5'b00100 :           data_out = {data_in[27:0], data_in[31:28]};
        5'b00101 :           data_out = {data_in[26:0], data_in[31:27]};
        5'b00110 :           data_out = {data_in[25:0], data_in[31:26]};
        5'b00111 :           data_out = {data_in[24:0], data_in[31:25]};
        5'b01000 :           data_out = {data_in[23:0], data_in[31:24]};
        5'b01001 :           data_out = {data_in[22:0], data_in[31:23]};
        5'b01010 :           data_out = {data_in[21:0], data_in[31:22]};
        5'b01011 :           data_out = {data_in[20:0], data_in[31:21]};
        5'b01100 :           data_out = {data_in[19:0], data_in[31:20]};
        5'b01101 :           data_out = {data_in[18:0], data_in[31:19]};
        5'b01110 :           data_out = {data_in[17:0], data_in[31:18]};
        5'b01111 :           data_out = {data_in[16:0], data_in[31:17]};
        5'b10000 :           data_out = {data_in[15:0], data_in[31:16]};
        5'b10001 :           data_out = {data_in[14:0], data_in[31:15]};
        5'b10010 :           data_out = {data_in[13:0], data_in[31:14]};
        5'b10011 :           data_out = {data_in[12:0], data_in[31:13]};
        5'b10100 :           data_out = {data_in[11:0], data_in[31:12]};
        5'b10101 :           data_out = {data_in[10:0], data_in[31:11]};
        5'b10110 :           data_out = {data_in[9:0], data_in[31:10]};
        5'b10111 :           data_out = {data_in[8:0], data_in[31:9]};
        5'b11000 :           data_out = {data_in[7:0], data_in[31:8]};
        5'b11001 :           data_out = {data_in[6:0], data_in[31:7]};
        5'b11010 :           data_out = {data_in[5:0], data_in[31:6]};
        5'b11011 :           data_out = {data_in[4:0], data_in[31:5]};
        5'b11100 :           data_out = {data_in[3:0], data_in[31:4]};
        5'b11101 :           data_out = {data_in[2:0], data_in[31:3]};
        5'b11110 :           data_out = {data_in[1:0], data_in[31:2]};
        5'b11111 :           data_out = {data_in[0], data_in[31:1]};
        default :                   
                            data_out = data_in;
    endcase
end

endmodule