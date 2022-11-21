module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);

    parameter A=1, B=2, C=3, D=4, E=5, F=6;

    reg [6:1] n_y;

    always @(*) begin
        begin
            n_y[A] = (w) & (y[A] | y[D]);
            n_y[B] = (~w) & y[A];
            n_y[C] = (~w) & (y[B] | y[F]);
            n_y[D] = (w) & (y[B] | y[C] | y[E] | y[F]);
            n_y[E] = (w) & (y[C] | y[E]);
            n_y[F] = (w) & y[D];
        end
    end

    assign Y2 = n_y[2];
    assign Y4 = n_y[4];


endmodule
