module func1(
    input logic a,b,c,
    output logic y
);

    assign y = c & (a | ~b);

endmodule

module func2(
    input logic a,b,c,
    output logic y
);

    assign y = ~a;

endmodule

module func3(
    input logic a,b,c,d,
    output logic y
);

    assign y = ~a | ~b & ~c | b & d | ~b & c & ~d;

endmodule

module testbench();

    logic clk, reset;
    logic a, b, c, d;
    logic y1, y2, y3;
    logic y1_ex, y2_ex, y3_ex;

    logic [31:0] errors;
    logic [3:0] num;

    func1 dut1(a,b,c,y1);
    func2 dut2(a,b,c,y2);
    func3 dut3(a,b,c,y3);

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
        #1; {a, b, c, d} = num;
    y1 = a & c | ~a & ~b & c;
    y2 = ~a & ~b | ~a & b & ~c | ~(a | ~c);
    y3 = ~a & ~b & ~c & ~d | a & ~b & ~c | a & ~b & c & ~d | a & b & d | ~a & ~b & c & ~d | b & ~c & d | ~a;
        
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