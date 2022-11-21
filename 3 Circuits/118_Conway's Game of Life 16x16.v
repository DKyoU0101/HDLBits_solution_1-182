module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 

    wire [(18*18-1):0] metrix_18;
    wire [(16*16-1):0] state_n;


    genvar row_18;
    genvar col_18;
    generate
        for (row_18 = 0; row_18 < 18; row_18++) begin : gen_metrix_18_row
            for (col_18 = 0; col_18 < 18; col_18++) begin : gen_metrix_18_col
                assign metrix_18[(row_18*18+col_18)] = q[((row_18+15)%16)*16 + ((col_18+15)%16)]; //?
            end
        end
    endgenerate


    genvar row_16;
    genvar col_16;
    generate
        for (row_16 = 0; row_16 < 16; row_16++) begin : gen_metrix_16_row
            for (col_16 = 0; col_16 < 16; col_16++) begin : gen_metrix_16_col
                conway conway_u0 (
                    .cells({metrix_18[(row_16*18 + col_16 + 2) : (row_16*18 + col_16)], 
                        metrix_18[((row_16+1)*18 + col_16 + 2) : ((row_16+1)*18 + col_16)], 
                        metrix_18[((row_16+2)*18 + col_16 + 2) : ((row_16+2)*18 + col_16)]}),
                    .becomes(state_n[(row_16*16 + col_16)])
                );
            end
        end
    endgenerate


    always @(posedge clk) begin
        if(load) q <= data;
        else q <= state_n;
    end

endmodule


module conway (
    input [8:0] cells,
    output becomes
);

    wire [3:0] sum;

    assign sum = cells[0] + cells[1] + cells[2] + cells[3] +
        cells[5] + cells[6] + cells[7] + cells[8];
    
    always @(*) begin
        if((sum <= 1) | (sum >= 4)) becomes = 0;
        else if(sum == 3) becomes = 1;
        else becomes = cells[4];
    end
    
endmodule