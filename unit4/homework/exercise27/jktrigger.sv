//  JK trigger
module jktrigger (
    input logic j,k,clk,
    output logic q
);

    logic state;

    //  state register
    always @(posedge clk)
    begin
        state <= (j & ~k) ? 1'b1 : 
                 (~j & k) ? 1'b0 :
                 (j & k) ? ~state :
                state;
    end


    //  output logic
    assign q = state;
    
endmodule