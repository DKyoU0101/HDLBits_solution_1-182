module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //

    wire [3:0] counter0_Q, counter1_Q, counter2_Q;

    assign c_enable[0] = ~reset;
    assign c_enable[1] = (c_enable[0]) & (counter0_Q == 4'd9);
    assign c_enable[2] = (c_enable[1]) & (counter1_Q == 4'd9);
    assign OneHertz =    (c_enable[2]) & (counter2_Q == 4'd9);

    bcdcount counter0 (.clk(clk), .reset(reset), .enable(c_enable[0]), .Q(counter0_Q));
    bcdcount counter1 (.clk(clk), .reset(reset), .enable(c_enable[1]), .Q(counter1_Q));
    bcdcount counter2 (.clk(clk), .reset(reset), .enable(c_enable[2]), .Q(counter2_Q));

endmodule
