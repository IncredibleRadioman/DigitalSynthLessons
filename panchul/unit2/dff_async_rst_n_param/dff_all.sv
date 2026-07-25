module dff_all
#(
    parameter   WIDTH = 8,
                RESET = 8'b0
)
(
    input   clk,
    input   rst_n, //	асинхронный сброс
	input 	sclr, // сигнал синхронной очистки
	input	en, // сигнал разрешения
    input   [WIDTH - 1 : 0] d,
    output  reg [WIDTH - 1 : 0] q
);

    always @(posedge clk or negedge rst_n)
    begin
        if (    !rst_n)
            q <= RESET;
        else if (	sclr)
            q <= RESET;
		else if (	en)
			q <= d;
    end

endmodule