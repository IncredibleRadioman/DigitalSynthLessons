//	синхронизатор сброса
//	позволяет сбрасывать асинхронно
//	а выходить из сброса - синхронно
module	async_resetFFstyle2 (
	//	входной тактовый сигнал
	input		clk,
	//	входной сигнал асинхронного сброса
	input		asyncrst_n,
	//	выходной сигнал сброса для всей оставшейся схемы
	output		reg rst_n);
	
	//	выход первого триггера
	reg		rff1;

	always	@(posedge clk or negedge asyncrst_n) begin
		if (!asyncrst_n)	{rst_n, rff1} <= 2'b0;
		else			{rst_n, rff1} <= {rff1, 1'b1};
	end

endmodule
