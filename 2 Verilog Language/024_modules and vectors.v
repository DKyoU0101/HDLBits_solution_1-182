module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);

    wire [7:0] q1, q2, q3;

    my_dff8 my_dff8_u1 (
    .clk(clk),
    .d(d),
    .q(q1)
    );

    my_dff8 my_dff8_u2 (
    .clk(clk),
    .d(q1),
    .q(q2)
    );

    my_dff8 my_dff8_u3 (
    .clk(clk),
    .d(q2),
    .q(q3)
    );

    always @(*)
        if (sel == 2'b00) q = d;
        else if (sel == 2'b01) q = q1;
        else if (sel == 2'b10) q = q2;
        else if (sel == 2'b11) q = q3;

endmodule
