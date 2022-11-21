module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 

    always @(posedge clk) begin
        if(reset) ss <= 0;
        else if(ena)
            if(ss == 8'h59) ss <= 0;
            else if(ss[3:0] == 4'h9) ss <= {(ss[7:4] + 1), 4'h0};
            else ss <= ss + 1;
    end

    always @(posedge clk) begin
        if(reset) mm <= 0;
        else if(ena & (ss == 8'h59))
            if(mm == 8'h59) mm <= 0;
            else if(mm[3:0] == 4'h9) mm <= {(mm[7:4] + 1), 4'h0};
            else mm <= mm + 1;
    end

    always @(posedge clk) begin
        if(reset) hh <= 8'h12;
        else if(ena & (ss == 8'h59) & (mm == 8'h59))
            if(hh == 8'h12) hh <= 1;
            else if(hh[3:0] == 4'h9) hh <= {(hh[7:4] + 1), 4'h0};
            else hh <= hh + 1;
    end

    always @(posedge clk) begin
        if(reset) pm <= 0;
        else if(ena & (ss == 8'h59) & (mm == 8'h59) & (hh == 8'h11)) pm <= ~pm;
    end
    
endmodule
