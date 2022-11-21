module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    parameter LEFT=1'd0, RIGHT=1'd1;
    parameter WALK=2'd0, FALL=2'd1, DIG=2'd2;

    reg direction, next_dir;
    reg [1:0] state, next_state;

    always @(*) begin
        if((state == WALK) & (next_state == WALK))
            case (direction)
                LEFT: next_dir = (bump_left) ? RIGHT : LEFT;
                RIGHT: next_dir = (bump_right) ? LEFT : RIGHT;
            endcase
        else next_dir = direction;
    end

    always @(*) begin
        if(~ground) next_state = FALL;
        else if((state != FALL) & (dig | (state == DIG))) next_state = DIG;
        else next_state = WALK;
    end

    always @(posedge clk, posedge areset) begin
        if(areset) direction <= LEFT;
        else direction <= next_dir;
    end

    always @(posedge clk, posedge areset) begin
        if(areset) state <= WALK;
        else state <= next_state;
    end

    assign walk_left = (direction == LEFT) & (state == WALK);
    assign walk_right = (direction == RIGHT) & (state == WALK);
    assign aaah = (state == FALL);
    assign digging = (state == DIG);

endmodule
