/*
7-segment indicator

     a
     - 
   f| |b
     g
     -
   e| |c
     -
     d
*/

module sevenseg (
    input logic [3:0] data,
    output logic [6:0] segments
);
    
    always @(*)
        case (data)
          0:      segments = 7'b111_1110;
          1:      segments = 7'b011_0000;
          2:      segments = 7'b110_1101;
          3:      segments = 7'b111_1001;
          4:      segments = 7'b011_0011;
          5:      segments = 7'b101_1011;
          6:      segments = 7'b101_1111;
          7:      segments = 7'b111_0000;
          8:      segments = 7'b111_1111;
          9:      segments = 7'b111_1011;
          10:     segments = 7'b111_0111;
          11:     segments = 7'b001_1111;
          12:     segments = 7'b100_1110;
          13:     segments = 7'b011_1101;
          14:     segments = 7'b100_1111;
          15:     segments = 7'b100_0111;
        default:  segments=7'b000_0000;
        endcase

endmodule

module testbench();
  logic clk, reset;
  logic [3:0] a;
  logic [6:0] y, yexpected;

  logic [31:0] vectornum, errors;
  logic [11:0] testvectors[15:0];

  sevenseg dut(a, y);

  //  generate clocks
  always begin
    clk = 1; #5; clk = 0; #5;
  end

  //  load vectors after start and send reset
  initial begin
    $readmemb("trtable.tv", testvectors);
    vectornum = 0; errors = 0;
    reset = 1; #23; reset = 0;
    $display("Data was loaded");
  end

  //  send test vectors after posedge clk
  always @(posedge clk)
  begin
    #1; {a, yexpected} = testvectors[vectornum];
  end

  //  check results after nedegde clk
  always @(negedge clk)
  begin
    if (~reset) begin
      //check results
      if (y !== yexpected) begin
            $display("Error: a = %b, y = %b (%b expected)", 
                a, y, yexpected);
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