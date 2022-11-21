module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    reg A_stt, B_stt;
    reg n_A, n_B;

    always @(*) begin
        n_A = (~x) & A_stt;
        n_B = (x) | ((~x) & B_stt);
    end

    always @(posedge clk, posedge areset) begin
        if(areset) begin
            A_stt <= 1;
            B_stt <= 0;
        end
        else begin
            A_stt <= n_A;
            B_stt <= n_B;
        end
    end

    assign z = (A_stt) ? x : ~x;

endmodule
