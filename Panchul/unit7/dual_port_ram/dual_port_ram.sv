//  модуль преобразования входного hex числа
//  в сигналы 7-сегментного индикатора
module hexto7segment (
    input       [3:0] in_hex,
    output      reg [6:0] out_7seg
);

always @(*) begin
    case (in_hex) 
        4'b0000 :   out_7seg = 7'b1000000;
        4'b0001 :   out_7seg = 7'b1111001;
        4'b0010 :   out_7seg = 7'b0100100;
        4'b0011 :   out_7seg = 7'b0110000;
        4'b0100 :   out_7seg = 7'b0011001;
        4'b0101 :   out_7seg = 7'b0010010;
        4'b0110 :   out_7seg = 7'b0000010;
        4'b0111 :   out_7seg = 7'b1111000;
        4'b1000 :   out_7seg = 7'b0000000;
        4'b1001 :   out_7seg = 7'b0011000;
        4'b1010 :   out_7seg = 7'b0001000;
        4'b1011 :   out_7seg = 7'b0000011;
        4'b1100 :   out_7seg = 7'b1000110;
        4'b1101 :   out_7seg = 7'b0100001;
        4'b1110 :   out_7seg = 7'b0000110;
        4'b1111 :   out_7seg = 7'b0001110;
    endcase
end
    
endmodule

//  модуль-декодер, преобразует бинарный код в унарный
module      dc2(
    input       [1:0] a,
    output      reg [3:0] dc_out
);

always @(*) begin
    case (a)
        2'b00 : dc_out = 4'b0001;
        2'b01 : dc_out = 4'b0010;
        2'b10 : dc_out = 4'b0100;
        2'b11 : dc_out = 4'b1000;
    endcase
end

endmodule

//  модуль регистра
module      register #(
    parameter   SIZE = 4
) (
    //  порт разрешения сброса
    input       ena,
    //  тактирующий сигнал
    input       clk,
    //  асинхронный сброс
    input       rst_n,
    //  входной порт данных
    input       [SIZE - 1 : 0] d,
    //  выходной порт данных
    output      reg [SIZE - 1 : 0] q
);

always  @(posedge clk or negedge rst_n) begin
    if (    !rst_n)
        q <= {SIZE{1'b0}};
    else if (   ena)
        q <= d;
end

endmodule

module  dual_port_RAM #(
    parameter   DATA_WIDTH = 8,
    parameter   ADDR_WIDTH = 4
) (
    input       we,
    input       clk,
    //  порт записи
    input       [(DATA_WIDTH - 1) : 0] data_in,
    input       [(ADDR_WIDTH - 1) : 0] write_addr,
    //  порт чтения
    input       [(ADDR_WIDTH - 1) : 0] read_addr,
    output      reg [(DATA_WIDTH - 1) : 0] data_out
);

//  непосредственно массив памяти
reg     [(DATA_WIDTH - 1) : 0] dp_ram [0 : (2**ADDR_WIDTH - 1)];

always @(posedge clk) begin
    //  запись или чтение осуществляются синхронно
    if (    we)
        //  для записи должен быть поднят сигнал разрешения записи
        dp_ram[write_addr] <= data_in;
    data_out <= dp_ram[read_addr];

end

endmodule

// //  непосредственно лабораторка
// //  состоит из 2-портовой памяти
// //  на входах порта записи стоят регистры
// //  и на выходах порта чтения стоят регистры
// module      lab7_5 #(
//     parameter       DATA_WIDTH = 8,
//     parameter       ADDR_WIDTH = 4
// ) (
//     input           clk,
//     input           rst_n,
//     input           [9:0] SW,
//     output          [7:0] HEX0,
//     output          [7:0] HEX1,
//     output          [7:0] HEX2,
//     output          [7:0] HEX3,
//     output          [7:0] HEX4,
//     output          [7:0] HEX5
// );

// //  выход декодера из бинарного в унарный
// wire        [3:0] w_we; 
// //  выход регистра, подключенного к порту data_in
// wire        [(DATA_WIDTH - 1) : 0] data_in_reg;
// //  выход регистра, подключенного к порту read_addr
// wire        [(ADDR_WIDTH - 1) : 0] read_addr_reg; 
// //  выход регистра, подключенного к порту write_addr
// wire        [(ADDR_WIDTH - 1) : 0] write_addr_reg;
// //  выход памяти
// wire        [(DATA_WIDTH - 1) : 0] data_out;

// //  объект декодера - к нему подключаются биты SW[9:8]
// //  они и задают бинарный код
// dc2 dc2in4(
//     .a(SW[9:8]),
//     .dc_out(w_we[3:0])
// );



// endmodule