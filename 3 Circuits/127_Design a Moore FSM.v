module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 

    parameter ON=1, OFF=0;

    reg [3:1] shift;

    always @(posedge clk) begin
        if(reset) begin
            fr1 <= ON;
            fr2 <= ON;
            fr3 <= ON;
        end
        else if(s == 3'b000) begin
            fr1 <= ON;
            fr2 <= ON;
            fr3 <= ON;
        end
        else if(s == 3'b001) begin
            fr1 <= ON;
            fr2 <= ON;
            fr3 <= OFF;
        end
        else if(s == 3'b011) begin
            fr1 <= ON;
            fr2 <= OFF;
            fr3 <= OFF;
        end
        else if(s == 3'b111) begin
            fr1 <= OFF;
            fr2 <= OFF;
            fr3 <= OFF;
        end
    end

    always @(posedge clk) begin
        if(reset) shift <= OFF;
        else shift <= s;
    end

    always @(posedge clk) begin
        if(reset) dfr <= ON;
        else if(s > shift) dfr <= OFF;
        else if(s < shift) dfr <= ON;
    end

endmodule
