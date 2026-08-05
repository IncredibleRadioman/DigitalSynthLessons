module  comparator #(
    parameter WIDTH = 8
) (
    input   [WIDTH-1 : 0] x,
    input   [WIDTH-1 : 0] y,
    output  eq,
    output  neq,
    output  lt,
    output  lte,
    output  gt,
    output  gte
);

assign eq =     (x == y);
assign neq =    (x != y);
assign lt =     (x < y);
assign lte =    (x <= y);
assign gt =     (x > y);
assign gte =    (x >= y);

endmodule