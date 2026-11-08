//  КА с 10 состояниями
//  1 блок always
module  fsm_cc7_1 (
    //  входные сигналы
    input       jmp,
    input       go,
    //  тактирование и сброс
    input       clk,
    input       rst_n,
    //  выходной сигнал
    output      reg y1
);

//  объявление состояний
parameter   S0 = 4'b0000,
            S1 = 4'b0001,
            S2 = 4'b0010,
            S3 = 4'b0011,
            S4 = 4'b0100,
            S5 = 4'b0101,
            S6 = 4'b0110,
            S7 = 4'b0111,
            S8 = 4'b1000,
            S9 = 4'b1001;

//  для следующего состояния провод не нужен
//  только для текущего
reg         [3:0] state;

always  @(posedge clk or negedge rst_n) begin

    if (    !rst_n) begin
        //  сброс
        state <= S0;
        y1 = 1'b0;
    end
    else begin
        y1 <= 1'b0;
        state <= 4'bx;
        case (state)
        
            S0 :    if (!go)        state <= S0;
                    else if (jmp) begin
                        y1 <= 1'b1;
                                    state <= S3;
                    end
                    else            state <= S1;
            S1 :    if (jmp) begin
                        y1 <= 1'b1;
                                    state <= S3;
                    end
                    else            state <= S2;
            S2 :    begin
                        y1 <= 1'b1;
                                    state <= S3;
                    end
            S3 :    if (jmp) begin
                        y1 <= 1'b1;
                                    state <= S3;
                    end
                    else            state <= S4;
            S4 :    if (jmp) begin
                        y1 <= 1'b1;
                                    state <= S3;
                    end
                    else            state <= S5;
            S5 :    if (jmp) begin
                        y1 <= 1'b1;
                                    state <= S3;
                    end
                    else            state <= S6;
            S6 :    if (jmp) begin
                        y1 <= 1'b1;
                                    state <= S3;
                    end
                    else            state <= S7;
            S7 :    if (jmp) begin
                        y1 <= 1'b1;
                                    state <= S3;
                    end
                    else            state <= S8;
            S8 :    if (jmp) begin
                        y1 <= 1'b1;
                                    state <= S3;
                    end
                    else            state <= S9;
            S9 :    if (jmp) begin
                        y1 <= 1'b1;
                                    state <= S3;
                    end
                    else            state <= S0;
        endcase

    end

end


endmodule