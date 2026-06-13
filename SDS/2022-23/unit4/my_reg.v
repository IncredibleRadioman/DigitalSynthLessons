//  D-триггер на Verilog
module my_reg (
    input CLK,
    input RST,
    input EN,
    input D,
    output Q
);

reg OUT;

always @(posedge CLK) begin
    if (RST)
        OUT <= 1'b0;
    else if (EN)
        OUT <= D;
end

assign Q = OUT;
    
endmodule