module b2_enc_if
(
    input   [15:0] encoder_in,
    output  reg [3:0] binary_out,
    input   enable
);

    always @(*) begin

        binary_out = 0;
        if (enable) 
        begin
            if (encoder_in == 16'h1) begin
                binary_out = 0;
            end 
            if (encoder_in == 16'h2) begin
                binary_out = 1;
            end 
            if (encoder_in == 16'h4) begin
                binary_out = 2;
            end 
            if (encoder_in == 16'h8) begin
                binary_out = 3;
            end 
            if (encoder_in == 16'h10) begin
                binary_out = 4;
            end 
            if (encoder_in == 16'h20) begin
                binary_out = 5;
            end 
            if (encoder_in == 16'h40) begin
                binary_out = 6;
            end 
            if (encoder_in == 16'h80) begin
                binary_out = 7;
            end 
            if (encoder_in == 16'h100) begin
                binary_out = 8;
            end 
            if (encoder_in == 16'h200) begin
                binary_out = 9;
            end 
            if (encoder_in == 16'h400) begin
                binary_out = 10;
            end 
            if (encoder_in == 16'h800) begin
                binary_out = 11;
            end 
            if (encoder_in == 16'h1000) begin
                binary_out = 12;
            end 
            if (encoder_in == 16'h2000) begin
                binary_out = 13;
            end 
            if (encoder_in == 16'h4000) begin
                binary_out = 14;
            end 
            if (encoder_in == 16'h8000) begin
                binary_out = 15;
            end

        end

    end

endmodule