module top_module(
    input clk,
    input areset,

    input predict_valid,
    input predict_taken,
    output [31:0] predict_history,

    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

    reg [31:0] n_predict_history;

    always @(*) begin
        if(train_mispredicted) n_predict_history = {train_history[30:0], train_taken};
        else if(predict_valid) n_predict_history = {predict_history[30:0], predict_taken};
        else n_predict_history = predict_history;
    end

    always @(posedge clk, posedge areset) begin
        if(areset) predict_history <= 0;
        else predict_history <= n_predict_history;
    end

endmodule
