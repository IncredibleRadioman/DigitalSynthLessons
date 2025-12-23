module ex17 (
    input logic a,b,c,d,e,f,g,
    output logic y
);
    assign y = a & b & c | ~d | ~e & (~f | ~g);

endmodule

module testbench();

    logic clk, reset;
    logic a,b,c,d,e,f,g,y,yexpected;
    logic uplogic;
    logic downlogic;
    logic sum;
    logic [6:0] num;
    logic [31:0] errors;

    ex17 dut(a,b,c,d,e,f,g,y);

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
        {a,b,c,d,e,f,g} = num;
        uplogic = ~(~(a & b & c) & d);
        downlogic = ~(e | (f & g));

        sum = ~(uplogic | downlogic);

        yexpected = ~(sum & sum);

    end

    always @(negedge clk ) begin
        if (~reset) begin
            if (y !== yexpected) begin
                errors = errors + 1;
                $display("abcderfg = %b%b%b%b%b%b%b y = %b, yexpected = %b",
                a,b,c,d,e,f,g,y,yexpected);
            end

            num = num + 1;

            if (num == 0) begin
                $display("Test finished with %d errors", errors);
                $finish;
            end
        end
    end

endmodule