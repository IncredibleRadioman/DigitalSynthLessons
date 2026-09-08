`timescale 1ns/1ns

module  testbench;

reg     clk;
reg     we;
reg     [7:0] data_in;
reg     [3:0] write_addr;
reg     [3:0] read_addr;
wire    [7:0] data_out;

//  устройство для исследования
dual_port_RAM #(
    .DATA_WIDTH(8),
    .ADDR_WIDTH(4)
) dut (
    .clk(clk),
    .we(we),
    .data_in(data_in),
    .write_addr(write_addr),
    .read_addr(read_addr),
    .data_out(data_out)
);

initial begin

    clk = 1;
    write_addr = 4'b0000;
    read_addr = 4'b0000;
    data_in = 8'b00001111;
    we = 1'b1;

    repeat(3) begin
        #40;
        data_in = data_in + 8'b00000001;
        write_addr = write_addr + 4'b0001;
    end

    //  чтение
    we = 1'b0;
    read_addr = 4'b0000;

    repeat(3) begin
        #40;
        read_addr = read_addr + 4'b0001;
    end

end

always #20 clk = ~clk;

initial begin
    #760 $finish;
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

endmodule