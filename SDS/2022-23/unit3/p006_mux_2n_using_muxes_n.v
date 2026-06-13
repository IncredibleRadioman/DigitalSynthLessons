// mux4 из 3 mux2
module mux2_1 (
    input [3:0] d0,
    input [3:0] d1,
    input sel,
    output [3:0] y
);
    
    assign y = sel ? d1 : d0;

endmodule

module mux4_1 (
    input [3:0] d0, d1, d2, d3,
    input [1:0] sel,
    output [3:0] y
);

wire [3:0] d01;
wire [3:0] d23;

mux2_1 mux01(.d0(d0), 
            .d1(d1), 
            .sel(sel[0]), 
            .y(d01));
mux2_1 mux23(.d0(d2), 
            .d1(d3), 
            .sel(sel[0]), 
            .y(d23));
mux2_1 out_mux(.d0(d01), 
                .d1(d23), 
                .sel(sel[1]), 
                .y(y));;


    
endmodule