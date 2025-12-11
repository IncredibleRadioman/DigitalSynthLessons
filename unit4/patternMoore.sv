//  Moore FSM
//  for bit pattern algo
//  y = 1, if 2 last bits = 01, else 0
module patternMoore (
    input logic clk,
    input logic a,
    output logic y
);

    typedef enum logic [1:0] {S0, S1, S2} 
        statetype;
    statetype state, nextstate;

    //  state register
    //  non-blocking
    always_ff @(posedge clk, 
        posedge reset) 
    begin
    
        if (reset)  state <= S0;
        else        state <= nextstate;

    end

    //  next state logic
    //  blocking
    always_comb 
    begin

        case (state)
            S0 :    if (a)  nextstate = S0;
                    else    nextstate = S1;
            S1 :    if (a)  nextstate = S2;
                    else    nextstate = S1;
            S2 :    if (a)  nextstate = S0;
                    else    nextstate = S1;
            default:        nextstate = S0;
        endcase
    end

    //  output logic
    assign y = (state == S2);
    
endmodule