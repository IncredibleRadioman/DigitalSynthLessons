//  1-deep / 2-register FIFO синхронизатор
//  та самая память размером 2
module  dp_ram2 #(
    parameter type dat_t = logic [7:0]
) (
    //  входные данные
    input       dat_t d,
    //  адрес записи
    //  память из 2 ячеек, поэтому 1 битный
    input       logic waddr,
    //  адрес чтения
    //  память из 2 ячеек, поэтому 1 битный
    input       logic raddr, 
    //  сигнал разрешения записи
    input       logic we,
    //  тактовый (память тактируется отпр стороной)
    input       logic clk,
    //  выход данных
    output      logic q   
);

//  объект памяти
dat_t   mem[0:1];

always @(posedge clk) begin
    //  запись осуществляется синхронно
    //  по разрешающему сигналу
    if (we)     mem[waddr] <= d;
end

//  выводим асинхронно содержимое по адресу чтения
assign q = mem[raddr];

endmodule