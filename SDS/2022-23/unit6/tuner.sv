module zero_crossing_tuner (
    input clk,
    input reset,
    input logic [15:0] value,
    output logic [15:0] distance
);

logic [19:0] counter;
logic [19:0] distance;

logic [15:0] value;
logic [15:0] prev_value;

localparam [15:0] threshold = 16'h1100;

always @(posedge clk or posedge reset) begin
    if (reset)
    begin
        prev_value = 16'h0;
        counter <= 20'h0;
        distance <= 20'h0;
    end
    else begin
        prev_value <= value;
        if (value >= threshold &
            prev_value < threshold) begin
            distance <= counter;
            counter <= 20'h0;
        end
        else if (counter != ~20'h0)
        begin 
            counter <= counter + 20'h1;
        end
    end
end
    
endmodule