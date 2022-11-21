module top_module();

    reg [1:0] in;

    andgate andgate_u0(
        .in(in)
    );

    initial begin
        in = 0;
        #10;

        in = 1;
        #10;

        in = 2;
        #10;

        in = 3;
        #10;

    end

endmodule
