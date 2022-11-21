module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);

    reg [2:0] n_y;

    always @(*) begin
        case (y)
            3'b000: n_y = (x) ? 3'b001 : 3'b000;
            3'b001: n_y = (x) ? 3'b100 : 3'b001;
            3'b010: n_y = (x) ? 3'b001 : 3'b010;
            3'b011: n_y = (x) ? 3'b010 : 3'b001;
            3'b100: n_y = (x) ? 3'b100 : 3'b011;
            default: n_y = 1;
        endcase
    end

    assign Y0 = n_y[0];
    assign z = (y == 3'b011) | (y == 3'b100);

endmodule
