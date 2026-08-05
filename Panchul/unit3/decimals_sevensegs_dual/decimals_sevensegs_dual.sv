module hex_to_bindecs
(
    input   [6:0] in_data,
    output  wire [3:0] tens,
    output  wire [3:0] ones
);

reg [14:0] keeper;
integer i;


always @(*) begin

    keeper = {8'b0, in_data};

    for (i = 0; i < 7; i++) begin
        if (    keeper[10:7] >= 5)
            keeper[10:7] = keeper[10:7] + 3;
        if (    keeper[14:11] >= 5)
            keeper[14:11] = keeper[14:11] + 3;

        keeper = keeper << 1;
    end

end

assign tens = keeper[14:11];
assign ones = keeper[10:7];

endmodule


module sevenseg_dec_one_digit
(
    input   [3:0] decoder_in,
    output  reg a,
    output  reg b,
    output  reg c,
    output  reg d,
    output  reg e,
    output  reg f,
    output  reg g,

    input   enable
);

wire    [4:0] sel;

assign sel = {~enable, decoder_in};

always @(*) begin
    case( sel)
    5'h0 :  begin
        a = 1;
        b = 1;
        c = 1;
        d = 0;
        e = 1;
        f = 1;
        g = 1;
    end
    5'h1 :  begin
        a = 0;
        b = 0;
        c = 1;
        d = 0;
        e = 0;
        f = 1;
        g = 0;
    end
    5'h2 :  begin
        a = 1;
        b = 0;
        c = 1;
        d = 1;
        e = 1;
        f = 0;
        g = 1;
    end
    5'h3 :  begin
        a = 1;
        b = 0;
        c = 1;
        d = 1;
        e = 0;
        f = 1;
        g = 1;
    end
    5'h4 :  begin
        a = 0;
        b = 1;
        c = 1;
        d = 1;
        e = 0;
        f = 1;
        g = 0;
    end
    5'h5 :  begin
        a = 1;
        b = 1;
        c = 0;
        d = 1;
        e = 0;
        f = 1;
        g = 1;
    end
    5'h6 :  begin
        a = 1;
        b = 1;
        c = 0;
        d = 1;
        e = 1;
        f = 1;
        g = 1;
    end
    5'h7 :  begin
        a = 1;
        b = 0;
        c = 1;
        d = 0;
        e = 0;
        f = 1;
        g = 0;
    end
    5'h8 :  begin
        a = 1;
        b = 1;
        c = 1;
        d = 1;
        e = 1;
        f = 1;
        g = 1;
    end
    5'h9 :  begin
        a = 1;
        b = 1;
        c = 1;
        d = 1;
        e = 0;
        f = 1;
        g = 1;
    end 
    default :   begin
        a = 0;
        b = 0;
        c = 0;
        d = 0;
        e = 0;
        f = 0;
        g = 0;
    end
    endcase
end

endmodule


module sevenseg_dual_indicator
(
    input   [6:0] decoder_in,
    output  wire a0,
    output  wire b0,
    output  wire c0,
    output  wire d0,
    output  wire e0,
    output  wire f0,
    output  wire g0,

    output  wire a1,
    output  wire b1,
    output  wire c1,
    output  wire d1,
    output  wire e1,
    output  wire f1,
    output  wire g1,

    input   enable
);

wire    [3:0] tens;
wire    [3:0] ones;

hex_to_bindecs converter (
    .in_data(decoder_in),
    .tens(tens),
    .ones(ones)
);

sevenseg_dec_one_digit tens_digit
(
    .decoder_in(tens),
    .a(a0),
    .b(b0),
    .c(c0),
    .d(d0),
    .e(e0),
    .f(f0),
    .g(g0),
    .enable(enable)
);

sevenseg_dec_one_digit ones_digit
(
    .decoder_in(ones),
    .a(a1),
    .b(b1),
    .c(c1),
    .d(d1),
    .e(e1),
    .f(f1),
    .g(g1),
    .enable(enable)
);



endmodule