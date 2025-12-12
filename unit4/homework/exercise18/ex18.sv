module ex18 (
    input logic a,b,c,d,
    output logic y
);

logic [3:0] bus;

assign bus = {a,b,c,d};

always @(*) begin
    case(bus)
        4'b0000 :   y = 1'bx;
        4'b0001 :   y = 1'bx;
        4'b0010 :   y = 1'bx;
        4'b0101 :   y = 1'bx;
        4'b0111 :   y = 1'bx;
        4'b1010 :   y = 1'bx;
        4'b1110 :   y = 1'bx;
        default:    y = b & d | a & ~d | a & c;
    endcase
end
    
endmodule

module testbench();

    logic clk, reset;
    logic a,b,c,d,y,yexpected;

    logic [31:0] vectornum, errors;
    logic [4:0] testvectors[15:0];

    ex18 dut(a,b,c,d,y);

    //  generate clocks
    always begin
        clk = 1; #5; clk = 0; #5;
    end

    //  load vectors and toggle reset
    initial begin
        $readmemb("trtable.tv", testvectors);
        vectornum = 0;
        errors = 0;
        reset = 1; #23; reset = 0;
    end

    //  send test vectors after posedge clk
    always @(posedge clk)
    begin
        #1; {a,b,c,d,yexpected} = testvectors[vectornum];
    end

    //  check results after negedge
    always @(negedge clk)
    begin
        if (~reset) begin
            if (y !== yexpected) begin
                $display("Error: abcd = %b%b%b%b, y = %b (%b expected)", 
                a, b, c, d, y, yexpected);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (vectornum == 16) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;        
            end
        end
    end

endmodule