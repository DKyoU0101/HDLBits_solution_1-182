module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );//

    always @(*) begin
        case ({a, b, c, d})
            4'd0 : q = 0;
            4'd1 : q = 0;
            4'd2 : q = 0;
            4'd3 : q = 0;
            4'd4 : q = 0;
            4'd5 : q = 1;
            4'd6 : q = 1;
            4'd7 : q = 1;
            4'd8 : q = 0;
            4'd9 : q = 1;
            4'd10: q = 1;
            4'd11: q = 1;
            4'd12: q = 0;
            4'd13: q = 1;
            4'd14: q = 1;
            4'd15: q = 1;
        endcase
    end

endmodule
