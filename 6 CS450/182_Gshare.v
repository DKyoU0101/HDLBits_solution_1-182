module top_module(
    input clk,
    input areset,

    input  predict_valid,
    input  [(N-1):0] predict_pc,
    output predict_taken,
    output [(N-1):0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [(N-1):0] train_history,
    input [(N-1):0] train_pc
);
    parameter N=7;
    parameter SNT=2'b00, WNT=2'b01, WT=2'b10, ST=2'b11;

    reg [1:0] pht [(2**N-1):0];
    wire [(N-1):0] index_train, index_predict;
    reg [(2**N-1):0] onehot_index_train, onehot_train_valid;


    //train
    assign index_train = train_pc ^ train_history;

    generate
        genvar i;
        for (i = 0; i < 2**N; i++) begin: onehot_index_train_0
            assign onehot_index_train[i] = (i == index_train);
        end
    endgenerate

    assign onehot_train_valid = {2**N{train_valid}} & onehot_index_train;

    counter_2bc #(.SNT(SNT), .WNT(WNT), .WT(WT), .ST(ST))
    counter_2bc_u0[(2**N-1):0] (
        .clk({2**N{clk}}),
        .areset({2**N{areset}}),
        .train_valid(onehot_train_valid),
        .train_taken({2**N{train_taken}}),
        .state(pht)
    );

    //predict
    history_shift #(.N(N)) 
    history_shift_u0(
        .clk(clk),
        .areset(areset),
        .predict_valid(predict_valid),
        .predict_taken(predict_taken),
        .train_valid(train_valid),
        .train_mispredicted(train_mispredicted),
        .train_taken(train_taken),
        .train_history(train_history),

        .predict_history(predict_history)
    );

    assign index_predict = predict_pc ^ predict_history;
    assign predict_taken = pht[index_predict][1];

endmodule


module counter_2bc #(parameter SNT=2'b00, WNT=2'b01, WT=2'b10, ST=2'b11) (
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

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


module history_shift #(parameter N = 7) (
    input clk,
    input areset,

    input predict_valid,
    input predict_taken,
    output [(N-1):0] predict_history,

    input train_valid,
    input train_mispredicted,
    input train_taken,
    input [(N-1):0] train_history
);

    reg [(N-1):0] n_predict_history;

    always @(*) begin
        if(train_valid & train_mispredicted) n_predict_history = {train_history[(N-2):0], train_taken};
        else if(predict_valid) n_predict_history = {predict_history[(N-2):0], predict_taken};
        else n_predict_history = predict_history;
    end

    always @(posedge clk, posedge areset) begin
        if(areset) predict_history <= 0;
        else predict_history <= n_predict_history;
    end

endmodule
