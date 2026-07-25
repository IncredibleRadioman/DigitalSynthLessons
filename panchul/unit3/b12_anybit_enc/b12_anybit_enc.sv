module b12_anybit_enc(  in, enc_out, enable);

    parameter OUT_SIZE = 4;
    parameter IN_SIZE = 1 << OUT_SIZE;

    input wire [IN_SIZE-1:0] in;
    output wire [OUT_SIZE-1:0] enc_out;

    reg [OUT_SIZE-1:0] out;
    assign enc_out = out;
    input enable;

    integer i;

    always @(in) begin
        if (    enable) begin
            i = 0;
            while ( i < IN_SIZE-1 && !in[i]) i=i+1;
                out <= i;
        end else out <= 0;
    end

endmodule