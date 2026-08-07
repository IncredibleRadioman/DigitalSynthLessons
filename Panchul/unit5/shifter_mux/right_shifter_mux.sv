//  модуль сдвига вправо на мультиплексора
//  логического
//  на 8 бит
module      right_shifter_mux_8b (
    input   [7:0] data_in,
    input   [2:0] shift,
    output  reg [7:0] data_out
);

always @(*) begin
    case (shift)
        3'b001 :        data_out = {1'b0, data_in[7:1]};
        3'b010 :        data_out = {2'b0, data_in[7:2]};
        3'b011 :        data_out = {3'b0, data_in[7:3]};
        3'b100 :        data_out = {4'b0, data_in[7:4]};
        3'b101 :        data_out = {5'b0, data_in[7:5]};
        3'b110 :        data_out = {6'b0, data_in[7:6]};
        3'b111 :        data_out = {7'b0, data_in[7]};
        default :       data_out = data_in;
    endcase
end

endmodule

//  модуль сдвига вправо на мультиплексора
//  арифметического
//  на 8 бит
module      right_arith_shifter_mux_8b (
    input   [7:0] data_in,
    input   [2:0] shift,
    output  reg [7:0] data_out
);

always @(*) begin
    case (shift)
        3'b001 :        data_out = {data_in[7] ? 1'b1 : 1'b0, data_in[7:1]};
        3'b010 :        data_out = {data_in[7] ? {2{1'b1}} : 2'b0, data_in[7:2]};
        3'b011 :        data_out = {data_in[7] ? {3{1'b1}} : 3'b0, data_in[7:3]};
        3'b100 :        data_out = {data_in[7] ? {4{1'b1}} : 4'b0, data_in[7:4]};
        3'b101 :        data_out = {data_in[7] ? {5{1'b1}} : 5'b0, data_in[7:5]};
        3'b110 :        data_out = {data_in[7] ? {6{1'b1}} : 6'b0, data_in[7:6]};
        3'b111 :        data_out = {data_in[7] ? {7{1'b1}} : 7'b0, data_in[7]};
        default :       data_out = data_in;
    endcase
end

endmodule

//  модуль сдвига вправо на мультиплексора
//  логического
//  на 16 бит
module      right_shifter_mux_16b (
    input   [15:0] data_in,
    input   [3:0] shift,
    output  reg [15:0] data_out
);

always @(*) begin
    case (shift)
        4'b0001 :           data_out = {1'b0, data_in[15:1]};
        4'b0010 :           data_out = {2'b0, data_in[15:2]};
        4'b0011 :           data_out = {3'b0, data_in[15:3]};
        4'b0100 :           data_out = {4'b0, data_in[15:4]};
        4'b0101 :           data_out = {5'b0, data_in[15:5]};
        4'b0110 :           data_out = {6'b0, data_in[15:6]};
        4'b0111 :           data_out = {7'b0, data_in[15:7]};
        4'b1000 :           data_out = {8'b0, data_in[15:8]};
        4'b1001 :           data_out = {9'b0, data_in[15:9]};
        4'b1010 :           data_out = {10'b0, data_in[15:10]};
        4'b1011 :           data_out = {11'b0, data_in[15:11]};
        4'b1100 :           data_out = {12'b0, data_in[15:12]};
        4'b1101 :           data_out = {13'b0, data_in[15:13]};
        4'b1110 :           data_out = {14'b0, data_in[15:14]};
        4'b1111 :           data_out = {15'b0, data_in[15]};
        default :                   
                            data_out = data_in;
    endcase
end

endmodule

//  модуль сдвига вправо на мультиплексора
//  арифметического
//  на 16 бит
module      right_arith_shifter_mux_16b (
    input   [15:0] data_in,
    input   [3:0] shift,
    output  reg [15:0] data_out
);

