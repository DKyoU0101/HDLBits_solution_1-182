module top_module;

    reg clk;
    reg reset;
    reg data;
    reg done_counting;
    reg ack;

    initial begin
        `probe_start;
        clk = 0;
        reset = 1'bx;
        data = 1'bx;
        done_counting = 1'bx;
        ack = 1'bx;
    end

    always #5 clk = ~clk;

    initial begin
        repeat(1) @(posedge clk);

        reset = 1;
        data = 0;
        repeat(1) @(posedge clk);

        reset = 0;
        data = 1;
        repeat(1) @(posedge clk);

        data = 0;
        repeat(2) @(posedge clk);

        data = 1;
        repeat(2) @(posedge clk);

        data = 0;
        repeat(1) @(posedge clk);

        data = 1;
        repeat(1) @(posedge clk);

        data = 1'bx;
        repeat(10) @(posedge clk);

        $finish;
    end

    top_modulee top_module_u0(
        .clk(clk),
        .reset(reset),   // Synchronous reset
        .data(data),
        .done_counting(done_counting),
        .ack(ack)
    ); //

endmodule

module top_modulee (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );

    `probe(clk);
    `probe(reset);
    `probe(data);
    `probe(done_counting);
    `probe(ack);
    `probe(start_shifting);
    `probe(done_shift);
    
    `probe(shift_ena);
    `probe(counting);
    `probe(done);

    `probe(data_st);
    `probe(shift_st);
    `probe(count_st);
    `probe(done_st);

    reg data_st, shift_st, count_st, done_st;
    reg n_data, n_shift, n_count, n_done;

    reg start_shifting, done_shift, shift;
    wire recog_rst, shift_rst;

    assign recog_rst = reset | (~data_st);

    recognizer_1101 recognizer_1101_u0(
        .clk(clk),
        .reset(recog_rst),
        .data(data),
        .start_shifting(start_shifting)
    );
    
    assign shift_rst = ~shift_st;

    shift_register shift_register_u0(
        .clk(clk),
        .reset(shift_rst),
        .shift_ena(shift),
        .done_shift(done_shift)
    );

    assign shift_ena = shift & shift_st;
    assign counting = count_st;
    assign done = done_st;

    // top stage
    ///////////////////////////////////////////////////

    always @(*) begin
        n_data = ((ack) & done_st) | ((~start_shifting) & data_st);
        n_shift = ((start_shifting) & data_st) | ((~done_shift) & shift_st);
        n_count = ((done_shift) & shift_st) | ((~done_counting) & count_st);
        n_done = ((done_counting) & count_st) | ((~ack) & done_st);
    end

    always @(posedge clk) begin
        if(reset) begin
            data_st <= 1;
            shift_st <= 0;
            count_st <= 0;
            done_st <= 0;
        end
        else begin
            data_st <= n_data;
            shift_st <= n_shift;
            count_st <= n_count;
            done_st <= n_done;
        end 
    end
    ///////////////////////////////////////////////////

endmodule


module recognizer_1101 (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);

    reg none_st;
    reg [4:1] A_st;
    reg n_none;
    reg [4:1] n_A;

    always @(*) begin
        n_none = (~data) & (none_st | A_st[1] | A_st[3]);
        begin
            n_A[1] = (data) & none_st;
            n_A[2] = (data) & (A_st[1] | A_st[2]);
            n_A[3] = (~data) & A_st[2];
            n_A[4] = ((data) & A_st[3]) | A_st[4];
        end
    end

    always @(posedge clk ) begin
        if(reset) begin
            none_st <= 1;
            A_st <= 0;
        end
        else begin
            none_st <= n_none;
            A_st <= n_A;
        end
    end

    assign start_shifting = n_A[4];

endmodule

module shift_register (
    input clk,
    input reset,      // Synchronous reset
    output reg shift_ena,
    output reg done_shift);

    reg [1:0] counter;

    always @(posedge clk) begin
        if(reset) counter <= 0;
        else if(counter < 3) counter <= counter + 1;
    end

    always @(posedge clk) begin
        if(reset) shift_ena <= 1;
        else if(counter < 3) shift_ena <= 1;
        else shift_ena <= 0;
    end

    always @(posedge clk) begin
        if(reset) done_shift <= 0;
        else if(counter == 2) done_shift <= 1;
        else done_shift <= 0;
    end

endmodule
