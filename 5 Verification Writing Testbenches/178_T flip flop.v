module top_module ();

    reg clk;
    reg reset;
    reg t;

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 0;
        t = 0;
    end

    initial begin
        repeat(3) @(posedge clk);

        reset = 1;
        repeat(1) @(posedge clk);

        reset = 0;
        t = 1;
        repeat(1) @(posedge clk);
    end

    tff tff_u0(
        .clk(clk),
        .reset(reset),
        .t(t)
    );

endmodule
