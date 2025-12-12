module decoder2_4 (
    input logic [1:0] a,
    output logic [3:0] y
);
    
always @(*) begin
    case (a)
        0 :         y = 4'b0001;
        1 :         y = 4'b0010;
        2 :         y = 4'b0100;
        3 :         y = 4'b1000;
        default:    y = 4'b0000;
    endcase
end

endmodule

module testbench();

    logic [1:0] a;
    logic [3:0] y, yexpected;
    logic clk, reset;

    logic [31:0] errors;

    //  generate clocks
    always begin
        clk = 1; #5; clk = 0; #5;
    end

    //  send reset, set and start
    initial begin
        errors = 0;
        a = 0;
        reset = 1; #23; reset = 0;
        $display("Test in process...");
    end

    //  send test vectors after posedge clk
    always @(posedge clk) begin
        //  just wait
        #1;
    end

    //  check results after negedge clk
    always @(negedge clk) begin
        if (~reset) begin
            yexpected = 2**a;
            if (y !== yexpected) begin
                $display("Error: a = %b, y = %b (%b expected)", 
                    a, y, yexpected);
                errors = errors + 1;
            end
            
            // increment a
            a = a + 1;
            if (a == 0) begin
                $display("Tests completed with %d errors", errors);
                $finish;
            end
        end
    end

    decoder2_4 dut(a, y);

endmodule