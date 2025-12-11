module testbench2 ();

    logic a,b,c,y;

    //  DUT
    sillyfunction dut(a, b, c, y);
        //  activate inputs step-by-step with intervals
    initial begin
        a = 0; b = 0; c = 0;    #10;
        assert (y === 1) else $error("000 failed");
        c = 1;                  #10;
        assert (y === 0) else $error("001 failed");
        b = 1; c = 0;           #10;
        assert (y === 0) else $error("010 failed");
        c = 1;                  #10;
        assert (y === 0) else $error("011 failed");
        a = 1; b = 0; c = 0;    #10;
        assert (y === 1) else $error("100 failed");
        c = 1;                  #10;
        assert (y === 1) else $error("101 failed");
        b = 1; c = 0;           #10;
        assert (y === 0) else $error("110 failed");
        c = 1;                  #10;
        assert (y === 0) else $error("111 failed");
    end
    
endmodule