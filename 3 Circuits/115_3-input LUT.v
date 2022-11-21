module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 

    reg [7:0] ram;

    always @(posedge clk) begin
        if(enable) ram <= {ram[6:0], S};
    end

    always @(*) begin
        case ({A, B, C})
            3'd0: Z = ram[0];
            3'd1: Z = ram[1];
            3'd2: Z = ram[2];
            3'd3: Z = ram[3];
            3'd4: Z = ram[4];
            3'd5: Z = ram[5];
            3'd6: Z = ram[6];
            3'd7: Z = ram[7];
        endcase
    end

endmodule
