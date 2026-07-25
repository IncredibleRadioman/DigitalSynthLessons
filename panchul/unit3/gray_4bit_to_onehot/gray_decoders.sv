module gray_to_bin #
(
    parameter WIDTH = 8
)
(
    input   [WIDTH-1:0] decoder_in, //  входные данные - код Грея
    input   enable,
    output  reg [WIDTH-1 : 0] decoder_out //  выходной бинарный код
);

integer i;

always @(*) begin
    decoder_out = 0;
    if (enable) begin
        // старший бит кода Грея = страшему биту бинарного кода
        decoder_out[WIDTH-1] = decoder_in[WIDTH-1];

        for (i = WIDTH-2; i >= 0; i = i -1) begin
            decoder_out[i] = decoder_out[i+1] ^ decoder_in[i];
        end
    end
end

endmodule

module bin_to_onehot #
(
    parameter WIDTH = 8
)
(
    input   [WIDTH-1:0] bin_in,
    input   enable,
    output  reg [(1 << WIDTH)-1 : 0] onehot_out
);



always @(*) begin
    onehot_out = 0;
    if (    enable) begin
       onehot_out = 1'b1 <<  bin_in;
    end
end

endmodule


module bin_to_unary #
(
    parameter WIDTH = 8
)
(
    input   [WIDTH-1:0] bin_in,
    input   enable,
    output  reg [(1 << WIDTH)-1 : 0] unary_out
);

integer i;

always @(*) begin
    unary_out = 0;
    if (    enable) begin
        for (i = 0; i < (1<<WIDTH); i = i + 1) begin
            if (    i <= bin_in)
                unary_out[i] = 1'b1;
            else
                unary_out[i] = 1'b0;
        end
    end
end

endmodule

module unary_to_binary #
(
    parameter WIDTH = 8
)
(
    input   [(1<<WIDTH) - 1 : 0] unary_in,
    input   enable,
    output reg [WIDTH - 1 : 0] binary_out
);

integer i;

always @(*) begin
    binary_out = 0;
    if (    enable) begin
        for (i = 0; i < (1<<WIDTH); i = i + 1) begin
            if (    unary_in[i])
                binary_out = i[WIDTH-1:0];
        end
    end
end

endmodule

module bin_to_gray #(
    parameter WIDTH = 8
)
(
    input   [WIDTH-1 : 0] bin_in,
    input   enable,
    output  reg [WIDTH-1 : 0] gray_out
);

always @(*) begin
    gray_out = 0;
    if (    enable) begin
        gray_out = bin_in ^ (bin_in >> 1);
    end
end

endmodule


module gray_to_onehot #
(
    parameter WIDTH = 8
)
(
    input   [WIDTH-1 : 0] gray_in,
    input   enable,
    output  [(1<<WIDTH)-1 : 0] onehot_out
);

wire [WIDTH-1:0] bin_data;

gray_to_bin #(.WIDTH(WIDTH)) gtb
    (
        .decoder_in(gray_in),
        .enable(enable),
        .decoder_out(bin_data)
    );

bin_to_onehot #(.WIDTH(WIDTH)) bto
    (
        .bin_in(bin_data),
        .enable(enable),
        .onehot_out(onehot_out)
    );

endmodule

module gray_to_unary #
(
    parameter WIDTH = 8
)
(
    input   [WIDTH-1 : 0] gray_in,
    input   enable,
    output  [(1<<WIDTH)-1 : 0] unary_out
);

wire [WIDTH-1:0] bin_data; 

gray_to_bin #(.WIDTH(WIDTH)) gtb
    (
        .decoder_in(gray_in),
        .enable(enable),
        .decoder_out(bin_data)
    );

bin_to_unary #(.WIDTH(WIDTH)) bto
    (
        .bin_in(bin_data),
        .enable(enable),
        .unary_out(unary_out)
    );

endmodule

module unary_to_gray #
(
    parameter WIDTH = 8
)
(
    input   [(1<<WIDTH)-1 : 0] unary_in,
    input   enable,
    output  [WIDTH-1 : 0] gray_out
);

wire    [WIDTH-1 : 0] bin_data;

unary_to_binary #(WIDTH) utb
(
    .unary_in(unary_in),
    .enable(enable),
    .binary_out(bin_data)
);

bin_to_gray #(WIDTH) btg
(
    .bin_in(bin_data),
    .enable(enable),
    .gray_out(gray_out)
);

endmodule