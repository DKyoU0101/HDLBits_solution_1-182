module top_module;

    reg clk;
    reg in;
    reg reset;

    initial begin
        `probe_start;
        clk = 0;
        reset = 1;
        in = 0;
    end

    always #5 clk = ~clk;

    initial begin
        repeat(2) @(posedge clk);
        reset = 0;
        in = 1;

        repeat(8) @(posedge clk);
        reset = 1;
        in = 0;

        repeat(1) @(posedge clk);
        reset = 0;
        in = 1;

        repeat(3) @(posedge clk);
        $finish;
    end

    top_modulee top_module_u0(
        .clk(clk),
        .in(in),
        .reset(reset)   // Synchronous reset
    ); //

endmodule

module top_modulee(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);

    `probe(clk);
    `probe(reset);
    `probe(in);
    `probe(ready_stt);
    `probe(data_stt);
    `probe(disc_stt);
    `probe(flag_stt);
    `probe(err_stt);

    reg ready_stt, disc_stt, flag_stt, err_stt;
    reg [6:1] data_stt;
    reg n_ready, n_disc, n_flag, n_err;
    reg [6:1] n_data;

    always @(*) begin
        n_ready = (~in) & (ready_stt | (|data_stt[4:1]) | disc_stt | flag_stt | err_stt);
        begin
            n_data[1] = (in) & (ready_stt | disc_stt | flag_stt);
            n_data[6:2] = {5{(in)}} & data_stt[5:1];
        end
        n_disc = (~in) & data_stt[5];
        n_flag = (~in) & data_stt[6];
        n_err = (in) & (data_stt[6] | err_stt);
    end

    always @(posedge clk) begin
        if(reset) begin
            ready_stt <= 1;
            data_stt <= 0;
            disc_stt <= 0;
            flag_stt <= 0;
            err_stt <= 0;
        end
        else begin
            ready_stt <= n_ready;
            data_stt <= n_data;
            disc_stt <= n_disc;
            flag_stt <= n_flag;
            err_stt <= n_err;
        end
    end

    assign disc = disc_stt;
    assign flag = flag_stt;
    assign err = err_stt;

endmodule
