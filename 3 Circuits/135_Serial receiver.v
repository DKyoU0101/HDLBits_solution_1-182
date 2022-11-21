module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output reg done
); 

    reg [8:1] count;
    reg ready, start_data, end_data;

    always @(posedge clk) begin
        if(reset) start_data <= 1;
        else start_data <= in & (start_data | ready | done);
    end

    always @(posedge clk) begin
        if(reset) count <= 0;
        else begin // -> 중요! 비트별로 나눠서 표현할때 begin end 없으면 결과 틀리게 나옴!
            count[1] <= (~in) & (start_data | done);
            count[8:2] <= count[7:1];
        end
    end

    always @(posedge clk) begin
        if(reset) end_data <= 0;
        else end_data <= count[8];
    end

    always @(posedge clk) begin
        if(reset) ready <= 0;
        else ready <= (~in) & (end_data | ready);
    end

    always @(posedge clk) begin
        if(reset) done <= 0;
        else done <= in & end_data;
    end

endmodule
