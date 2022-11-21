module top_module ( input clk, input d, output q );

wire q1;
wire q2;

my_dff my_dff_u1 (.clk(clk), .d(d), .q(q1));
my_dff my_dff_u2 (.clk(clk), .d(q1), .q(q2));
my_dff my_dff_u3 (.clk(clk), .d(q2), .q(q));

endmodule
