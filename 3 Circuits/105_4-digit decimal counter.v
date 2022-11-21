module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    wire ena_0;

    always @(posedge clk or negedge reset) begin
        if(~reset) ena_0 <= 1;
        else ena_0 <= 0;
    end
    
    // assign ena3_0[0] = ~reset;
    assign ena[1] = (ena_0) & (q[ 3:0] == 4'd9);
    assign ena[2] = (ena[1]) & (q[ 7:4] == 4'd9);
    assign ena[3] = (ena[2]) & (q[11:8] == 4'd9);

    BCD_counter BCD_counter_u0[3:0] (
        .clk({4{clk}}),
        .reset({4{reset}}),
        .ena({ena, ena_0}),
        .q(q)
    );

endmodule



module BCD_counter (
    input clk, reset, ena,
    output reg [3:0] q
);

    always @(posedge clk) begin
        if(reset) q <= 4'b0;
        else if(ena)
            if(q == 4'd9) q <= 4'd0;
            else q <= q + 1; 
    end

endmodule
