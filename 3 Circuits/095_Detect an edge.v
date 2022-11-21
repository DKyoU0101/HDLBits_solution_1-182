module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);

    reg [7:0] shift_in;

    always @(posedge clk) begin
        shift_in <= in;
    end

    always @(posedge clk) begin
        pedge <= (in ^ shift_in) & in;
    end

endmodule



// 0 0 1 1 0 0 //in
// 0 0 0 1 1 0 //shift_in
// 0 0 1 0 1 0 //XOR
// 0 0 1 0 0 0 //in & XOR

// 0 0 1 0 0 0 //goal

// 1 1 0 0 1 1 //in
// 1 1 1 0 0 1 //shift_in
// 0 0 1 0 1 0 //XOR
// 0 0 0 0 1 0 //in & XOR

// 0 0 0 0 1 0 //goal

// // solution
// module top_module(
// 	input clk,
// 	input [7:0] in,
// 	output reg [7:0] pedge);
	
// 	reg [7:0] d_last;	
			
// 	always @(posedge clk) begin
// 		d_last <= in;			// Remember the state of the previous cycle
// 		pedge <= in & ~d_last;	// A positive edge occurred if input was 0 and is now 1.
// 	end
	
// endmodule

// // 0 0 1 1 0 0 //in
// // 0 0 0 1 1 0 //shift_in
// // 1 1 1 0 0 1 //~shift_in
// // 0 0 1 0 0 0 //in & ~shift_in

// // 0 0 1 0 0 0 //goal