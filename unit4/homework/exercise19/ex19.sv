module ex19 (
    input logic [3:0] a,
    output logic p,
    output logic d
);

always @(*) begin
    p <= (~a[3] & ~a[2] & a[1] | ~a[3] & a[2] & a[0] |
        a[2] & ~a[1] & a[0] | ~a[2] & a[1] & a[0]);
    d <= (~a[3] & ~a[2] & ~a[1] & ~a[0] | a[3] & a[2] & ~a[1] & ~a[0] |
        a[3] & ~a[2] & ~a[1] & a[0] | ~a[3] & ~a[2] & a[1] & a[0] |
        a[3] & a[2] & a[1] & a[0] | ~a[3] & a[2] & a[1] & ~a[0]);
end
    
endmodule

module testbench();

    logic clk, reset;
    logic [3:0] a;
    logic p, d, p_expected, d_expected;

    logic [31:0] errors;

    ex19 dut(a, p, d);

    //  generate clocks
    always begin
        clk = 1; #5; clk = 0; #5;
    end

    initial begin
        errors = 0;
        a = 0;
        reset = 1; #23; reset = 0;
    end

    always @( posedge clk ) begin
        #1;
        case (a)
            0: begin
                p_expected = 0; 
                d_expected = 1;
            end
            1: begin 
                p_expected = 0;
                d_expected = 0;
            end
            2: begin
                p_expected = 1; 
                d_expected = 0;
            end
            3: begin
                p_expected = 1; 
                d_expected = 1;
            end
            4: begin
                p_expected = 0; 
                d_expected = 0;
            end
            5: begin
                p_expected = 1; 
                d_expected = 0;
            end
            6: begin
                p_expected = 0; 
                d_expected = 1;
            end
            7: begin
                p_expected = 1; 
                d_expected = 0;
            end
            8: begin
                p_expected = 0; 
                d_expected = 0;
            end
            9: begin
                p_expected = 0; 
                d_expected = 1;
            end
            10: begin 
                p_expected = 0; 
                d_expected = 0;
            end
            11: begin
                p_expected = 1;
                d_expected = 0;
            end
            12: begin
                p_expected = 0; 
                d_expected = 1;
            end
            13: begin
                p_expected = 1; 
                d_expected = 0;
            end
            14: begin
                p_expected = 0; 
                d_expected = 0;
            end
            15: begin
                p_expected = 0;
                d_expected = 1;
            end
        endcase
    end

    always @( negedge clk ) begin
        if (~reset) begin
            if (p != p_expected || d != d_expected) begin
                $display("Error: a = %d, p = %d (%d expected), d = %d (%d expected)",
                    a, p, p_expected, d, d_expected);
                errors = errors + 1;
            end

            a = a + 1;
            if (a == 0) begin
                $display("Tests completed with %d errors", errors);
                $finish;
            end
        end
    end

endmodule