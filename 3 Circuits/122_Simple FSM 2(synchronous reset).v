module top_module(
    input clk,
    input reset,    // Synchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        case (state)
            OFF: next_state = j ? ON : OFF;
            ON: next_state = k ? OFF : ON;
        endcase // State transition logic
    end

    always @(posedge clk) begin
        if(reset) state <= OFF;
        else state <= next_state;
        // State flip-flops with synchronous reset
    end

    // Output logic
    assign out = (state == 0) ? 0 : 1; // assign out = (state == ...);

endmodule
