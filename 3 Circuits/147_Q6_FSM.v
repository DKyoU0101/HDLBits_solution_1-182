module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);

    parameter A=1, B=2, C=3, D=4, E=5, F=6;

    reg [6:1] y_st;
    reg [6:1] n_y;

    always @(*) begin
        begin
            n_y[A] = (w) & (y_st[A] | y_st[D]);
            n_y[B] = (~w) & y_st[A];
            n_y[C] = (~w) & (y_st[B] | y_st[F]);
            n_y[D] = (w) & (y_st[B] | y_st[C] | y_st[E] | y_st[F]);
            n_y[E] = (~w) & (y_st[C] | y_st[E]);
            n_y[F] = (~w) & y_st[D];
        end
    end

    always @(posedge clk) begin
        if(reset) y_st <= 6'b000_001;
        else y_st <= n_y;
    end

    assign z = y_st[E] | y_st[F];

endmodule
