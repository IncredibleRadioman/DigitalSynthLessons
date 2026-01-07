module ex20 (
    input logic [7:0] a,
    output logic [2:0] y,
    output logic none
);

always @(*) begin
    y[2] <= (a[7] | a[6]) | ~a[7] & ~a[6] & (a[5] | a[4]);
    y[1] <= a[7] | a[6] | ~a[7] & ~a[6] & ~a[5] & ~a[4] & (a[3] | a[2]);
    y[0] <= a[7] | ~a[7] & ~a[6] & a[5] | ~a[7] & ~a[6] & ~a[5] & ~a[4] & (a[3] | ~a[3] & ~a[2] & a[1]);
    none = ~(a[7] | a[6] | a[5] | a[4] | a[3] | a[2] | a[1] | a[0]);
end

endmodule


module testbench();

    logic clk, reset;
    logic [7:0] a;
    logic [2:0] y;
    logic none;
    logic [2:0] y_expected;
    logic none_expected;

    logic [31:0] errors;

    ex20 dut(a, y, none);

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
        if (a == 0) begin
            none_expected = 1;
            y_expected = 0;
        end
        else if (a[7] == 1) begin
            none_expected = 0;
            y_expected = 7;
        end
        else if (a[6] == 1) begin
            none_expected = 0;
            y_expected = 6;
        end
        else if (a[5] == 1) begin
            none_expected = 0;
            y_expected = 5;
        end
        else if (a[4] == 1) begin
            none_expected = 0;
            y_expected = 4;
        end
        else if (a[3] == 1) begin
            none_expected = 0;
            y_expected = 3;
        end
        else if (a[2] == 1) begin
            none_expected = 0;
            y_expected = 2;
        end
        else if (a[1] == 1) begin
            none_expected = 0;
            y_expected = 1;
        end
        else begin
            none_expected = 0;
            y_expected = 0;
        end
    end

    always @( negedge clk ) begin
        if (~reset) begin
            if (y != y_expected || none != none_expected) begin
                $display("Error: a = %d, y = %d (%d expected), none = %d (%none expected)",
                    a, y, y_expected, none, none_expected);
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