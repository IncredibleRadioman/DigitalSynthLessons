//	FIFO Style #2
//	модуль верхнего уровня
//	отражает полную структуру схемы
module	fifo2 #(
	parameter	DSIZE = 8,
	parameter	ASIZE = 4
) (
	//	записывающая сторона
	//	вход данных
	input		[DSIZE-1:0] wdata,
	//	валидность данных со стороны отправл устройства
	input		winc,
	//	тактирование
	input		wclk,
	//	сброс
	input		wrst_n,
	//	флаг full
	output		wfull,

	//	читающая сторона
	//	выход данных
	output		[DSIZE-1:0] rdata,
	//	готовность приемного устройства забрать данные
	output		rinc,
	//	тактирвание
	output		rclk,
	//	сброс
	output		rrst_n,
	//	флаг empty
	output		rempty
);

//	указатели записи и чтения
wire	[ASIZE-1:0] wptr, rptr;
//	адреса в FIFO (они равны указателям)
wire	[ASIZE-1:0] waddr, raddr;

//	асинхронный генератор флагов full и empty
//	отправляет КОМАНДЫ на установку флагов
//	сравнивая указатели
async_cmp	#(ASIZE) async_cmp(
	.aempty_n(aempty_n),
	.afull_n(afull_n),
	.wptr(wptr),
	.rptr(rptr),
	.wrst_n(wrst_n));

//	буфер памяти (как правило Dual-Port RAM)
fifomem 	#(DSIZE, ASIZE) fifomem(
	.rdata(rdata),
	.wdata(wdata),
	.waddr(wptr),
	.raddr(rptr),
	.wclken(winc),
	.wclk(wclk));

//	счетчик Грея стиль 2 для указателя чтения
//	плюс обрабатывает команду на установку флага empty
//	сообщая приемному устройству об опустошении FIFO
rptr_empty	#(ASIZE) rptr_empty(
	.rempty(rempty),
	.rptr(rptr),
	.aempty_n(aempty_n),
	.rinc(rinc),
	.rclk(rclk),
	.rrst_n(rrst_n));	


//	счетчик Грея стиль 2 для указателя записи
//	плюс обрабатывает команду на установку флага full 
//	сообщая отправл устройству о переполнении FIFO
wptr_full 	#(ASIZE) wptr_full (
	.wfull(wfull),
	.wptr(wptr),
	.afull_n(afull_n),
	.winc(winc),
	.wclk(wclk),
	.wrst_n(wrst_n));	

endmodule
