module ex10(
    input logic a,b,c,
    output logic y
);

    assign p = ~b & (a | c);
    assign q = ~a & b & c;

    mux4 #(1) logic_mux(1'b0, 1'b1, 1'b1, 1'b1,
                        {p,q}, y);
    
endmodule

module testbench();

    logic clk, reset;
    logic a,b,c,y,yexpected;

    logic [31:0] errors;
    logic [2:0] num;

    ex10 dut(a, b, c, y);

    //  clocks
    always begin
        clk = 1; #5; clk = 0; #5;
    end

    //  initialization
    initial begin
        num = 0;
        errors = 0;
        reset = 1; #23; reset = 0;
        $display("Test has been started.");
    end

    //  send test value and calculate answer
    always @(posedge clk) begin
        #1; {a, b, c} = num;
        yexpected = a & ~b | ~b & ~c | ~a & b & c;
    end

    //  check results after negedge clk
    always @(negedge clk) begin
        if (~reset) begin
            
            if (y !== yexpected) begin
                $display("Error: abc = %b%b%b, y = %b (%b expected)", 
                    a, b, c, y, yexpected);
                errors = errors + 1;
            end

            num = num + 1;

            if (num == 0) begin
                $display("Test completed with %d errors", errors);
                $finish;
            end
        end
    end

endmodule