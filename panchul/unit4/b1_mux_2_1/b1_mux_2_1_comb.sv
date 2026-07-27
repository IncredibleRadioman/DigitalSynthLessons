module	b1_mux_2_1_comb
(
	input 	d0,
	input 	d1,
	input 	sel,
	output 	y
);

	assign y = (sel & d1) | ((~sel) & d0);

endmodule
