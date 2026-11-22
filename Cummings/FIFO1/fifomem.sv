//  модуль буфера FIFO
//  в качестве буфера используется двухпортовая память
module  fifomem #(
    parameter   DATASIZE = 8,
    parameter   ADDRSIZE = 4
) (
    //  пишущая сторона
    //  данные
    input       [DATASIZE - 1 : 0] wdata,
    //  адрес записи
    input       [ADDRSIZE - 1 : 0] waddr,
    //  сигнал валидности данных со стороны пишущего устройства
    input       wclken,
    //  флаг full, задаваемый генератором флага full
    input       wfull,
    //  тактирование берется от пишущего домена
    //  запись - синхронная
    input       wclk,

    //  читающая сторона
    //  чтение - асинхронное
    //  данные
    output      [DATASIZE - 1 : 0] rdata,
    //  адрес чтения
    input       [ADDRSIZE - 1 : 0] raddr
);

`ifdef VENDORRAM
    //  можно задать память от производителя
    vendor_ram  mem(    .dout(rdata),
                        .din(wdata),
                        .waddr(waddr),
                        .raddr(raddr),
                        .wclken(wclken),
                        .clk(wclk));
`else
    //  обычная память
    //  размер памяти
    localparam  DEPTH = 1 << ADDRSIZE;
    //  сам объект памяти
    reg         [DATASIZE - 1 : 0] mem[0 : DEPTH - 1];
    //  асинхронное чтение (данные выставляются по адресу)
    assign      rdata = mem[raddr];

    //  синхронная запись
    always @(posedge wclk) begin
        //  запись разрешена при валидности данных
        //  и отсутствии флага full
        if (    wclken && !wfull) begin
            mem[waddr] <= wdata;
        end
    end

`endif 

endmodule