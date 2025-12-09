module inv (
    input logic [3:0] a,
    output logic [3:0] y
);

    //  always_comb is performed when right part is changed
    always_comb 
        y = ~a;
    
endmodule