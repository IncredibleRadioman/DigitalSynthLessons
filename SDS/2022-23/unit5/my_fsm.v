//общий принцип написания КА
module my_fsm (
    //...
);

reg [1:0] STATE;

always @(posedge CLK) begin
    if (RST)
        STATE <= 2'd0;
    else begin
        case  (STATE)
            2'd0: if (IN == 1'b1) STATE <= 2'd2;
                  else STATE <= 2'd1;
            2'd1: if (IN == 1'b1) STATE <= 2'd3;
                  else STATE <= 2'd2;
            //...
        endcase
    end
end
    
endmodule