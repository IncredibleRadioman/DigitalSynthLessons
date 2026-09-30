module      pmod_als_stub #(
    parameter   value = 8'hAB
) (
    input       cs,
    input       sck,
    output      sdo
);

wire            [7:0] tvalue = value;
wire            [15:0] tpacket = {3'b0, tvalue, 4'b0, 1'bz};

reg             [15:0] buffer;
reg             sdata;

assign          sdo = cs ? 1'bz : sdata;

always  @(negedge sck or posedge cs) begin

if (    !cs) begin
    //  при CS = 0 (схема выбрана) выдаем побитово tvalue
    //  tpacket имитирует сеанс передачи
    {sdata, buffer} <= {buffer, 1'b0};
end
else begin
    //  при CS = 1 (схема не выбрана) выдаем на SDO постоянный 0
    {sdata, buffer} <= {1'b0, tpacket};
end

endmodule