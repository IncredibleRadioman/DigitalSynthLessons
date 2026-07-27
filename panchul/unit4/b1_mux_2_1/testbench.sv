`timescale 1ns / 1ps

module testbench;


reg d0, d1, sel;
wire y_comb;
wire y_sel;
wire y_if;
wire y_case;
wire y_concat;


b1_mux_2_1_comb dut(
	.d0(d0),
	.d1(d1),
	.sel(sel),
	.y(y_comb)
);
b1_mux_2_1_sel dut2(
	.d0(d0),
	.d1(d1),
	.sel(sel),
	.y(y_sel)
);
b1_mux_2_1_if dut3(
	.d0(d0),
	.d1(d1),
	.sel(sel),
	.y(y_if)
);
b1_mux_2_1_case dut4(
	.d0(d0),
	.d1(d1),
	.sel(sel),
	.y(y_case)
);
b1_mux_2_1_concat dut5(
	.d0(d0),
	.d1(d1),
	.sel(sel),
	.y(y_concat)
);

initial begin
	$dumpfile("wave.vcd");
	$dumpvars;
end

initial begin
	$monitor(
	"%0d d0 %b d1 %b sel %b y_comb %b y_sel %b y_if %b y_case %b y_concat %b",
		$time, d0, d1, sel, y_comb, y_sel, y_if, y_case, y_concat);
	d0 = 0;
	d1 = 1;
	#5;
	sel = 0;
	#10;
	sel = 1;
	#10;
	d1 = 0;
	#5;
	d1 = 1;
	#5;
	$finish;
end

endmodule
