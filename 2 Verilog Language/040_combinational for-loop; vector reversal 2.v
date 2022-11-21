module top_module( 
    input [99:0] in,
    output [99:0] out
);

    reg [7:0] cnt;

    always @(*) begin
        for (cnt = 8'd0; cnt < 100; cnt = cnt + 1) begin
            out[cnt] = in[99-cnt];
        end
    end

endmodule

// // solution
// module top_module (
// 	input [99:0] in,
// 	output reg [99:0] out
// );
	
// 	always @(*) begin
// 		for (int i=0;i<$bits(out);i++)		// $bits() is a system function that returns the width of a signal.
// 			out[i] = in[$bits(out)-i-1];	// $bits(out) is 100 because out is 100 bits wide.
// 	end
	
// endmodule
