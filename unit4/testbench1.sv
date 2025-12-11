module testbench1 ();

    logic a,b,c,y;
    //  DUT
    sillyfunction dut(a, b, c, y);

    //  activate inputs step-by-step with intervals
    initial begin
        a = 0; b = 0; c = 0;    #10;
        c = 1;                  #10;
        b = 1; c = 0;           #10;
        c = 1;                  #10;
        a = 1; b = 0; c = 0;    #10;
        c = 1;                  #10;
        b = 1; c = 0;           #10;
        c = 1;                  #10;
    end     
endmodule