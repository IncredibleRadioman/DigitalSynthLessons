module  b3_mux_3_1_ternar (
    input   [2:0] d0,
    input   [2:0] d1,
    input   [2:0] d2,
    input   [1:0] sel,
    output  [2:0] y
);

assign y =  (sel == 2'b00) ? d0 : 
            (sel == 2'b01) ? d1 :
            (sel == 2'b10) ? d2 : 3'bxxx;

endmodule