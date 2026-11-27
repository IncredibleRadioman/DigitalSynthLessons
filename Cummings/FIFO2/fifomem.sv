//	модуль двухпортовой памяти, которая выступает в качестве буфера FIFO
module	fifomem #(
	parameter	DATASIZE = 8,
	parameter	ADDRSIZE = 4,
	parameter	DEPTH = 1 << ADDRSIZE
) (
	//	порт записи
	//	данные для записи
	input		[DATASIZE-1:0] wdata,
	//	адрес записи
	input		[ADDRSIZE-1:0] waddr,
	//	сигнал разрешения записи
	input		wclken,
	//	тактовый сигнал
	input		wclk,

	//	порт чтения
	//	данные на чтение
	output		[DATASIZE-1:0] rdata,
	//	адрес чтения
	input		[ADDRSIZE-1:0] raddr
);

`ifdef	VENDORRAM
	//	на случай использования IP от производителя
	VENDOR_RAM	MEM(
		.dout(rdata),
		.din(wdata),
		.waddr(waddr),
		.raddr(raddr),
		.wclken(wclken),
		.clk(wclk));
`else
	//	собственная IP
	//	непосредственно память
	reg	[DATASIZE-1:0] MEM[0:DEPTH-1];

	//	чтение - асинхронное, автоматически
	//	выставляется содержимое памяти по raddr
	assign	rdata = MEM[raddr];

	//	запись - синхронная, по восходящему фронту тактового сигнала
	always	@(posedge wclk) begin
		if (	wclken)
			//	записываем когда есть разрешающий сигнал
			MEM[waddr] <= wdata;
	end
`endif

endmodule
