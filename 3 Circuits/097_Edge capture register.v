module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);

    reg [31:0] in_dly;

    always @(posedge clk) begin
        in_dly <= in;
    end

    always @(posedge clk) begin
        if(reset) out <= 32'd0;
        else if(~in & in_dly) out <= ~in & in_dly | out;
    end

endmodule
