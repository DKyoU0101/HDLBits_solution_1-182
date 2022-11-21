module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output reg done); //

    reg [3:1] byt, n_byt; // byte: 변수명으로 불가

    // State transition logic (combinational)
    always @(*) begin
        n_byt[3] = byt[2];
        n_byt[2] = (in[3]) ? (byt[1] | done) : 0;
        n_byt[1] = (~in[3]) ? (byt[1] | done) : 0;
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if(reset) byt <= 3'b001;
        else byt <= n_byt;
    end
 
    // Output logic
    always @(posedge clk) begin
        if(reset) done <= 0;
        else if(byt[3]) done <= 1;
        else done <= 0;
    end

endmodule
