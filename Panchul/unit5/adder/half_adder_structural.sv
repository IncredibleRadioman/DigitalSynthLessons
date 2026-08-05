module  half_adder_structural (
    input   wire x,
    input   wire y,
    output  wire z,
    output  wire carry_out
);

xor(z, x, y);
and(carry_out, x, y);

endmodule