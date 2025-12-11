module exersize2 (
    input logic [3:0] a,
    output logic [1:0] y
);

logic y0, y1;

always @(*)
begin
    y1 = a[0] | a[1];
    y0 = a[0] | (~a[1] & a[2]);
end

//  output logic
assign y = {y1, y0};
    
endmodule

function logic [1:0] ideal_calc(input logic [3:0] a);

    logic [1:0] y;

    if (a[0])       y = 2'b11;
    else if (a[1])  y = 2'b10;
    else if (a[2])  y = 2'b01;
    else if (a[3])  y = 2'b00;
    else            y = a[1:0];

    return y;

endfunction

module testbench();

    logic [3:0] a;
    logic [1:0] y;
    logic [1:0] yexpected;

    exersize2 dut(a, y);

    initial begin
        $display("Starting the test...");
        #10;

        for (int i = 0; i < 16; i++) begin
            $display("Iteration %0d", i);
            a = i; #10;
            yexpected = ideal_calc(a);
            if (y != yexpected)
                $error("Iteration %0d failed", i);
            
        end

        $display("Done.");
    end

endmodule

