module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );

    wire [3:0] cout_fadd;

    bcd_fadd bcd_fadd_u0[3:0] (
            .a(a),
            .b(b),
            .cin({cout_fadd[2:0], cin}),
            .cout(cout_fadd),
            .sum(sum)
    );

    assign cout = cout_fadd[3];

endmodule
