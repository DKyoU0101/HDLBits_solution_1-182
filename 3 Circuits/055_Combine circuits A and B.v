module top_module (input x, input y, output z);

    wire z1, z2, z3, z4;

    IA IA_u0 (.x(x), .y(y), .z(z1));
    IB IB_u0 (.x(x), .y(y), .z(z2));
    IA IA_u1 (.x(x), .y(y), .z(z3));
    IB IB_u1 (.x(x), .y(y), .z(z4));

    assign z = (z1 | z2) ^ (z3 & z4);

endmodule


module IA (input x, input y, output z);
    assign z = (x^y) & x;
endmodule


module IB (input x, input y, output z);
    assign z = ~(x ^ y);
endmodule