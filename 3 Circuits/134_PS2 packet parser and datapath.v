module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
    reg [3:1] byt, n_byt;
    reg [23:0] data;

    always @(*) begin
        n_byt[3] = byt[2];
        n_byt[2] = (in[3]) ? (byt[1] | done) : 0;        
        n_byt[1] = (~in[3]) ? (byt[1] | done) : 0;        
    end

    always @(posedge clk) begin
        if(reset) byt <= 3'b001;
        else byt <= n_byt;
    end

    always @(posedge clk) begin
        if(reset) done <= 0;
        else if(byt[3]) done <= 1;
        else done <= 0;
    end

    // New: Datapath to store incoming bytes.
    always @(posedge clk) begin
        if(reset) data <= 0;
        else if(byt[3]) data[7:0] <= in;
        else if(byt[2]) data[15:8] <= in;
        else data[23:16] <= in;
    end

    assign out_bytes = (done) ? data : 0;

endmodule
