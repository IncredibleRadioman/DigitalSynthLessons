//  Mealy FSM
//  for bit pattern algo
//  y = 1, if 2 last bits = 01, else 0

module patternMealy(
    input logic clk,
    input logic reset,
    input logic a,
    output logic y
);

    typedef enum logic {S0, S1} statetype;
    statetype state, nextstate;

    //  state register
    always_ff @(posedge clk, podsedge reset) begin
        if (reset) state <= S0;
        else state <= nextstate;
    end
    //  next state logic
    always_comb begin
        case (state)
            S0 : if (a) nextstate = S0;
                else    nextstate = S1;
            S1 : if (a) nextstate = S0;
                else    nextstate = S1;
            default:    nextstate = S0;
        endcase
    end

    //  output logic
    assign y = (a & state == S1);
    
endmodule