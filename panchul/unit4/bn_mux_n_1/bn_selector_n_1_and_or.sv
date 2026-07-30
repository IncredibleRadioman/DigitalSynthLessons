module bn_select_n_1_and_or # (
    parameter DATA_WIDTH = 8,
    parameter INPUT_CHANNELS = 2
) (
    input   [(DATA_WIDTH * INPUT_CHANNELS)-1 : 0] data,
    input   [INPUT_CHANNELS-1 : 0] sel,
    output  [DATA_WIDTH-1 : 0] y
);

wire    [DATA_WIDTH-1 : 0] mask [0:INPUT_CHANNELS-1];
wire    [DATA_WIDTH-1 : 0] masked_data [0:INPUT_CHANNELS-1];
wire    [DATA_WIDTH-1 : 0] or_chain [0:INPUT_CHANNELS-1];

genvar i;
generate
    for (i = 0; i < INPUT_CHANNELS; i = i + 1)
    begin : gen_mask
        assign mask[i] = {DATA_WIDTH{sel[i]}};
        assign masked_data[i] = data[(i+1)*DATA_WIDTH-1 : i*DATA_WIDTH] & mask[i];
    end
endgenerate

generate
    assign or_chain[0] = masked_data[0];
    for (i = 1; i < INPUT_CHANNELS; i = i + 1)
    begin : gen_output
        assign or_chain[i] = or_chain[i-1] | masked_data[i];
    end
endgenerate

assign y = or_chain[INPUT_CHANNELS - 1];

endmodule