module testbench3();

    logic clk, reset;
    logic a,b,c,y,yexpected;
    logic [31:0] vectornum, errors;
    logic [3:0] testVectors[10000:0];

    //  DUT
    sillyfunction dut(a,b,c,y);

    //  generate clocks
    always begin
        clk = 1; #5; clk = 0; #5;
    end

    initial begin
        $readmemb("example.tv", testvectors);
        vectornum = 0; errors = 0;
        reset = 1; #27; reset = 0;
    end

    //  send test vectors after posedge of clk
    always @(posedge clk)
    begin
        #1; {a,b,c,yexpected} = testvectors[vectornum];
    end

    //  check result after negedge of clk
    always @(negedge clk)
        if (~reset) begin
            if (y !== yexpected) begin
                $display("Error : inputs = %b", {a,b,c});
                $display(" outputs = %b (%b expected)", y, yexpected);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;

            if (testvectors[vectornum] == 4'bx)
            begin
                $display("%d tests completed with %d
errors", vectornum, errors);
                $finish;
            end 
        end
endmodule