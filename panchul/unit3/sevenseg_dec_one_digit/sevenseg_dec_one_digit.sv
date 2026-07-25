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
    5'hA :  begin
        a = 1;
        b = 1;
        c = 1;
        d = 1;
        e = 1;
        f = 1;
        g = 0;
    end
    5'hB :  begin
        a = 0;
        b = 1;
        c = 0;
        d = 1;
        e = 1;
        f = 1;
        g = 1;
    end
    5'hC :  begin
        a = 1;
        b = 1;
        c = 0;
        d = 0;
        e = 1;
        f = 0;
        g = 1;
    end
    5'hD :  begin
        a = 0;
        b = 0;
        c = 1;
        d = 1;
        e = 1;
        f = 1;
        g = 1;
    end
    5'hE :  begin
        a = 1;
        b = 1;
        c = 0;
        d = 1;
        e = 1;
        f = 0;
        g = 1;
    end
    5'hF :  begin
        a = 1;
        b = 1;
        c = 0;
        d = 1;
        e = 1;
        f = 0;
        g = 0;
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