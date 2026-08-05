module  half_adder (
    input   wire x,
    input   wire y,
    output  wire z,
    output  wire carry_out
);

assign {carry_out, z} = x + y;

endmodule