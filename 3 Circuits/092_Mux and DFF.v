module top_module (
    input clk,
    input w, R, E, L,
    output Q
);

    wire mux_out;
    wire D;

    multiplexer multiplexer_u0 (.a(Q), .b(w), .sel(E), .o(mux_out));
    multiplexer multiplexer_u1 (.a(mux_out), .b(R), .sel(L), .o(D));
    FF FF_u0 (.clk(clk), .d(D), .q(Q));

endmodule

module FF (
    input clk,
    input d,
    output q
);

    always @(posedge clk) begin
        q <= d;
    end
    
endmodule


module multiplexer (
    input a, b, sel,
    output o
);

    assign o = sel ? b : a;
    
endmodule
