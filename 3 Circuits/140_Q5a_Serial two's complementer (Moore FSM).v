module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    reg buf0_stt, buf1_stt, not0_stt, not1_stt;
    reg n_buf0, n_buf1, n_not0, n_not1;

    always @(*) begin
        n_buf0 = (~x) & buf0_stt;
        n_buf1 = (x) & buf0_stt;
        n_not0 = (x) & (buf1_stt | not0_stt | not1_stt);
        n_not1 = (~x) & (buf1_stt | not0_stt | not1_stt);
    end

    always @(posedge clk, posedge areset) begin
        if(areset) begin
            buf0_stt <= 1;
            buf1_stt <= 0;
            not0_stt <= 0;
            not1_stt <= 0;
        end
        else begin
            buf0_stt <= n_buf0;
            buf1_stt <= n_buf1;
            not0_stt <= n_not0;
            not1_stt <= n_not1;
        end
    end

    assign z = (buf1_stt | not1_stt);

endmodule