always @(*) begin
    case (shift)
        4'b0001 :           data_out = {data_in[15] ? 1'b1 : 1'b0, data_in[15:1]};
        4'b0010 :           data_out = {data_in[15] ? {2{1'b1}} : 2'b0, data_in[15:2]};
        4'b0011 :           data_out = {data_in[15] ? {3{1'b1}} : 3'b0, data_in[15:3]};
        4'b0100 :           data_out = {data_in[15] ? {4{1'b1}} : 4'b0, data_in[15:4]};
        4'b0101 :           data_out = {data_in[15] ? {5{1'b1}} : 5'b0, data_in[15:5]};
        4'b0110 :           data_out = {data_in[15] ? {6{1'b1}} : 6'b0, data_in[15:6]};
        4'b0111 :           data_out = {data_in[15] ? {7{1'b1}} : 7'b0, data_in[15:7]};
        4'b1000 :           data_out = {data_in[15] ? {8{1'b1}} : 8'b0, data_in[15:8]};
        4'b1001 :           data_out = {data_in[15] ? {9{1'b1}} : 9'b0, data_in[15:9]};
        4'b1010 :           data_out = {data_in[15] ? {10{1'b1}} : 10'b0, data_in[15:10]};
        4'b1011 :           data_out = {data_in[15] ? {11{1'b1}} : 11'b0, data_in[15:11]};
        4'b1100 :           data_out = {data_in[15] ? {12{1'b1}} : 12'b0, data_in[15:12]};
        4'b1101 :           data_out = {data_in[15] ? {13{1'b1}} : 13'b0, data_in[15:13]};
        4'b1110 :           data_out = {data_in[15] ? {14{1'b1}} : 14'b0, data_in[15:14]};
        4'b1111 :           data_out = {data_in[15] ? {15{1'b1}} : 15'b0, data_in[15]};
        default :                   
                            data_out = data_in;
    endcase
end

endmodule

//  модуль сдвига вправо на мультиплексорах
//  логического
//  на 32 бит
module      right_shifter_mux_32b (
    input   [31:0] data_in,
    input   [4:0] shift,
    output  reg [31:0] data_out
);

always @(*) begin
    case (shift)
        5'b00001 :           data_out = {1'b0, data_in[31:1]};
        5'b00010 :           data_out = {2'b0, data_in[31:2]};
        5'b00011 :           data_out = {3'b0, data_in[31:3]};
        5'b00100 :           data_out = {4'b0, data_in[31:4]};
        5'b00101 :           data_out = {5'b0, data_in[31:5]};
        5'b00110 :           data_out = {6'b0, data_in[31:6]};
        5'b00111 :           data_out = {7'b0, data_in[31:7]};
        5'b01000 :           data_out = {8'b0, data_in[31:8]};
        5'b01001 :           data_out = {9'b0, data_in[31:9]};
        5'b01010 :           data_out = {10'b0, data_in[31:10]};
        5'b01011 :           data_out = {11'b0, data_in[31:11]};
        5'b01100 :           data_out = {12'b0, data_in[31:12]};
        5'b01101 :           data_out = {13'b0, data_in[31:13]};
        5'b01110 :           data_out = {14'b0, data_in[31:14]};
        5'b01111 :           data_out = {15'b0, data_in[31:15]};
        5'b10000 :           data_out = {16'b0, data_in[31:16]};
        5'b10001 :           data_out = {17'b0, data_in[31:17]};
        5'b10010 :           data_out = {18'b0, data_in[31:18]};
        5'b10011 :           data_out = {19'b0, data_in[31:19]};
        5'b10100 :           data_out = {20'b0, data_in[31:20]};
        5'b10101 :           data_out = {21'b0, data_in[31:21]};
        5'b10110 :           data_out = {22'b0, data_in[31:22]};
        5'b10111 :           data_out = {23'b0, data_in[31:23]};
        5'b11000 :           data_out = {24'b0, data_in[31:24]};
        5'b11001 :           data_out = {25'b0, data_in[31:25]};
        5'b11010 :           data_out = {26'b0, data_in[31:26]};
        5'b11011 :           data_out = {27'b0, data_in[31:27]};
        5'b11100 :           data_out = {28'b0, data_in[31:28]};
        5'b11101 :           data_out = {29'b0, data_in[31:29]};
        5'b11110 :           data_out = {30'b0, data_in[31:30]};
        5'b11111 :           data_out = {31'b0, data_in[31]};
        default :                   
                            data_out = data_in;
    endcase
