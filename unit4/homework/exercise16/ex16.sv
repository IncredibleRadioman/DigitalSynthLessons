module ex16(
    input logic a,b,c,d,e,
    output logic y
);

    assign y = (~a | ~b) & (~c | ~d) | ~e;

endmodule

module testbench();

    logic clk, reset;
    logic a,b,c,d,e,y, yexpected;

    logic [31:0] errors;
    logic [4:0] num;

    ex16 dut(a,b,c,d,e,y);

    always begin
        clk = 1; #5; clk = 0; #5;
    end

    initial begin
        errors = 0;
        num = 0;
        reset = 1; #23; reset = 0;
    end

    always @(posedge clk) begin
        #1; 
        {a,b,c,d,e} = num;
        yexpected = ~(~(~(a & b) & ~(c & d)) & e);
    end

    always @(negedge clk) begin
        if (~reset) begin
            if (y !== yexpected) begin
                $display("Error : abcde = %b%b%b%b%b, y = %b (yexpected = %b)",
                    a,b,c,d,e,y,yexpected);
                errors = errors + 1;
            end

            num = num + 1;

            if (num == 0) begin
                $display("Test finished with %d errors", errors);
                $finish;
            end

        end
    end

endmodule