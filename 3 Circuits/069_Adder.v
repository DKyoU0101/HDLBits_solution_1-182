module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);

    wire [3:0] cin, cout;
    
    assign cin = {cout[2:0], 1'b0};
    assign cout = (x&y) | (x&cin) | (y&cin);
    assign sum = {cout[3], x ^ y ^ cin};

endmodule
