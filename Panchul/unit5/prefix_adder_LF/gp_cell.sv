//  реализация ассоциативного модуля для префиксного сумматора
module  gp_cell (
    input   wire g_left,
    input   wire g_right,
    input   wire p_left,
    input   wire p_right,
    output  wire g_out,
    output  wire p_out
);

    assign g_out = g_left | p_left & g_right;
    assign p_out = p_left & p_right;

endmodule