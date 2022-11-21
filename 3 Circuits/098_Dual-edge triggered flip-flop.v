module top_module (
    input clk,
    input d,
    output q
);

    reg q_pos;
    reg q_neg;

    always @(posedge clk) begin
        q_pos <= d;
    end

    always @(negedge clk) begin
        q_neg <= d;
    end

    assign q = clk ? q_pos : q_neg;

    // 01 00 11 01 00 11 10 d

    // 00 00 11 00 00 11 11 pos
    //  1 10 01 11 10 01 10 neg
    // 10 10 10 10 10 10 10 clk

    // 01 00 11 01 00 ..

    //  0 10 01 10 10 01 11 goal

endmodule


// // solution
// module top_module(
// 	input clk,
// 	input d,
// 	output q);
	
// 	reg p, n;
	
// 	// A positive-edge triggered flip-flop
//     always @(posedge clk)
//         p <= d ^ n;
        
//     // A negative-edge triggered flip-flop
//     always @(negedge clk)
//         n <= d ^ p;
    
//     // Why does this work? 
//     // After posedge clk, p changes to d^n. Thus q = (p^n) = (d^n^n) = d.
//     // After negedge clk, n changes to d^p. Thus q = (p^n) = (p^d^p) = d.
//     // At each (positive or negative) clock edge, p and n FFs alternately
//     // load a value that will cancel out the other and cause the new value of d to remain.
//     assign q = p ^ n;
    
    
// 	// Can't synthesize this.
// 	/*always @(posedge clk, negedge clk) begin
// 		q <= d;
// 	end*/
    
    
// endmodule
