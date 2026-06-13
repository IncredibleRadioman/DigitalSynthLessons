// mux на if'ах
// if-else только в блоках always
module mux_2_1 (
    input [3:0] d0, d1,
    input sel,
    output logic [3:0] y
);

    always @(*) begin
        if (sel)
            y = d1;
        else
            y = d0;
    end
    
endmodule

module mux_4_1 (
    input [3:0] d0, d1, d2, d3,
    input [1:0] sel,
    output logic [3:0] y
);

    always @(*) begin
        if (sel[1]) begin
            if (sel[0])
                y = d3;
            else
                y = d2;
        end
        else begin
            if (sel[0])
                y = d1;
            else
                y = d0;
        end
    end
    
endmodule