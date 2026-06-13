//  mux через индекс массива
module mux2_1 (
    input [3:0] d0, d1,
    input sel,
    output [3:0] y
);
    //  массив проводов
    wire [3:0] d [0:1];

    assign d[0] = d0;
    assign d[1] = d1;

    assign y = d[sel];
    
endmodule

module mux4_1 (
    input [3:0] d0, d1, d2, d3,
    input [1:0] sel,
    output [3:0] y
);
    //  массив проводов
    wire [3:0] d [0:3];

    assign d[0] = d0;
    assign d[1] = d1;
    assign d[2] = d2;
    assign d[3] = d3;

    assign y = d[sel];
    
endmodule