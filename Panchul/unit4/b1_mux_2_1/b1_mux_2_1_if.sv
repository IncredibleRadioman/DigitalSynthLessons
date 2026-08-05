module	b1_mux_2_1_if
(
	input	d0,
	input	d1,
	input	sel,
	output	reg y
);

always @(*) begin
	if (sel)
		y = d1;
	else
		y = d0;
end


endmodule
