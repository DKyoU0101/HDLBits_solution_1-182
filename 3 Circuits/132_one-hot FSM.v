module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    always @(*) begin
        if(state == 0) next_state = 0;
        // begin end 안쓰면 컴파일 에러 발생: 이유 불명
        ////////////////////
        else if(~in) begin
            next_state[0] = (|state[4:0]) | (|state[9:7]);
            next_state[7:1] = 0;
            next_state[8] = state[5];
            next_state[9] = state[6];
        end
        else begin
            next_state[0] = 0;
            next_state[1] = state[0] | state[8] | state[9];
            next_state[6:2] = state[5:1];
            next_state[7] = (|state[7:6]);
            next_state[9:8] = 0;
        end
        ////////////////////
    end

    assign out1 = (|state[9:8]);
    assign out2 = state[7] | state[9];

endmodule
