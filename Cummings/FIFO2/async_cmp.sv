//	модуль асинхронной генерации флагов full и empty
//	сравнивает между собой указатели записи и чтения
//	и выдает команду на выставление одного из флагов
module	async_cmp #(
	parameter	ADDRSIZE = 4,
	//	выделен номер старшего бита для удобства
	parameter	N = ADDRSIZE - 1
) (
	input		[N:0] wptr,
	input		[N:0] rptr,
	input		wrst_n,
	output		aempty_n,
	output		afull_n
);

//	флаг направления заполнения FIFO
//	0 = going empty = если указатели сравнялись - значит FIFO опустело
//	1 = going full = если указатели сравнялись - значит FIFO заполнилось
reg	direction;

//	для отображения направления заполнения используется защелка
//	подтянутая к 1. Сигнал set подключен к логике проверки 
//	условия going full (wptr опережает rptr на 1 четверь)
//	Сигнал reset подключен к логике проверки условия
//	going empty (wptr отстает от rptr на 1 четверть)
//	Сигналы set и reset - active low!!!
//	Адреса wptr И rptr и их четверти - ЗАКОЛЬЦОВАНЫ!!!!

//	1, к которой подтянута защелка
wire	high = 1'b1;

//	комб логика генерации сигнала set
wire	dirset_n = ~(	(wptr[N] ^ rptr[N-1] & ~(wptr[N-1] ^ rptr[N]) ) );
//	комб логика генерации сигнала reset
wire	dirclr_n = ~(	(~(wptr[N] ^ rptr[N-1] & (wptr[N-1] ^ rptr[N]))) |
		~wrst_n);

//	управление защелкой
always	@(posedge high or negedge dirset_n or negedge dirclr_n) begin
	if 		(!dirclr_n)	direction <= 1'b0;
	else if 	(!dirset_n)	direction <= 1'b1;
	else				direction <= high;
end

//	команда сгенерировать флаг empty - когда указатели равны и 
//	direction = going empty
assign	aempty_n = ~( (wptr == rptr) && !direction);

//	команда сгенерировать флаг full  - когда указатели равны и 
//	direction = going full 
assign	afull_n = ~( (wptr == rptr) && direction);

endmodule
