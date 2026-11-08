//  КА с 4 состояниями и 1 блоком always
module      fsm_cc4_1 (
    //  входы
    input   dly,
    input   done,
    input   req,

    //  тактирование и сброс
    input   clk,
    input   rst_n,

    //  выход
    output  reg gnt
);

//  описание состояний
parameter   [1:0] IDLE = 2'b00;
parameter   [1:0] BBUSY = 2'b01;
parameter   [1:0] BWAIT = 2'b10;
parameter   [1:0] BFREE = 2'b11;

//  для следующего состояния провод не нужен
//  только для текущего
reg         [1:0] state;

always  @(posedge clk or negedge rst_n) begin

    //  сброс
    if (    !rst_n) begin
        state <= IDLE;
        gnt <= 1'b0;
    end
    else begin

        state <= 2'bx;
        gnt <= 1'b0;

        case (state)

            IDLE :  if (req) begin
                                state <= BBUSY;
                        gnt <= 1'b1;
                    end
                    else        state <= IDLE;
            BBUSY : if (!done) begin
                                state <= BBUSY;
                        gnt <= 1'b1;
                    end
                    else if (dly) begin
                                state <= BWAIT;
                        gnt <= 1'b1;
                    end
                    else        state <= BFREE;
            BWAIT : if (dly) begin
                                state <= BWAIT;
                        gnt <= 1'b1;
                    end
                    else        state <= BFREE;
            BFREE : if (req) begin
                                state <= BBUSY;
                        gnt <= 1'b1;
                    end 
                    else        state <= IDLE;
        endcase

    end

end

endmodule