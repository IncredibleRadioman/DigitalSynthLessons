module  mux8_1_ternar # (
    parameter DATA_WIDTH = 8   
) (
    input   [DATA_WIDTH-1 : 0] d0,
    input   [DATA_WIDTH-1 : 0] d1,
    input   [DATA_WIDTH-1 : 0] d2,
    input   [DATA_WIDTH-1 : 0] d3,
    input   [DATA_WIDTH-1 : 0] d4,
    input   [DATA_WIDTH-1 : 0] d5,
    input   [DATA_WIDTH-1 : 0] d6,
    input   [DATA_WIDTH-1 : 0] d7,
    input   [2:0] sel,
    output  [DATA_WIDTH-1 : 0] y
);

assign y = sel[2] ? (sel[1] ? (sel[0] ? d7 : d6) : (sel[0] ? d5 : d4)) :
                    (sel[1] ? (sel[0] ? d3 : d2) : (sel[0] ? d1 : d0));

endmodule