module alu (
    input logic [31:0] SrcA,
    input logic [31:0] SrcB,
    input logic [2:0] ALUControl,
    output logic [31:0] ALUResult,
    output logic Zero
);

always_comb begin
    case (ALUControl)
        3'b000: ALUResult = SrcA + SrcB; // +
        3'b001: ALUResult = SrcA - SrcB; // -
        3'b011: ALUResult = SrcA | SrcB; // or/ori
        3'b111: ALUResult = SrcA & SrcB; // and/andi
        3'b010: begin // slt
                    if ( $signed (SrcA) < $signed(SrcB) )
                        ALUResult = 32'd1;
                    else
                        ALUResult = 32'b0;
                end
        end
    endcase 
end
//  флаг равенства нулю
assign Zero = (ALUResult == 32'b0);
    
endmodule