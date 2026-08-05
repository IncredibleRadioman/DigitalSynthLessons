`timescale 1ns / 1ps

module testbench;

reg    [3:0] binary_in;
wire     [15:0] binary_out;
reg    enable;
integer i;

b7_4bit_dec_assign_shift dut (
    .binary_in(binary_in),
    .decoder_out(binary_out),
    .enable(enable)
);



initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

initial begin

    $monitor("%0d binary_in %b binary_out %b enable %b",
                $time, binary_in, binary_out, enable);
    
    enable = 1;
    for (i = 0; i <= 4'b1111; i = i + 1) begin
        #2; binary_in = i;
    end

    $finish;
end




endmodule