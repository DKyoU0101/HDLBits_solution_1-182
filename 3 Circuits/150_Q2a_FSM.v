module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 

    reg A_st, B_st, C_st, D_st;
    reg n_A, n_B, n_C, n_D;

    always @(*) begin
        n_A = ((~(|r)) & A_st) | ((~r[1]) & B_st) | ((~r[2]) & C_st) | ((~r[3]) & D_st);
        n_B = r[1] & (A_st | B_st);
        n_C = r[2] & (((~r[1]) & A_st) | C_st);
        n_D = r[3] & (((~r[1]) & (~r[2]) & A_st) | D_st);
    end

    always @(posedge clk) begin
        if(~resetn) begin
            A_st <= 1;
            B_st <= 0;
            C_st <= 0;
            D_st <= 0;
        end
        else begin
            A_st <= n_A;
            B_st <= n_B;
            C_st <= n_C;
            D_st <= n_D;
        end
    end

    always @(*) begin
        begin
            g[1] = B_st;
            g[2] = C_st;
            g[3] = D_st;
        end
    end

endmodule
