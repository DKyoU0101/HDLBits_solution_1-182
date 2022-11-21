module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
); //

    // You may use these parameters to access state bits using e.g., state[B2] instead of state[6].
    parameter S=0, S1=1, S11=2, S110=3, B0=4, B1=5, B2=6, B3=7, Count=8, Wait=9;

    reg S11_next, S111_next, B0_next, B1_next, B2_next;

    always @(*) begin
        S_next = ((~d) & (state[S] | state[S1] | state[S110])) | ((ack) & state[Wait]);
        S1_next = (d) & state[S];
        S11_next = (d) & (state[S1] | state[S11]);
        S111_next = (~d) & state[S11];

        B0_next = (d) & state[S110];
        B1_next = state[B0];
        B2_next = state[B1];
        B3_next = state[B2];

        Count_next = state[B3] | ((~done_counting) & state[Count]);
        Wait_next = ((done_counting) & state[Count]) | ((~ack) & state[Wait]);
    end

    assign done = state[Wait];
    assign counting = state[Count];
    assign shift_ena = (|state[B3:B0]);

endmodule
