module regfile (
    //  клок
    input logic clk,
    //  сигнал разрешения записи данных wd3 по адресу a3
    input logic we3,
    //  a1,a2 - адреса для чтения, a3 - для записи
    input logic [5:0] a1, a2, a3,
    //  сами данные для записи по адресу a3
    input logic [31:0] wd3,
    //  данные, прочитанные по адресам a1/a2
    output logic [31:0] rd1, rd2
);
//  32 регистра шириной 32 бита
logic [31:0] rf[31:0];

always_ff @( posedge clk ) begin
    if (we3)
        rf[a3] <= wd3;
end

assign rd1 = (a1 != 0) ? rf[a1] : 0;
assign rd2 = (a2 != 0) ? rf[a2] : 0;
    
endmodule