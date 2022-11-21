module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    parameter SNT=2'b00, WNT=2'b01, WT=2'b10, ST=2'b11;

    reg [1:0] n_state;
    always @(*) begin
        if(train_valid) begin
            case (state)
                SNT: n_state = (train_taken) ? WNT : SNT;
                WNT: n_state = (train_taken) ? WT : SNT;
                WT: n_state = (train_taken) ? ST : WNT;
                ST: n_state = (train_taken) ? ST : WT;
            endcase
        end

        else n_state = state;
    end

    always @(posedge clk, posedge areset) begin
        if(areset) state <= WNT;
        else state <= n_state;
    end

endmodule
