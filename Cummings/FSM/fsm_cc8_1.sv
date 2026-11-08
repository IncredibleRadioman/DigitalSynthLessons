//  КА с 10 состояниями
//  1 блок always 
//  множество выходов и входов
module  fsm_cc8_1 (
    //  входы
    input       jmp,
    input       go,
    input       sk0,
    input       sk1,
    //  тактирование и сброс
    input       clk,
    input       rst_n,
    //  выходы
    output      reg y1,
    output      reg y2,
    output      reg y3
);

//  описание состояний
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

always @(posedge clk or negedge rst_n) begin

    if (!rst_n) begin
                                                state <= S0;
        y1 <= 1'b0;
        y2 <= 1'b0;
        y3 <= 1'b0;
    end
    else begin
                                                state <= 4'bx;
        y1 <= 1'b0;
        y2 <= 1'b0;
        y3 <= 1'b0;

        case (state)
        
            S0 :    if (!go)                    state <= S0;
                    else if (jmp) begin
                                                state <= S3;
                        y1 <= 1'b1;
                        y2 <= 1'b1;
                    end
                    else begin
                                                state <= S1;
                        y2 <= 1'b1;
                    end
            S1 :    if (jmp) begin
                                                state <= S3;
                        y1 <= 1'b1;
                        y2 <= 1'b1;
                    end
                    else                        state <= S2;
            S2 :    if (jmp) begin
                                                state <= S3;
                        y1 <= 1'b1;
                        y2 <= 1'b1;
                    end
                    else begin
                                                state <= S9;
                        y1 <= 1'b1;
                        y2 <= 1'b1;
                        y3 <= 1'b1;
                    end
            S3 :    if (jmp) begin
                                                state <= S3;
                        y1 <= 1'b1;
                        y2 <= 1'b1;
                    end
                    else                        state <= S4;
            S4 :    if (jmp) begin
                                                state <= S3;
                        y1 <= 1'b1;
                        y2 <= 1'b1;
                    end
                    else if (sk0 && !jmp) begin
                                                state <= S6;
                        y1 <= 1'b1;
                        y2 <= 1'b1;
                        y3 <= 1'b1;
                    end
                    else                        state <= S5;
            S5 :    if (jmp) begin
                                                state <= S3;
                        y1 <= 1'b1;
                        y2 <= 1'b1;
                    end
                    else if (!sk1 && !sk0 && !jmp) begin
                                                state <= S6;
                        y1 <= 1'b1;
                        y2 <= 1'b1;
                        y3 <= 1'b1;
                    end
                    else if (!sk1 && sk0 && !jmp) begin
                                                state <= S7;
                        y3 <= 1'b1;
                    end
                    else if (sk1 && !sk0 && !jmp) begin
                                                state <= S8;
                        y2 <= 1'b1;
                        y3 <= 1'b1;
                    end
                    else begin
                                                state <= S9;
                        y1 <= 1'b1;
                        y2 <= 1'b1;
                        y3 <= 1'b1;
                    end
            S6 :    if (jmp) begin
                                                state <= S3;
                        y1 <= 1'b1;
                        y2 <= 1'b1;
                    end
                    else if (go && !jmp) begin
                                                state <= S7;
                        y3 <= 1'b1;
                    end
                    else begin
                                                state <= S6;
                        y1 <= 1'b1;
                        y2 <= 1'b1;
                        y3 <= 1'b1;
                    end
            S7 :    if (jmp) begin
                                                state <= S3;
                        y1 <= 1'b1;
                        y2 <= 1'b1;
                    end
                    else begin
                                                state <= S8;
                        y2 <= 1'b1;
                        y3 <= 1'b1;
                    end
            S8 :    if (jmp) begin
                                                state <= S3;
                        y1 <= 1'b1;
                        y2 <= 1'b1;
                    end
                    else begin
                                                state <= S9;
                        y1 <= 1'b1;
                        y2 <= 1'b1;
                        y3 <= 1'b1;
                    end
            S9 :    if (jmp) begin
                                                state <= S3;
                        y1 <= 1'b1;
                        y2 <= 1'b1;
                    end
                    else                        state <= S0;

        endcase
    end
end

endmodule