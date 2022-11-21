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

    parameter WALK=2'b00, FALL=2'b01, DIG=2'b10, SPLAT=2'b11;
    parameter LEFT=1'b0, RIGHT=1'b1;

    reg [1:0] state, n_state;
    reg direction, n_dir;
    reg [4:0] fall_cnt;
    reg splatter;

    always @(*) begin
        if(splatter) n_state = SPLAT;
        else if(~ground) n_state = FALL;
        else if((state != FALL) & (dig | (state == DIG))) n_state = DIG;
        else n_state = WALK;
    end

    always @(*) begin
        if((state == WALK) & (n_state == WALK))
            case (direction)
                LEFT: n_dir = (bump_left) ? RIGHT : LEFT;
                RIGHT: n_dir = (bump_right) ? LEFT : RIGHT;
            endcase
        else n_dir = direction;
    end

    always @(posedge clk, posedge areset) begin
        if(areset) state <= LEFT;
        else state <= n_state;
    end

    always @(posedge clk, posedge areset) begin
        if(areset) direction <= WALK;
        else direction <= n_dir;
    end

    always @(posedge clk, posedge areset) begin
        if(areset) fall_cnt <= 0;
        else if(fall_cnt != 21)
            if(n_state == FALL) fall_cnt <= fall_cnt + 1;
            else fall_cnt <= 0;
    end

    always @(posedge clk, posedge areset) begin
        if(areset) splatter <= 0;
        else if((fall_cnt == 21) & (ground)) splatter <= 1;
    end

    assign walk_left = (state == WALK) & (direction == LEFT) & (splatter == 0);
    assign walk_right = (state == WALK) & (direction == RIGHT) & (splatter == 0);
    assign aaah = (state == FALL);
    assign digging = (state == DIG);

endmodule
