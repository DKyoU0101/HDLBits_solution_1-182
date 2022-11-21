module top_module( 
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);

    always @(*) begin
        if (~x3 & ~x2 & ~x1) f = 1'b0;
        else if (~x3 & ~x2 & x1) f = 1'b0;
        else if (x3 & ~x2 & ~x1) f = 1'b0;
        else if (x3 & x2 & ~x1) f = 1'b0;
        else f = 1'b1;
    end

endmodule
