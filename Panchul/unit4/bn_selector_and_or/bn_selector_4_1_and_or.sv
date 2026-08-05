module  bn_select_4_1_and_or # (
    parameter DATA_WIDTH = 32
) (
    input   [(DATA_WIDTH*4)-1 : 0] data,
    input   [3:0] sel,
    output  [DATA_WIDTH-1 : 0] y
);

wire    [(DATA_WIDTH*4)-1 : 0] mask;
wire    [(DATA_WIDTH*4)-1 : 0] masked_data;

assign mask = { {DATA_WIDTH{sel[3]}},
                {DATA_WIDTH{sel[2]}},
                {DATA_WIDTH{sel[1]}},
                {DATA_WIDTH{sel[0]}}};

assign masked_data = data & mask;

assign y = 
masked_data[DATA_WIDTH*4-1:DATA_WIDTH*3] |
masked_data[DATA_WIDTH*3-1:DATA_WIDTH*2] |
masked_data[DATA_WIDTH*2-1:DATA_WIDTH*1] |
masked_data[DATA_WIDTH*1-1:DATA_WIDTH*0];

//  разбор
//  DATA_WIDTH = 8
//  data = array[32]
//  sel = array[4]
//  output = array[8]

//  mask = array[32] =  {8xsel[3], 8xsel[2], 8xsel[1], 8xsel[0]}
//  ex                  {11111111  00000000  00000000  00000000}
//  masked_data = array[32]
//    data = {item3[7:0],
        //item2[7:0],
        //item1[7:0],
        //item0[7:0]}   {item3     item2     item1     item0};

//  masked_data =       {   item3 & 8xsel[3] 
//                          item2 & 8xsel[2]
//                          item1 & 8xsel[1]
//                          item0 & 8xsel[0]}

//  y = item3 & 8xsel[3] | item2 & 8xsel[2] | item1 & 8xsel[1] | item0 & 8xsel[0]



endmodule