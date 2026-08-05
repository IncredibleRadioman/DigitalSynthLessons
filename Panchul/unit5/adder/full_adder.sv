module  full_adder (
    input   wire x,
    input   wire y,
    input   wire carry_in,
    output  wire z,
    output  wire carry_out
);

assign {carry_out, z} = x + y + carry_in;

endmodule