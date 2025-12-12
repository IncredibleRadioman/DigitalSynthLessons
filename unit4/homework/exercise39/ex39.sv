module fsm39(
    input logic a,b,clk,reset,
    output logic y
);

    logic state, nextstate, buffer;

    //  state register
    always @(posedge clk, posedge reset)
    begin
        if (reset) state <= 1'b0;
        else state <= nextstate;
    end

    //  nextstate logic
    always @(*)
    begin
        if (b) nextstate = 1'b1;
        else nextstate = 1'b0;
    end

    assign buffer = a;
    assign y = state ? (a & buffer) : (a | buffer);

endmodule