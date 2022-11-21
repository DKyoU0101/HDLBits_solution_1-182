module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);

    wire cout1, cout2;
    wire [31:0]exc_b;

    assign exc_b = sub ? ~b : b; // XOR

    add16 add16_u1 (.a(a[15: 0]), .b(exc_b[15: 0]), .cin(sub),  .sum(sum[15: 0]), .cout(cout1));
    add16 add16_u2 (.a(a[31:16]), .b(exc_b[31:16]), .cin(cout1), .sum(sum[31:16]), .cout(cout2));

endmodule
