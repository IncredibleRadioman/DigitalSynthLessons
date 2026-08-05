module	b1_mux_2_1_sel
(
	input	d0,
	input	d1,
	input	sel,
	output	y
);

	assign y = sel ? d1 : d0;
endmodule	
