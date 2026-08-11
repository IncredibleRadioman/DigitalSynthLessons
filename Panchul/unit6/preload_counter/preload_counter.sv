//  счетчик с предустановкой
module      preload_counter #(
    parameter       WIDTH = 8
) (
    input       clk,
    input       rst_n,
    input       load,
    input       [WIDTH - 1 : 0] data_load,
    output      reg [WIDTH - 1 : 0] cnt
);

always @(posedge clk or negedge rst_n) begin
    if  (!rst_n)
        cnt <= {WIDTH{1'b0}};
    else if (load)
        cnt <= data_load;
    else
        cnt <= cnt + 1'b1;
end

endmodule