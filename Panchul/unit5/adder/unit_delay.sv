module  unit_delay #(
    parameter WIDTH = 8
) (
    input   clock,
    input   [WIDTH-1 : 0] data_in,
    output  reg [WIDTH-1 : 0] data_out
);

always @(posedge clock) begin
    data_out <= data_in;
end

endmodule