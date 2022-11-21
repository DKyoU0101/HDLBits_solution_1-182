module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 

    parameter LEFT=0, RIGHT=1, FALL_L=2, FALL_R=3;

    reg [1:0] state, next_state;

    always @(*) begin
        if(ground)
            case (state)
                LEFT: next_state = (bump_left) ? RIGHT : LEFT;
                RIGHT: next_state = (bump_right) ? LEFT : RIGHT;
                FALL_L: next_state = LEFT;
                FALL_R: next_state = RIGHT;
            endcase
    end

    always @(posedge clk, posedge areset) begin
        if(areset) state <= LEFT;
        else if(~ground) 
            if(state == LEFT | state == FALL_L) state <= FALL_L;
            else state <= FALL_R;
        else state <= next_state;
    end

    always @(posedge clk, posedge areset) begin
        if(areset) aaah <= 0;
        else if(~ground) aaah <= 1;
        else aaah <= 0;
    end

    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule
