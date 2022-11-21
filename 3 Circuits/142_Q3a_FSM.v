module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);

    reg A_stt, B_stt, B1_stt, B2_stt, B3_stt;
    reg n_A, n_B, n_B1, n_B2, n_B3;
    reg [1:0] count;

    always @(*) begin
        n_A = (~s) & A_stt;
        n_B = (s) & A_stt;
        n_B1 = B_stt | B3_stt;
        n_B2 = B1_stt;
        n_B3 = B2_stt;
    end

    always @(posedge clk) begin
        if(reset) begin
            A_stt <= 1;
            B_stt <= 0;
            B1_stt <= 0;
            B2_stt <= 0;
            B3_stt <= 0;
        end
        else begin
            A_stt <= n_A;
            B_stt <= n_B;
            B1_stt <= n_B1;
            B2_stt <= n_B2;
            B3_stt <= n_B3;
        end
    end

    always @(posedge clk) begin
        if(reset) count <= 0;
        else if(A_stt | ((~w) & B3_stt)) count <= 0;
        else if((w) & B3_stt) count <= 1;
        else if(w) count <= count + 1;
    end

    assign z = B3_stt & (count == 2);

endmodule
