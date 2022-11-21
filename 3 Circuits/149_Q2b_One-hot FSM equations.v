module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    parameter A=0, B=1, C=2, D=3, E=4, F=5;

    reg [5:0] n_y;

    always @(*) begin
        begin
            n_y[A] = (~w) & (y[A] | y[D]);
            n_y[B] = (w) & (y[A]);
            n_y[C] = (w) & (y[B] | y[F]);
            n_y[D] = (~w) & (y[B] | y[C] | y[E] | y[F]);
            n_y[E] = (w) & (y[C] | y[E]);
            n_y[F] = (w) & (y[D]);
        end
    end

    assign Y1 = n_y[1];
    assign Y3 = n_y[3];

endmodule
