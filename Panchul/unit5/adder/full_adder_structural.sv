module  full_adder_structural (
    input   wire x,
    input   wire y,
    input   wire carry_in,
    output  wire z,
    output  wire carry_out
);

wire    [2:0] t;

xor(t[0], x, y);
xor(z, t[0], carry_in);

and(t[1], x, y);
and(t[2], t[0], carry_in);
or(carry_out, t[1], t[2]);

endmodule