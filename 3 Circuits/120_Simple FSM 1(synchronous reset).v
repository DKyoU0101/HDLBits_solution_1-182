// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  

    parameter A=0, B=1; // Fill in state name declarations

    reg present_state, next_state;

    always @(*) begin
        case (present_state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
        endcase
    end

    always @(posedge clk) begin
        if(reset) present_state <= B;
        else present_state <= next_state;
    end

    assign out = (present_state == 1);

endmodule
