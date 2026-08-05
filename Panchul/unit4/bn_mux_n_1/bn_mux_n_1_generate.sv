module  bn_mux_n_1_generate #(
    parameter DATA_WIDTH = 8,
    parameter SEL_WIDTH = 2
) (
    input   [((2**SEL_WIDTH)*DATA_WIDTH)-1 : 0] data,
    input   [SEL_WIDTH-1 : 0] sel,
    output  [DATA_WIDTH-1 : 0] y
);


//  разбор
//  SEL_WIDTH = 2; DATA_WIDTH = 8
//  data = array[2^2 * 8] = array[32]
//  sel = array[2]
//  y = array[8]

//  tmp_array = array[4][8]

//  tmp_array[i] = data[(i+1) * 8 - 1 : i * 8]
//  tmp_array[0] = data[7:0]
//  tmp_array[1] = data[15:8]
//  tmp_array[2] = data[23:16] etc

//  y = tmp_array[sel]

//  массив элементов шириной [DATA_WIDTH] длиной 2^SEL_WIDTH
wire    [DATA_WIDTH-1:0] tmp_array [0 : (2**SEL_WIDTH) - 1];
genvar i;

generate
    for (i = 0; i < 2**SEL_WIDTH; i = i + 1) begin : gen_array
        assign tmp_array[i] = //заполнение элементов
        data[((i+1)*DATA_WIDTH)-1:(i*DATA_WIDTH)];
    end
endgenerate 

//  один из элементов - есть выход
assign y = tmp_array[sel];

endmodule