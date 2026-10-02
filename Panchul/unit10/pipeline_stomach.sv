module      pipeline_stomach #(
    parameter   WIDTH = 8
) (
    input       clk,
    input       rst_n,

    input       [(WIDTH - 1) : 0] up_data,
    input       up_valid,
    output      up_ready,

    output      [(WIDTH - 1) : 0] down_data,
    output      down_valid,
    input       down_ready
);

wire            stomach_load;
wire            dataout_load;
wire            dataout_unload;
reg             mux_select;

wire            [(WIDTH - 1) : 0] data_in;
reg             [(WIDTH - 1) : 0] stomach_out;
reg             [(WIDTH - 1) : 0] mux_out;
reg             [(WIDTH - 1) : 0] data_out;

reg             data_in_dataout;
reg             data_in_stomach;

assign          data_in = up_data;
assign          down_valid = data_in_dataout;
assign          dataout_unload = down_valid & down_ready;

assign          dataout_load = (up_valid & 
                (! data_in_dataout | dataout_unload)) | 
                (data_in_stomach & dataout_unload);
assign          stomach_load = up_valid & 
                ! data_in_stomach & 
                (data_in_dataout & ! dataout_unload);
assign          up_ready = ! data_in_stomach;

always @ (posedge clk or negedge rst_n) begin
    if (! rst_n) begin
        data_in_stomach <= 1’b0;
        data_in_dataout <= 1’b0;
    end
    else begin
        data_in_stomach <= stomach_load | (data_in_stomach & !
                            dataout_unload);
        data_in_dataout <= dataout_load | data_in_stomach |
                            (data_in_dataout & ! dataout_unload);
    end
end

always @ (posedge clk or negedge rst_n) begin
    if (! rst_n) begin
        mux_select <= 1’b0;
    end
    else begin
        mux_select <= stomach_load | (mux_select & ! dataout_load);
    end
end

always @ (posedge clk or negedge rst_n) begin
    if (! rst_n) begin
        stomach_out <= { width { 1’b0 } };
    end
    else if (stomach_load) begin
        stomach_out <= data_in;
    end
end


always @(*) begin
    mux_out = mux_select ? stomach_out : data_in;
end

always @ (posedge clk or negedge rst_n) begin
    if (! rst_n) begin
        data_out <= { width { 1’b0 } };
    end
    else if (dataout_load) begin
        data_out <= mux_out;
    end
end

assign down_data = data_out;

endmodule