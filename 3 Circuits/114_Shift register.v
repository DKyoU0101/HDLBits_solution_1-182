module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //

    wire [3:0] D;

    MUXDFF MUXDFF_u0 (
        .w(KEY[3]), .E(KEY[1]), .L(KEY[2]),
        .R(SW), .Q(LEDR),
        .D(D)
    );

    always @(posedge KEY[0]) begin
        LEDR <= D;
    end

endmodule


module MUXDFF (
    input w, E, L,
    input [3:0] R, Q,
    output [3:0] D
);

    wire [3:0] A;

    assign A = E ? {w, Q[3:1]} : Q;
    assign D = L ? R : A;

endmodule
