module minority (
    input logic a,b,c,
    output logic y
);

    assign y = a & b | b & c | a & c;
    
endmodule

module testbench();

    logic clk, reset;
    logic a,b,c,y,yexpected;

    logic [31:0] vectornum, errors;
    logic [3:0] testvectors[7:0];

    minority dut(a,b,c,y);

    //  generate clocks
    always begin
        clk = 1; #5; clk = 0; #5;
    end

    initial begin
        $readmemb("trtable.tv",testvectors);
        vectornum = 0; errors = 0;
        reset = 1; #23; reset = 0;
        $display("Test started");
    end

    always @(posedge clk) begin
        #1; {a, b, c, yexpected} = testvectors[vectornum];
    end

    always @(negedge clk) begin
        if (~reset) begin
            //  check results
            if (y !== yexpected) begin
                $display("Error: abc = %b%b%b, y = %b (%b expected)", 
                    a, b, c, y, yexpected);
                errors = errors + 1;
            end

            vectornum = vectornum + 1;
            if (vectornum == 8)
            begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end 
        end
    end

endmodule