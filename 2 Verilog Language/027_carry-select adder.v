module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

    wire [16:0] a_lower  =  a[15: 0];
    wire [16:0] a_higher =  a[31:16];
    wire [16:0] b_lower  =  b[15: 0];
    wire [16:0] b_higher =  b[31:16];
    
    wire cout1, cout2, cout3;

    wire [15:0] sum_lower;
    wire [15:0] sum_higher_0;
    wire [15:0] sum_higher_1;
    wire [15:0] sum_higher;


    // lower bit
    add16 add16_u1 (.a(a_lower), .b(b_lower), .cin(1'b0), .cout(cout1), .sum(sum_lower));
    // higher bit, carry = 0
    add16 add16_u2 (.a(a_higher), .b(b_higher), .cin(1'b0), .cout(cout2), .sum(sum_higher_0));
    // higher bit, carry = 1
    add16 add16_u3 (.a(a_higher), .b(b_higher), .cin(1'b1), .cout(cout3), .sum(sum_higher_1));

    assign sum_higher = (cout1 ?  sum_higher_1 : sum_higher_0);
    assign sum = {sum_higher, sum_lower};


endmodule
