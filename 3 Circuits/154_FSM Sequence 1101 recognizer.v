module top_module (
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

    assign start_shifting = A_st[4];

endmodule
