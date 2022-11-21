module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);

    reg [1:0] counter;

    always @(posedge clk) begin
        if(reset) counter <= 0;
        else if(counter < 3) counter <= counter + 1;
    end

    always @(posedge clk) begin
        if(reset) shift_ena <= 1;
        else if(counter < 3) shift_ena <= 1;
        else shift_ena <= 0;
    end

endmodule
