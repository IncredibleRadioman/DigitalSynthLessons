//  unsigned multiplier - a
module multiplier_unsigned (
    input logic [3:0] a, b,
    output logic [7:0] y
);

    assign y = a * b;
    
endmodule

//  signed multiplier - b
module multiplier (
    input logic signed [3:0] a,b,
    output logic signed [7:0] y
);

    assign y = a * b;
    
endmodule