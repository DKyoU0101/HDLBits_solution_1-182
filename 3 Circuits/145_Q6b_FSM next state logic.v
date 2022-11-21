module top_module (
    input [3:1] y,
    input w,
    output Y2);

    parameter A=0, B=1, C=2, D=3, E=4, F=5;

    reg [3:1] n_y;

    always @(*) begin
        case (y)
            A: n_y = (w) ? A : B;
            B: n_y = (w) ? D : C;
            C: n_y = (w) ? D : E;
            D: n_y = (w) ? A : F;
            E: n_y = (w) ? D : E;
            F: n_y = (w) ? D : C;
        endcase
    end

    assign Y2 = n_y[2];

endmodule
