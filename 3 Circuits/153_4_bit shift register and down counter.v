module top_module (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);

    initial begin
        q = 0;
    end

    always @(posedge clk) begin
        if(shift_ena) q <= {q[2:0], data};
        else if(count_ena) q <= q - 1; 
    end

endmodule
