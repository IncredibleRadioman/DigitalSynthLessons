//  примеры использования защелок в схемах
//  при синтезе модуля будет защелка
module      if_else_latch
(
    input       en,
    input       q,
    input       w,
    output      reg result
);

always @(*) begin
    if (en) begin
        result = q & w;
    end
end

endmodule

//  при синтезе модуля будет защелка
module      case_latch(
    input       [1:0] sel,
    input       q,
    input       w,
    output      reg result
);

always @(*) begin
    case (sel)
        2'b00: result = q | w;
        2'b01: result = q & w;
        2'b10: result = q ^ w;
    endcase
end

endmodule

//  при синтезе модуля не будет защелки
module      if_else_latch_fix
(
    input       en,
    input       q,
    input       w,
    output      reg result
);

always @(*) begin
    if (en) begin
        result = q & w;
    else
        result = q | w;
    end
end

endmodule

//  при синтезе модуля не будет защелки
module      case_latch_fix(
    input       [1:0] sel,
    input       q,
    input       w,
    output      reg result
);

always @(*) begin
    case (sel)
        2'b00: result = q | w;
        2'b01: result = q & w;
        2'b10: result = q ^ w;
        default: result = q & ~w;
    endcase
end

endmodule