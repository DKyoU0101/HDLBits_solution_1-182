module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );

    wire [2:0] new_cin;
    
    assign new_cin = {cout[1:0], cin};

    assign cout = (a&b) | (a&new_cin) | (b&new_cin);
    assign sum = a ^ b ^ new_cin;

endmodule
