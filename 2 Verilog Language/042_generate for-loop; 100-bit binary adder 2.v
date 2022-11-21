module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );

    wire [99:0] new_cin;
    
    assign new_cin = {cout[98:0], cin}; 

    always @(*) begin
        for (int i = 0; i < $bits(cout); i = i + 1) begin
            sum[i] = a[i] ^ b[i] ^ new_cin[i];
            cout[i] = (a[i] & b[i]) | (a[i] & new_cin[i]) |(b[i] & new_cin[i]);
        end
    end

endmodule
