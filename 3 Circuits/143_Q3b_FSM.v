module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);

    reg [2:0] y_st;
    reg [2:0] n_y;

    always @(*) begin
        case (y_st)
            3'b000: n_y = (x) ? 3'b001 : 3'b000;
            3'b001: n_y = (x) ? 3'b100 : 3'b001;
            3'b010: n_y = (x) ? 3'b001 : 3'b010;
            3'b011: n_y = (x) ? 3'b010 : 3'b001;
            3'b100: n_y = (x) ? 3'b100 : 3'b011;
        endcase
    end

    always @(posedge clk) begin
        if(reset) y_st <= 0;
        else y_st <= n_y;
    end

    assign z = (y_st == 3'b011) | (y_st == 3'b100);

endmodule
