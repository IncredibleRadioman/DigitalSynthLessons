//  кирпичик регистрового файла - регистр
module register #(
    parameter SIZE = 4
) (
    input       ena,
    input       clk,
    input       [SIZE - 1 : 0] d,
    output      reg [SIZE - 1 : 0] q
);


always @(posedge clk) begin

    if (ena)
        q <= d;

end


endmodule

//  непосредственно регистровый файл для 4 регистров
module reg_file #(
    parameter       DATA_WIDTH = 4
) (
    input       clk,
    input       we,
    input       [1 : 0] addr,
    input       [DATA_WIDTH - 1 : 0] data_in,
    output      [DATA_WIDTH - 1 : 0] data_out
);

//  write_en для каждого из регистров
reg         [3 : 0] w_we;
//  сигнал от выходного мультиплексора
//  ЧТО было выбрано
reg         [DATA_WIDTH - 1 : 0] mux_out;

//  выводы с каждого регистра 
//  всего будет 4 выходных порта
//  шириной DATA_WIDTH бит
wire        [DATA_WIDTH - 1 : 0] reg0;
wire        [DATA_WIDTH - 1 : 0] reg1;
wire        [DATA_WIDTH - 1 : 0] reg2;
wire        [DATA_WIDTH - 1 : 0] reg3;

//  спец шина для объединения we и addr
//  чтобы исключить x варианты
wire        [2 : 0] mux_in;

assign mux_in = {   we, addr};

//  управление шиной write_enable
//  ЗАПИСЬ данных в рег файл
always @(*) begin
    //  это комб логика
    case (mux_in)
        3'b1_00 :       w_we = 4'b0001;
        3'b1_01 :       w_we = 4'b0010;
        3'b1_10 :       w_we = 4'b0100;
        3'b1_11 :       w_we = 4'b1000;
        default :       w_we = 4'b0000;
    endcase

end

//  управление выходным мультиплексором
//  ЧТЕНИЕ данных из рег файла
always @(*) begin
    //  это также комб логика
    //  выбор ОТКУДА читать данные
    case (  addr)
        2'b00 :     mux_out = reg0;
        2'b01 :     mux_out = reg1;
        2'b10 :     mux_out = reg2;
        2'b11 :     mux_out = reg3;
        default :   mux_out = {DATA_WIDTH{1'b0}};
    endcase
end

//  подключение выхода
assign      data_out = mux_out;

//  соединение регистров
register #(DATA_WIDTH) register0(
    .ena(w_we[0]),
    .clk(clk),
    .d(data_in),
    .q(reg0)
);

register #(DATA_WIDTH) register1(
    .ena(w_we[1]),
    .clk(clk),
    .d(data_in),
    .q(reg1)
);

register #(DATA_WIDTH) register2(
    .ena(w_we[2]),
    .clk(clk),
    .d(data_in),
    .q(reg2)
);

register #(DATA_WIDTH) register3(
    .ena(w_we[3]),
    .clk(clk),
    .d(data_in),
    .q(reg3)
);


endmodule