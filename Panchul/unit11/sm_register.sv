//  описание обычного 32-битного регистра
module      sm_register (
    input   clk,
    input   rst,
    input   [31:0] d,
    output  reg [31:0] q
);

always @(posedge clk or negedge rst) begin
    if (    ~rst) begin
        q <= 32'b0;
    end
    else begin
        q <= d;
    end
end

endmodule