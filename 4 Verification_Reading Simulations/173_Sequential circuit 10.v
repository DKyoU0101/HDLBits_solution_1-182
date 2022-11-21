module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );

    always @(posedge clk) begin
        state <= (a == b) ? a : state;
    end

    assign q = (a == b) ? state : ~state;

endmodule
