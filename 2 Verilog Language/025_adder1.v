module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

    wire [16:0] a_lower  =  a[15: 0];
    wire [16:0] a_higher =  a[31:16];
    wire [16:0] b_lower  =  b[15: 0];
    wire [16:0] b_higher =  b[31:16];

    wire cout1;
    wire cout2;
    wire [15:0] sum_lower;
    wire [15:0] sum_higher;

    add16 add16_u1 (.a(a_lower), .b(b_lower), .cin(1'b0), .cout(cout1), .sum(sum_lower)); // lower bit
    add16 add16_u2 (.a(a_higher), .b(b_higher), .cin(cout1), .cout(cout2), .sum(sum_higher)); // higher bit

    assign sum = {sum_higher, sum_lower};

endmodule
