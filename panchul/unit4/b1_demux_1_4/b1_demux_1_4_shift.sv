module  b1_demux_1_4_shift (
    input   din,
    input   [1:0] sel,
    output  reg dout0,
    output  reg dout1,
    output  reg dout2,
    output  reg dout3
);

always @(*) begin
    {dout3, dout2, dout1, dout0} = din << sel;
end

endmodule