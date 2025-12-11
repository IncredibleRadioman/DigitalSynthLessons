module exercise1 (
    input logic a,b,c,
    output logic y, z
);

    assign y = a & (b | c);
    assign z = ~(a ^ b);
    
endmodule

module testbench();
    logic a,b,c;
    wire y,z;
    logic yexpected, zexpected;

    exercise1 dut(a,b,c,y,z);

    assign yexpected = a & b & c |a & b & ~c | a & ~b & c;
    assign zexpected = a & b | ~a & ~b;

    initial begin
        a = 0; b = 0; c = 0; #10;
        if (y != yexpected)
            $error("000 failed. Y is wrong.");
        if (z != zexpected)
            $error("000 failed. Z is wrong.");
        c = 1; #10;
        if (y != yexpected)
            $error("001 failed. Y is wrong.");
        if (z != zexpected)
            $error("001 failed. Z is wrong.");
        b = 1; c = 0; #10;
        if (y != yexpected)
            $error("010 failed. Y is wrong.");
        if (z != zexpected)
            $error("010 failed. Z is wrong.");
        c = 1; #10;
        if (y != yexpected)
            $error("011 failed. Y is wrong.");
        if (z != zexpected)
            $error("011 failed. Z is wrong.");
        a = 1; b = 0; c = 0; #10;
        if (y != yexpected)
            $error("100 failed. Y is wrong.");
        if (z != zexpected)
            $error("100 failed. Z is wrong.");
        c = 1; #10;
        if (y != yexpected)
            $error("101 failed. Y is wrong.");
        if (z != zexpected)
            $error("101 failed. Z is wrong.");
        b = 1; c = 0; #10;
        if (y != yexpected)
            $error("110 failed. Y is wrong.");
        if (z != zexpected)
            $error("110 failed. Z is wrong.");
        c = 1; #10;
        if (y != yexpected)
            $error("111 failed. Y is wrong.");
        if (z != zexpected)
            $error("111 failed. Z is wrong.");
        $display("Done.");
    end
endmodule