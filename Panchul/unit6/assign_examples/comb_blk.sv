//  2 сумматора и логический элемент ИЛИ
//  здесь используются блокирующие присваивания
module      comb_blk(
    input       [7:0] q,
    input       [7:0] w,
    input       [7:0] e,
    output      reg [8:0] result
);

reg         [8:0] qw_sum;
reg         [8:0] qe_sum;

always @(q or w or e) begin
    qw_sum = q + w;
    qe_sum = q + e;
    result = qw_sum | qe_sum;
end

endmodule