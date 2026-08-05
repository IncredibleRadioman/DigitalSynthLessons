module  demux_n_1 #(
    parameter DATA_WIDTH = 8,
    parameter SEL_WIDTH = 2
) (
    input   [DATA_WIDTH-1 : 0] data,
    input   [SEL_WIDTH-1 : 0] sel,
    output  [((2**SEL_WIDTH)*DATA_WIDTH)-1 : 0] y
);

//  полностью параметризованный demux

genvar i;
generate
    for (i = 0; i < 2**SEL_WIDTH; i = i + 1) begin : gen_out
        assign y[((i+1)*DATA_WIDTH)-1:(i*DATA_WIDTH)] = 
        (i == sel) ? data : {DATA_WIDTH{1'b0}};
    end
endgenerate

endmodule