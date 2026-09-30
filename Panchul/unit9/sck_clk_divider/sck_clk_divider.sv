module  register #(
    parameter   SIZE = 4
) (
    input       clk,
    input       rst_n,
    input       [(SIZE - 1) : 0] din,
    output      reg [(SIZE - 1) : 0] dout
);

always  @(posedge clk or negedge rst_n) begin
    if (    !rst_n) begin
        dout <= {SIZE{1'b0}};
    end
    else begin
        dout <= din;
    end
end

endmodule


module  sck_clk_divider (
    input       clk,
    input       rst_n,
    output      sck,
    output      sck_edge
);

wire            [3:0] cnt;
wire            [3:0] cntNext = cnt + 1;
register        #(.SIZE(4)) r_cnt (
    .clk(clk),
    .rst_n(rst),
    .din(cntNext),
    .dout(cnt)
);

//  читай описание, sck просто присоединен к 3 биту,
//  так делится clk на 8
assign  sck = cnt[3];
//  а sck_edge выдается при равенстве выхода 4'b1000
assign  sck_edge = (cnt == 4'b1000);


endmodule