//  register with operator always
module flop (
    input logic clk,
    input logic [3:0] d,
    output logic [3:0] q
);

    //  always_ff is like always, but only for triggers
    //  it's for Synthesis
    always_ff @(posedge clk)
        q <= d;
    
endmodule