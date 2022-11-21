// synthesis verilog_input_version verilog_2001
module top_module (
    input [7:0] in,
    output reg [2:0] pos );

    always @(*) begin
        casez (in)
            8'bzzzz_zzz1: pos = 8'd0; 
            8'bzzzz_zz1z: pos = 8'd1; 
            8'bzzzz_z1zz: pos = 8'd2; 
            8'bzzzz_1zzz: pos = 8'd3; 
            8'bzzz1_zzzz: pos = 8'd4; 
            8'bzz1z_zzzz: pos = 8'd5; 
            8'bz1zz_zzzz: pos = 8'd6; 
            8'b1zzz_zzzz: pos = 8'd7; 
            default: pos = 8'd0;
        endcase
    end

endmodule
