module decoder2_4 (
    input logic [1:0] a,
    output logic [3:0] y
);
    
always @(*) begin
    case (a)
        0 :         y = 4'b0001;
        1 :         y = 4'b0010;
        2 :         y = 4'b0100;
        3 :         y = 4'b1000;
        default:    y = 4'b0000;
    endcase
end

endmodule

module decoder6_64(
    input   logic [5:0] a,
    output  logic [63:0] y
);

    logic [3:0] y1, y2, y3;

    decoder2_4 d0(a[5:4], y1);
    decoder2_4 d1(a[3:2], y2);
    decoder2_4 d2(a[1:0], y3);

    genvar i;
    generate
        for (i = 0; i < 64; i = i + 1) begin : GATES_generate
            assign y[i] = y1[i >> 4] & y2[(i >> 2) & 3] & y3[i & 3];
        end        
    endgenerate

endmodule