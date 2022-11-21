module top_module();

    reg clk;
    reg in;
    reg [2:0] s;

    q7 q7_u0(
        .clk(clk),
        .in(in),
        .s(s)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;

        in = 0;
        s = 2;
        repeat(1) @(negedge clk);

        s = 6;
        repeat(1) @(negedge clk);

        in = 1;
        s = 2;
        repeat(1) @(negedge clk);

        in = 0;
        s = 7;
        repeat(1) @(negedge clk);

        in = 1;
        s = 0;
        repeat(3) @(negedge clk);

        in = 0;
        repeat(1) @(negedge clk);
    end

endmodule
