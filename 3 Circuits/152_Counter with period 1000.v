module top_module (
    input clk,
    input reset,
    output [9:0] q);

    always @(posedge clk) begin
        if(reset) q <= 0;
        else if(q == 10'd999) q <= 0;
        else q <= q + 1;
    end

endmodule
