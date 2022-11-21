module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );

    wire [99:0] fadd_cin;
    wire [99:0] fadd_cout;

    assign fadd_cin = {fadd_cout[98:0], cin};

    generate 
        genvar i;
        for (i = 0; i < 8'd100; i = i + 1) begin: BCD_loop
                bcd_fadd bcd_fadd_u0 (
                    .a(a[(i*4+3):(i*4)]),
                    .b(b[(i*4+3):(i*4)]),
                    .cin(fadd_cin[i]),
                    .cout(fadd_cout[i]),
                    .sum(sum[(i*4+3):(i*4)]) 
                );
        end 
    endgenerate

    assign cout = fadd_cout[99];

    

endmodule


// //다른 풀이: 인스턴스 배열 사용
// module top_module( 
//     input [399:0] a, b,
//     input cin,
//     output cout,
//     output [399:0] sum );

//     wire [99:0] fadd_cin;
//     wire [99:0] fadd_cout;

//     assign fadd_cin = {fadd_cout[98:0], cin};


//     bcd_fadd bcd_fadd_u0 [99:0](
//         .a(a),
//         .b(b),
//         .cin(fadd_cin),
//         .cout(fadd_cout),
//         .sum(sum) 
//     );

//     assign cout = fadd_cout[99];


// endmodule
