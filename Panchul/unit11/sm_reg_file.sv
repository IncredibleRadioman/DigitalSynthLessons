//  регистровый файл
module      sm_reg_file (
    input       clk,
    input       [4:0] a0,
    input       [4:0] a1,
    input       [4:0] a2,
    input       [4:0] a3,
    output      [31:0] rd0,
    output      [31:0] rd1,
    output      [31:0] rd2,
    input       [31:0] wd3,
    input       we3
);

//  ПОРТ 0 - отладочный, для чтения
//  ПОРТ 1 - чтение
//  ПОРТ 2 - чтение
//  ПОРТ 3 - запись

//  объект самого рег файла
//  всего 32 регистра
reg             [31:0] rf [31:0];

//  чтение
assign          rd0 = (a0 != 0) ? rf[a0] : 32'b0;
assign          rd1 = (a1 != 0) ? rf[a1] : 32'b0;
assign          rd2 = (a2 != 0) ? rf[a2] : 32'b0;

//  запись - по переднему фронту clk
always  @(posedge clk) begin
    if (    we3) begin
        rf[a3] <= wd3;
    end
end

endmodule