//  сдвиговый регистр с сигналом разрешения
module shift_reg_en #(
    parameter       WIDTH = 8
) (
    input       data_in,
    input       clk,
    input       rst_n,
    input       shift_en,
    output      reg [WIDTH - 1 : 0] data_out,
    output      serial_out
);

always @(posedge clk or negedge rst_n) begin
    if (    !rst_n) begin
        data_out <= {WIDTH{1'b0}};
    end
    else if (   shift_en) begin
        data_out <= {data_in, data_out[WIDTH - 1 : 1]};
    end    
end

assign serial_out = data_out[0];
    
endmodule