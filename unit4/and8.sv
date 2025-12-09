module and8(input logic [7:0] a,
	output logic y);
	// it's like y = a[7] & a[6] & ... & a[0]
	assign y = &a;
endmodule
