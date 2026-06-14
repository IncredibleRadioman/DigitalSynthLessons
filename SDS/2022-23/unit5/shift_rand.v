//  ГСЧ на сдвиговом регистре

module right_shifter #
(
    parameter N = 8, S = 3
)
(
    input [N-1:0] a,
    output reg [N-1:0] res
);

    always @(*) begin
        for (int i = N-1; i >= 0; i--)
            res[i] = i >= (N - S)? 1'b0 : a[i + S];
    end
    
endmodule


module shift_randomizer (
    input clk,
    input rst_n,
    output reg y
);

reg [3:0] state;
wire [3:0] next_state;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) state <= 4'b0001;
    else        state <= { (state[1] ^ state[0]), next_state[2:0] };
end

//  он и есть комбинационный ?!
right_shifter #(.N(4), .S(1)) shifter(.a(state), .res(next_state));

always_ff @(posedge clk) begin
    y <= state[1] ^ state[0];
end

    
endmodule