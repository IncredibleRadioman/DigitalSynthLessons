module  bn_demux_1_4_case # (
    parameter DATA_WIDTH = 2
)(
    input   [DATA_WIDTH-1 : 0] din,
    input   [1:0] sel,
    output  reg [DATA_WIDTH-1 : 0] dout0,
    output  reg [DATA_WIDTH-1 : 0] dout1,
    output  reg [DATA_WIDTH-1 : 0] dout2,
    output  reg [DATA_WIDTH-1 : 0] dout3
);

always @(*) begin
    case (sel)
        2'b00 :     begin
            dout0 = din;
            dout1 = 0;
            dout2 = 0;
            dout3 = 0;
        end
        2'b01 :     begin
            dout0 = 0;
            dout1 = din;
            dout2 = 0;
            dout3 = 0;
        end
        2'b10 :     begin
            dout0 = 0;
            dout1 = 0;
            dout2 = din;
            dout3 = 0;
        end
        2'b11 :     begin
            dout0 = 0;
            dout1 = 0;
            dout2 = 0;
            dout3 = din;
        end
    endcase
end

endmodule