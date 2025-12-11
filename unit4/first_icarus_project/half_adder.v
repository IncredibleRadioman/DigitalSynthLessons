module half_adder(input a,b,
	output c, s);
	assign c = a & b;
	assign s = a ^ b;
endmodule

module test();
	reg a, b;
	wire c, s;

	half_adder dut(a,b,c,s);

	initial begin
		$display("a b c s");
		$monitor("%b %b %b %b", a, b, c, s);
		a = 0; b = 0; #10;
		b = 1; #10;
		a = 1; b = 0; #10;
		b = 1; #10;
	end

endmodule
