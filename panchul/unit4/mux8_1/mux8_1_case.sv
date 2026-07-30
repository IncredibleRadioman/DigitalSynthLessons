module  mux8_1_case # (
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
    output  reg [DATA_WIDTH-1 : 0] y
);

always @(*) begin
    case (sel)
        3'b000 :    y = d0;
        3'b001 :    y = d1;
        3'b010 :    y = d2;
        3'b011 :    y = d3;
        3'b100 :    y = d4;
        3'b101 :    y = d5;
        3'b110 :    y = d6;
        3'b111 :    y = d7;
    endcase
end

endmodule