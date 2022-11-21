module top_module (input a, input b, input c, output out);//

    // andgate inst1 ( a, b, c, out );

    wire and_out;
    andgate inst1 (.out(and_out), .a(a), .b(b), .c(c), .d(1'b1), .e(1'b1));

    assign out = ~and_out;

endmodule
