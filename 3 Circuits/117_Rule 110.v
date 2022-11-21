module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 

    wire [511:0] next_s;

    rule_110 rule_110_u0[511:0] (
        .left({1'b0, q[511:1]}), 
        .center(q), 
        .right({q[510:0], 1'b0}), 
        .next_s(next_s)
    );

    always @(posedge clk) begin
        if(load) q <= data;
        else q <= next_s;
    end

endmodule


module rule_110 (
    input left, center, right,
    output next_s
);

    always @(*) begin
        case ({left, center, right})
            3'd0: next_s = 0;
            3'd1: next_s = 1;
            3'd2: next_s = 1;
            3'd3: next_s = 1;
            3'd4: next_s = 0;
            3'd5: next_s = 1;
            3'd6: next_s = 1;
            3'd7: next_s = 0;
        endcase
    end
    
endmodule
