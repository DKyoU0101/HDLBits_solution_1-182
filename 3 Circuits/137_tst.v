module top_module;

    reg clk;
    reg in;
    reg reset;
    reg [8:1] out_byte;
    reg done;

    `probe(clk);
    `probe(reset);
    `probe(in);
    initial `probe_start;

    initial begin
        clk = 0;
        in = 1;
        reset = 1;
    end

    always #5 clk = ~clk;

    initial begin
        repeat(3) @(posedge clk);
        reset = 0;

        repeat(1) @(posedge clk);
        in = 0;

        repeat(8) @(posedge clk);
        repeat(1) @(posedge clk);
        in = 1;

        repeat(2) @(posedge clk);
        in = 0;
        repeat(1) @(posedge clk);

        repeat(8) @(posedge clk);
        in = 1;
        
        repeat(2) @(posedge clk);
        in = 0;

        repeat(10) @(posedge clk);
        $finish;
    end

    top_modulee top_module_u0(
        .clk(clk),
        .in(in),
        .reset(reset),    // Synchronous reset
        .out_byte(out_byte),
        .done(done)
    ); //

endmodule

module top_modulee(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Use FSM from Fsm_serial
    reg [8:1] count, data;
    reg ready, start_data, end_data, done_state;
    reg [8:1] n_count, n_data;
    reg n_ready, n_start, n_done;

    reg par_state;
    wire din, reset_p, parity;

    `probe(start_data);
    `probe(count);
    `probe(par_state);
    `probe(end_data);
    `probe(done_state);
    `probe(ready);
    `probe(din);
    `probe(reset_p);
    `probe(parity);
    `probe(done);

    always @(*) begin
        n_start = in & (start_data | ready | done_state);
        begin
            n_count[1] = (~in) & (start_data | done_state);
            n_count[8:2] = count[7:1];
        end
        n_ready = (~in) & (end_data | ready);
        n_done = (in & end_data) & parity;
        
        if(|count) begin
            case (count)
                8'b0000_0001: n_data = {data[8:2], in};
                8'b0000_0010: n_data = {data[8:3], in, data[1]};
                8'b0000_0100: n_data = {data[8:4], in, data[2:1]};
                8'b0000_1000: n_data = {data[8:5], in, data[3:1]};
                8'b0001_0000: n_data = {data[8:6], in, data[4:1]};
                8'b0010_0000: n_data = {data[8:7], in, data[5:1]};
                8'b0100_0000: n_data = {data[8], in, data[6:1]};
                8'b1000_0000: n_data = {in, data[7:1]};
            endcase
        end
        else n_data = data;
    end

    always @(posedge clk) begin
        if(reset) begin
            start_data <= 1;
            count <= 0;
            end_data <= 0;
            ready <= 0;
            done_state <= 0;
            data <= 0;
            par_state <= 0;
        end 
        else begin
            start_data <= n_start;
            count <= n_count;
            end_data <= par_state;
            ready <= n_ready;
            done_state <= n_done;
            data <= n_data;
            par_state <= count[8];
        end
    end

    assign out_byte = (done_state & parity) ? data : 0;
    assign done = (done_state & parity);

    // New: Add parity checking.

    assign din = in & ((|count) | par_state);
    assign reset_p = reset | ~((|count) | par_state | end_data);

    parity parity_u0 (
        .clk(clk),
        .reset(reset_p),
        .in(din),
        .odd(parity)
    );

endmodule

module parity (
    input clk,
    input reset,
    input in,
    output reg odd);

    always @(posedge clk)
        if (reset) odd <= 0;
        else if (in) odd <= ~odd;

endmodule