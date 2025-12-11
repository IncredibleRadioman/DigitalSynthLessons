module xor4 (
    input logic [3:0] a,
    output logic y
);

assign y = ^a;
    
endmodule

module testbench();

logic clk, reset;
logic [3:0] a;
logic y, yexpected;

logic [31:0] vectornum, errors;
logic [4:0] testvectors[10000:0];

xor4 dut(a, y);

//  generate clocks
always begin
    clk = 1; #5; clk = 0; #5;
end

//  load vectors after start and send reset
initial begin
    $readmemb("xor4.tv", testvectors);
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
        if (vectornum == 16)
        begin
            $display("%d tests completed with %d errors", vectornum, errors);
            $finish;
        end
    end
end

endmodule