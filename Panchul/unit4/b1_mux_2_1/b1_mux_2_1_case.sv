module	b1_mux_2_1_case
(
	input	d0,
	input	d1,
	input 	sel,
	output	reg y
);

always @(*) begin
	case (sel)
		0 : y = d0;
		1 : y = d1;
	endcase
end

endmodule
