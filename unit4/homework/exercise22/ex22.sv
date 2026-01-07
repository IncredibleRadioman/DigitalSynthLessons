module binary_to_unary (
    input logic [2:0] a,
    output logic [6:0] y
);

always @(*) begin
    y[0] <= |a;
    y[1] <= a[2] | a[1];
    y[2] <= a[2] | a[1] & a[0];
    y[3] <= a[2];
    y[4] <= a[2] & a[0] | a[2] & a[1];
    y[5] <= a[2] & a[1];
    y[6] <= a[2] & a[1] & a[0];
end
    
endmodule


module testbench();

logic clk, reset;
logic [2:0] a;
logic [6:0] y;
logic [6:0] yexpected;

logic [31:0] vectornum, errors;
logic [9:0] testvectors[7:0];

binary_to_unary dut(a, y);

//  generate clocks
always begin
    clk = 1; #5; clk = 0; #5;
end

//  load vectors after start and send reset
initial begin
    $readmemb("test.tv", testvectors);
    vectornum = 0; errors = 0;
    reset = 1; #23; reset = 0;
    $display("Loaded");
end

//  send test vectors after posedge clk
always @(posedge clk)
begin
    #1; {a, yexpected} = testvectors[vectornum];
end

//  check results after nedegde clk
always @(negedge clk)
begin
    if (~reset) begin
        // check results
        if (y !== yexpected) begin
            $display("Error: a = %b, y = %b (%b expected)", 
                a, y, yexpected);
            errors = errors + 1;
        end
        //  increment vectornum
        vectornum = vectornum + 1;
        if (vectornum == 8)
        begin
            $display("%d tests completed with %d errors", vectornum, errors);
            $finish;
        end
    end
end


endmodule