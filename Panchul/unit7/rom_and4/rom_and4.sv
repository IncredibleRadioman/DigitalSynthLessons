module      rom_and4(
    input       [3:0] x,
    output      reg y
);


//  4И в виде простой ROM-таблицы
always @(*) begin
    case (x)
        4'b0000 :   y <= 0;
        4'b0001 :   y <= 0;
        4'b0010 :   y <= 0;
        4'b0011 :   y <= 0;
        4'b0100 :   y <= 0;
        4'b0101 :   y <= 0;
        4'b0110 :   y <= 0;
        4'b0111 :   y <= 0;
        4'b1000 :   y <= 0;
        4'b1001 :   y <= 0;
        4'b1010 :   y <= 0;
        4'b1011 :   y <= 0;
        4'b1100 :   y <= 0;
        4'b1101 :   y <= 0;
        4'b1110 :   y <= 0;
        4'b1111 :   y <= 1;
    endcase
end

endmodule