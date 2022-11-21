module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 

    reg A_st, E_st;
    reg [3:1] C_st;
    reg [2:1] B_st, D_st;
    reg n_A, n_E;
    reg [3:1] n_C;
    reg [2:1] n_B, n_D;

    reg A_shift;

    always @(*) begin
        n_A = 0;
        begin
            n_B[1] = A_st;
            n_B[2] = B_st[1] | ((~x) & (B_st[2] | C_st[2]));
        end
        begin
            n_C[1] = (x) & (B_st[2] | C_st[1]);
            n_C[2] = (~x) & C_st[1];
            n_C[3] = (x) & C_st[2];
        end
        begin
            n_D[1] = (~y) & C_st[3];
            n_D[2] = ((~y) & D_st[1]) | D_st[2];
        end
        n_E = ((y) & (C_st[3] | D_st[1])) | E_st;
    end

    always @(posedge clk) begin
        if(~resetn) begin
            A_st <= 1;
            B_st <= 0;
            C_st <= 0;
            D_st <= 0;
            E_st <= 0;
        end
        else begin
            A_st <= n_A;
            B_st <= n_B;
            C_st <= n_C;
            D_st <= n_D;
            E_st <= n_E;
        end
    end

    assign f = B_st[1];
    assign g = C_st[3] | D_st[1] | E_st;

endmodule
