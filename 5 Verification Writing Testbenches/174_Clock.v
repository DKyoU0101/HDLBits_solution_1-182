module top_module ( );

    reg clk;

    always #5 clk = ~clk;

    initial begin
        `probe_start
        clk = 0;
    end

    dut dut_u0(.clk(clk));

endmodule