end

endmodule


//  модуль сдвига вправо на мультиплексорах
//  арифметического
//  на 32 бит
module      right_arith_shifter_mux_32b (
    input   [31:0] data_in,
    input   [4:0] shift,
    output  reg [31:0] data_out
);

always @(*) begin
    case (shift)
        5'b00001 :           data_out = {data_in[31] ? 1'b1 : 1'b0, data_in[31:1]};
        5'b00010 :           data_out = {data_in[31] ? {2{1'b1}} : 2'b0, data_in[31:2]};
        5'b00011 :           data_out = {data_in[31] ? {3{1'b1}} : 3'b0, data_in[31:3]};
        5'b00100 :           data_out = {data_in[31] ? {4{1'b1}} : 4'b0, data_in[31:4]};
        5'b00101 :           data_out = {data_in[31] ? {5{1'b1}} : 5'b0, data_in[31:5]};
        5'b00110 :           data_out = {data_in[31] ? {6{1'b1}} : 6'b0, data_in[31:6]};
        5'b00111 :           data_out = {data_in[31] ? {7{1'b1}} : 7'b0, data_in[31:7]};
        5'b01000 :           data_out = {data_in[31] ? {8{1'b1}} : 8'b0, data_in[31:8]};
        5'b01001 :           data_out = {data_in[31] ? {9{1'b1}} : 9'b0, data_in[31:9]};
        5'b01010 :           data_out = {data_in[31] ? {10{1'b1}} : 10'b0, data_in[31:10]};
        5'b01011 :           data_out = {data_in[31] ? {11{1'b1}} : 11'b0, data_in[31:11]};
        5'b01100 :           data_out = {data_in[31] ? {12{1'b1}} : 12'b0, data_in[31:12]};
        5'b01101 :           data_out = {data_in[31] ? {13{1'b1}} : 13'b0, data_in[31:13]};
        5'b01110 :           data_out = {data_in[31] ? {14{1'b1}} : 14'b0, data_in[31:14]};
        5'b01111 :           data_out = {data_in[31] ? {15{1'b1}} : 15'b0, data_in[31:15]};
        5'b10000 :           data_out = {data_in[31] ? {16{1'b1}} : 16'b0, data_in[31:16]};
        5'b10001 :           data_out = {data_in[31] ? {17{1'b1}} : 17'b0, data_in[31:17]};
        5'b10010 :           data_out = {data_in[31] ? {18{1'b1}} : 18'b0, data_in[31:18]};
        5'b10011 :           data_out = {data_in[31] ? {19{1'b1}} : 19'b0, data_in[31:19]};
        5'b10100 :           data_out = {data_in[31] ? {20{1'b1}} : 20'b0, data_in[31:20]};
        5'b10101 :           data_out = {data_in[31] ? {21{1'b1}} : 21'b0, data_in[31:21]};
        5'b10110 :           data_out = {data_in[31] ? {22{1'b1}} : 22'b0, data_in[31:22]};
        5'b10111 :           data_out = {data_in[31] ? {23{1'b1}} : 23'b0, data_in[31:23]};
        5'b11000 :           data_out = {data_in[31] ? {24{1'b1}} : 24'b0, data_in[31:24]};
        5'b11001 :           data_out = {data_in[31] ? {25{1'b1}} : 25'b0, data_in[31:25]};
        5'b11010 :           data_out = {data_in[31] ? {26{1'b1}} : 26'b0, data_in[31:26]};
        5'b11011 :           data_out = {data_in[31] ? {27{1'b1}} : 27'b0, data_in[31:27]};
        5'b11100 :           data_out = {data_in[31] ? {28{1'b1}} : 28'b0, data_in[31:28]};
        5'b11101 :           data_out = {data_in[31] ? {29{1'b1}} : 29'b0, data_in[31:29]};
        5'b11110 :           data_out = {data_in[31] ? {30{1'b1}} : 30'b0, data_in[31:30]};
        5'b11111 :           data_out = {data_in[31] ? {31{1'b1}} : 31'b0, data_in[31]};
        default :                   
                            data_out = data_in;
    endcase
end

endmodule